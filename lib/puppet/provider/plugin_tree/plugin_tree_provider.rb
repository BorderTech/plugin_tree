
#find local ruby
#which ruby
#ruby --version
#gem list

#find puppet ruby info
#facter rubysitedir rubyversion
#sudo /opt/puppetlabs/puppet/bin/gem

require 'net/http'
require_relative 'plugin_tree_version.rb'
#gem list; /opt/puppetlabs/puppet/bin/gem install rubyzip

$LOAD_PATH.unshift '/home/ze78rm/modules/plugin_tree/files'
#$LOAD_PATH.unshift '/tmp/files'
require 'zip'




Puppet::Type.type(:plugin_tree).provide(:plugin_tree_provider) do

  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def download(name,version)
    owner = "#{resource[:owner]}"
    group = "#{resource[:group]}"
    Net::HTTP.start("#{resource[:source]}") do |http|
        resp = http.get("#{resource[:source_path]}/#{name}/#{version}/#{name}.hpi")
        open("#{resource[:dest_path]}/#{name}.hpi", "wb") do |file|
            file.write(resp.body)
        end
    end
    puts "#{resource[:dest_path]}/#{name}.hpi      #{version}"
    #  make local teee for all hpi in main list
    # destination = "/tmp/plugins/#{name}/#{version}"
    # destination = "/tmp/bo_plugins/#{name}/#{version}" 
    # FileUtils.mkdir_p(destination)
    # FileUtils.copy("#{resource[:dest_path]}/#{name}.hpi", "#{destination}" )
    
    #change owner for all .hpi files
     FileUtils.chown owner, group, "#{resource[:dest_path]}/#{name}.hpi"

   
  end

  def extract_zip(file, destination)

    FileUtils.rm_rf(destination)
    FileUtils.mkdir_p(destination)
    Zip::File.open(file) do |zip_file|
      zip_file.each do |f|
        fpath = File.join(destination, f.name)
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
    puts "Destination: #{destination}"
  end
  
  def listDependencies (dep_name)
    puts "#{resource[:dest_path]}/#{dep_name}_unzip/META-INF/MANIFEST.MF"
    f = IO.read("#{resource[:dest_path]}/#{dep_name}_unzip/META-INF/MANIFEST.MF")
    #Delete unzip folder
    FileUtils.rm_rf("#{resource[:dest_path]}/#{dep_name}_unzip")
    
    if f.include? "Plugin-Dependencies: "
      array = ((f.split("Plugin-Dependencies: ")[1].split("Plugin-Developers: ")[0]).delete("\r\n ")).split(",")
      return array
    else
      return []
    end
  end
  def listAllDependencies (theseDep)
     
    theseDep.each do | child |
       puts "step 1"
       
       values = (child.split(/;/).first).split(":")
       depName = values[0]
       depVersion = values[1]

	h = Hat.new 
	h.write "what the ??"
       if PluginTreeVersion.new(resource[:plugin][depName]) > PluginTreeVersion.new(depVersion)
         puts "Upgradgin from #{depVersion} to #{resource[:plugin][depName]}"
         depVersion = resource[:plugin][depName]
       end

       currentVersion = @hashOfFinalDependences[depName]
       
       puts "IN FINAL #{currentVersion}"
       puts  PluginTreeVersion.new(currentVersion) < PluginTreeVersion.new(depVersion)
       
       if ((not @processedAlready.include?(child) and currentVersion == nil) or PluginTreeVersion.new(currentVersion) < PluginTreeVersion.new(depVersion) )
         
         puts "step 2 #{child}"
         #values = child.split(":")
         download(depName, depVersion)
         extract_zip("#{resource[:dest_path]}/#{depName}.hpi", "#{resource[:dest_path]}/#{depName}_unzip")
         theseDep = listDependencies("#{depName}") 
         
         @processedAlready.push (child)
        
         if not (@hashOfFinalDependences.key?(depName))
           @hashOfFinalDependences[depName] = depVersion          
         else  
          
           currentVersion = @hashOfFinalDependences[depName]
           
          #get latest version
          
          if PluginTreeVersion.new(currentVersion) < PluginTreeVersion.new(depVersion)
            puts "updating version of #{depName} from #{currentVersion} to #{depVersion}"
            
            @hashOfFinalDependences[depName] = depVersion
          
          else
            
            puts "Old Version detected #{depName}:#{depVersion} keeping #{currentVersion}"
          end  
        end  
        listAllDependencies(theseDep)   
      end
    end  
  end  
  
  
