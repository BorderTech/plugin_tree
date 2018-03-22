Puppet::Type.newtype(:jenkins_plugins) do
  ensurable

  newparam(:name, namevar: true) do
  end

  newproperty(:plugins) do
    validate do |value|
    end
  end

  newproperty(:source) do
    validate do |value|
    end
  end

  newproperty(:source_path) do
    validate do |value|
    end
  end

  newproperty(:dest_path) do
    validate do |value|
    end
  end

  newproperty(:owner) do
    validate do |value|
    end
  end

  newproperty(:group) do
    validate do |value|
    end
  end
end
