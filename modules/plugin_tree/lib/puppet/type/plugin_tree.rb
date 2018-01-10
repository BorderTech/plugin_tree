Puppet::Type.newtype(:plugin_tree) do

  ensurable

  newparam(:name, :namevar => true) do
  end

  newproperty(:plugin) do
    validate do |value|
      puts "For :deps we got #{value}"
    end
  end

 newproperty(:path) do
 end

end

