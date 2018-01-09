Puppet::Type.newtype(:testing_type) do
 ensurable
  newparam(:name, :namevar => true) do
  end
newproperty(:deps) do
    validate do |value|
      puts "For :deps we got #{value}"
    end
  end

end

