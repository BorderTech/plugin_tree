Puppet::Type.newtype(:plugin_tree) do

  ensurable

  newparam(:name, :namevar => true) do
  end

  newproperty(:plugin) do
    validate do |value|
      puts "For :plugin we got #{value}"
    end
  end

 newproperty(:source) do
    validate do |value|
      puts "For :source we got #{value}"
    end
 end

 newproperty(:source_path) do
    validate do |value|
      puts "For :source_path we got #{value}"
    end
 end
 
 newproperty(:dest_path) do
    validate do |value|
      puts "For :dest_path we got #{value}"
    end
 end
 
end
