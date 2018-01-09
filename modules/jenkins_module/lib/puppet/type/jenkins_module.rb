Puppet::Type.newtype(:jenkins_module) do
  ensurable
  newparam(:name, :namevar => true) do
  end
  newproperty(:deps) do
    validate do |value|
      puts "For :deps we got #{value}"
    end
  end
  newproperty(:hat) do
    validate do |value|
      puts "For :hat we got #{value}"
    end
  end
  newproperty(:version) do
  end
end
