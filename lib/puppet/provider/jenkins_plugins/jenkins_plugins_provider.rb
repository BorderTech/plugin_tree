$LOAD_PATH.unshift(File.expand_path('../../../ruby',__dir__))

require 'jenkins_plugins'
require 'zip'
require 'digest/sha2'
require 'net/http'

def update_last_requested_plugins
  File.open("#{resource[:dest_path]}/last_req.txt", 'w') do |f|
    f.write(resource[:plugins])
  end
end

def hash_changed?
  @requested = plugins
  @hash_from_last_req = eval File.read("#{resource[:dest_path]}/last_req.txt")

  return false if @requested == @hash_from_last_req

  update_last_requested_plugins
  true
end

def first_run?
  @jenkins_plugins.first_run?"#{dest_path}/last_req.txt"
end

def set_file_permissions(name)
  FileUtils.chown owner, group, "#{dest_path}/#{name}.hpi"
end

def delete_unzip_folder(dependcy_name)
  FileUtils.rm_r("#{dest_path}/#{dependcy_name}_unzip")
end

def current_version_smaller?(current_version, dependency_version)
  Gem::Version.new(current_version) < Gem::Version.new(dependency_version)
end

Puppet::Type.type(:jenkins_plugins).provide(:jenkins_plugins_provider) do

  def initialize(value = {})
    super(value)
    @property_flush = {}
    @jenkins_plugins = JenkinsPlugins.new
  end

  def download(name, version)
    Net::HTTP.start source do |http|
      resp = http.get("#{source_path}/#{name}/#{version}/#{name}.hpi")
      open("#{dest_path}/#{name}.hpi", 'wb') do |file|
        file.write(resp.body)
      end
    end
    set_file_permissions(name)
  end

  def unzip_plugin_file(file, destination)
    FileUtils.rm_rf(destination)
    FileUtils.mkdir_p(destination)
    Zip::File.open(file) do |zip_file|
      zip_file.each do |f|
        fpath = File.join(destination, f.name)
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
  end

  def dependencies_for (dependency_name)
    dependency_manifest_file_name = "#{dest_path}/#{dependency_name}_unzip/META-INF/MANIFEST.MF"
    dependency_manifest = IO.read(dependency_manifest_file_name)
    # todo 2018-03-13 tre: This shall be reviewed. Deletion shall happen once and only if needed;
    # leave as is for now
    delete_unzip_folder(dependency_name)
    return [] unless dependency_manifest.include? 'Plugin-Dependencies: '
    (dependency_manifest.split('Plugin-Dependencies: ')[1].split('Plugin-Developers: ')[0]).delete("\r\n ").split(',')
  end

  def list_all_dependencies (dependencies)
    # puts "List All Dependencies\t#{dependencies}"
    dependencies.each do |dependency|
      values = dependency.split(/;/).first.split(':')
      dependency_name = values[0]
      dependency_version = values[1]
      version_string = plugins[dependency_name]

      if Gem::Version.new(version_string) > Gem::Version.new(dependency_version)
        puts "Upgrading #{dependency_name.ljust(37)} from #{dependency_version.ljust(12)} to #{version_string}"
        dependency_version = version_string
      end

      current_version = @hash_of_final_dependencies[dependency_name]

      if !@processed_already.include?(dependency) && current_version == nil || current_version_smaller?(current_version, dependency_version)
        download(dependency_name, dependency_version)
        unzip_plugin_file("#{dest_path}/#{dependency_name}.hpi", "#{dest_path}/#{dependency_name}_unzip")
        dependencies = dependencies_for dependency_name

        @processed_already.push dependency

        if not (@hash_of_final_dependencies.key?(dependency_name))
          @hash_of_final_dependencies[dependency_name] = dependency_version
        else
          current_version = @hash_of_final_dependencies[dependency_name]
          if current_version_smaller?(current_version, dependency_version)
            puts "Updating version of #{dependency_name.ljust(27)} from #{current_version.ljust(12)} to #{dependency_version}"
            @hash_of_final_dependencies[dependency_name] = dependency_version
          else
            puts "Old Version detected #{dependency_name.ljust(26)}:#{dependency_version.ljust(12)} keeping #{current_version}"
          end
        end
        list_all_dependencies(dependencies)
      end
    end
  end

  def create
    @processed_already = []
    @hash_of_final_dependencies = {}

    update_last_requested_plugins
    resource[:plugins].each do |plugin_name, plugin_version|
      @hash_of_final_dependencies[plugin_name] = plugin_version
      download(plugin_name, plugin_version)
      unzip_plugin_file("#{resource[:dest_path]}/#{plugin_name}.hpi", "#{resource[:dest_path]}/#{plugin_name}_unzip/")

      puts "\n------------------------------------------------------"
      puts "Dependencies for #{plugin_name.ljust(35)} #{plugin_version}"

      dependencies = dependencies_for plugin_name
      list_all_dependencies(dependencies)
    end

    @hash_of_final_dependencies.each do |dependency_name, dependency_version|
      @last_run = @last_run.to_s + "#{dependency_name}:#{dependency_version},"
    end

    @property_flush[:ensure] = :present
  end

  def destroy
    puts 'Destroy'
    @property_flush[:ensure] = :absent
  end

  def exists?
    @jenkins_plugins.add_destination_path dest_path
    return false if first_run? || hash_changed?
    true
  end

  def plugins
    resource[:plugins]
  end

  def source
    resource[:source]
  end

  def source_path
    resource[:source_path]
  end

  def dest_path
    resource[:dest_path]
  end

  def owner
    resource[:owner]
  end

  def group
    resource[:group]
  end
end
