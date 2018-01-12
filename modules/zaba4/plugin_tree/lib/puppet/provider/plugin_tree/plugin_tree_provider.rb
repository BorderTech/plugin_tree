
#find local ruby
#which ruby
#ruby --version
#gem list

#find puppet ruby info
#facter rubysitedir rubyversion
#sudo /opt/puppetlabs/puppet/bin/gem

require 'net/http'
#gem list; /opt/puppetlabs/puppet/bin/gem install rubyzip
require 'zip'

Puppet::Type.type(:plugin_tree).provide(:plugin_tree_provider) do

  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def download(name,version)
    Net::HTTP.start("#{resource[:source]}") do |http|
        resp = http.get("#{resource[:source_path]}/#{name}/#{version}/#{name}.hpi")
        open("#{resource[:dest_path]}/#{name}.hpi", "wb") do |file|
            file.write(resp.body)
        end
    end
    puts "#{resource[:dest_path]}/#{name}.hpi      #{version}"
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
      if (not @processedAlready.include?(child))
        puts "step 2 #{child}"
          #values = child.split(":")
          values = (child.split(/;/).first).split(":")
          depName = values[0]
          depVersion = values[1]
          download(depName, depVersion)
          extract_zip("#{resource[:dest_path]}/#{depName}.hpi", "#{resource[:dest_path]}/#{depName}_unzip")
          theseDep = listDependencies("#{depName}") 
          @processedAlready.push (child)
        
        
          if not (@hashOfFinalDependences.key?(depName))
          
            @hashOfFinalDependences[depName] = depVersion          
          else  
          
            currentVersion = @hashOfFinalDependences[depName]
           
            #get latest version
            if Gem::Version.new(currentVersion) < Gem::Version.new(depVersion)
            
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
          puts "#{dpName}:#{dpVersion}"   
  
        end
          puts "======================= finished =================="         
        
    @property_flush[:ensure] = :present
end
    
  ##############################
  def destroy
    puts "I am in destroy"
    @property_flush[:ensure] = :absent
  end

  def exists?
    puts "I am in exists?"
    @property_hash[:ensure] == :present
  end


end

