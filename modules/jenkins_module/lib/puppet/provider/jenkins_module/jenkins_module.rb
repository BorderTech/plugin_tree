require 'net/http'

Puppet::Type.type(:jenkins_module).provide(:jenkins_module) do

  mk_resource_methods

  puts "I am alive"
  #  puts "I am created #{resource[:name]}"
  def install(deps)
    puts "I am created #{resource[:name]}"
    puts "I have #{resource[:deps]}"
    puts "I should install #{deps}"
    mydeps = resource[:deps]
    puts "I should install from var #{mydeps}"

  end
  puts "I want to run install "

  def self.instances 
    puts "I am in self.instances"
    install() 
  end

  def self.prefetch(resources) 
    puts "I am in self.prefetch"
    puts "Overall #{@property_hash}"
    puts "I have :name #{resources[:name]}"
    puts "I have :hat #{resources[:hat]}"
    puts "I have :deps #{resources[:deps]}"
    
  end

  def initialize(value={})
    super(value)
    puts "I am in initialize"
    @property_hash[:key] = "lock"
    puts "Overall #{@property_hash}"
    puts "I have :name #{resource[:name]}"
    puts "I have :hat #{@property_hash[:hat]}"
    puts "I have :deps #{resource[:deps]}"
    
    install(resource[:deps]) 
    @property_flush = {}
  end

  

  def create
    puts "I am in create"
    puts "I have :name #{resource[:name]}"
    puts "I have :hat #{resource[:hat]}"
    puts "I have :deps #{resource[:deps]}"

    install(resource[:deps]) 
    
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

