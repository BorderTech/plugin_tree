Puppet::Type.type(:testing_type).provide(:testing_provider) do

  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def download(name,version)
    plugin_name = name
    plugin_version = version
    
    Net::HTTP.start("mirrors.shuosc.org") do |http|
      resp = http.get("/jenkins/plugins/#{plugin_name}/#{plugin_version}/#{plugin_name}.hpi")
      open("#{plugin_name}.hpi", "wb") do |file|
        file.write(resp.body)
      end
    end
    puts "Pluging: #{plugin_name}  Version: #{plugin_version}"
  end

  def create
    puts "I am in create"
    puts "I have :deps #{resource[:deps]}"

    resource[:deps].each do |key, value|
     download(key, value)
    end
    
    #install(resource[:deps])

    @property_flush[:ensure] = :present
  end

  def destroy
    puts "I am in destroy"
    @property_flush[:ensure] = :absent
  end

  def exists?
    puts "I am in exists?"
    @property_hash[:ensure] == :present
  end


end