##############################
def create
    puts "I am in create"
    puts "source variable is #{resource[:source]}"
    puts "source_path variable is #{resource[:source_path]}"
    puts "dest_path variable is #{resource[:dest_path]}"
    @processedAlready = []
    @hashOfFinalDependences = {}
    @source = resource[:source]
    @source_path = resource[:source_path]
    @dest_path = resource[:source_path]
    
       File.open("#{resource[:dest_path]}/last_req.txt", "w") do |f|
         f.puts(resource[:plugin])
       end
      resource[:plugin].each do |key, value|
        
        @hashOfFinalDependences[key] = value
        
        download(key, value)
        extract_zip("#{resource[:dest_path]}/#{key}.hpi", "#{resource[:dest_path]}/#{key}_unzip/")
        
        theseDep = listDependencies ("#{key}")
        puts "=========================================" 
        theseDep.each do |depPair|
          puts depPair 
        end  
        puts "=========================================="
        listAllDependencies(theseDep)
      end
        
      puts "======================= finished =================="  
      @hashOfFinalDependences.each do |dpName, dpVersion|

      @last_run = @last_run.to_s + "#{dpName}:#{dpVersion},"   
      puts "#{dpName}:#{dpVersion}"
 
     end
      
      puts "======================= finished =================="         
     
      puts @last_run.split(",")

       File.open("#{resource[:dest_path]}/last_run.txt", "w") do |f|     
         f.puts(@last_run.split(","))   
       end

      @property_flush[:ensure] = :present
    end
    
  ##############################
  def destroy
    puts "I am in destroy"
    @property_flush[:ensure] = :absent
  end

  def exists?
    puts "I am in exists?"
    puts "Do I have last_run.txt file: #{File.file?("#{resource[:dest_path]}/last_run.txt")}" 
    puts "Do I have last_req.txt file: #{File.file?("#{resource[:dest_path]}/last_req.txt")}"
    
    
    
    # If files not exist go to def create
    if not File.file?("#{resource[:dest_path]}/last_req.txt") && File.file?("#{resource[:dest_path]}/last_run.txt")
	    #if has to retun 'false' to go directly to 'def create'
      puts File.file?("#{resource[:dest_path]}/last_req.txt") && File.file?("#{resource[:dest_path]}/last_run.txt")
      File.file?("#{resource[:dest_path]}/last_req.txt") && File.file?("#{resource[:dest_path]}/last_run.txt")
    else
      @requested = resource[:plugin]
      @hash_from_last_run =  Hash[*File.read("#{resource[:dest_path]}/last_run.txt").split(/[: \n]+/) ]
      @hash_from_last_req =  eval File.read("#{resource[:dest_path]}/last_req.txt")

      puts "from last_run: #{@hash_from_last_run}"
      puts "from last_req: #{@hash_from_last_req}"

      puts "from type: #{@requested}"
      if @requested == @hash_from_last_req
        puts "Are the hashes same: #{@requested == @hash_from_last_req}"
	@requested == @hash_from_last_req
        else

          #if has to retun 'false' to go directly to 'def create'
         File.open("#{resource[:dest_path]}/last_req.txt", "w") do |f|
	   f.write(resource[:plugin])
         end


      puts "from last_req after: #{eval File.read("#{resource[:dest_path]}/last_req.txt")}"

      @requested == @hash_from_last_run      
        end
      end

    #if (@hash_from_last_req.size > @requested.size)
    #  @diff = @hash_from_last_req.to_a - @requested.to_a
    #else
    #  @diff = @requested.to_a - @hash_from_last_req.to_a
    #end
    #puts "What is different: #{Hash[*@diff.flatten]}"
    #puts
   
#   puts not File.file?("#{resource[:dest_path]}/last_run.txt") && not File.file?("#{resource[:dest_path]}/last_run.txt")

# false if 0 text files
# false if req != last req
# false if last_run doesn't match disk



#@property_hash[:ensure] == :present
#  puts File.file? '/var/lib/jenkins/plugins/ant.hpi'
#  File.file? '/var/lib/jenkins/plugins/ant.hpi'
  end


end


