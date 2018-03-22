class JenkinsPlugins

  attr_accessor :last_requested
  @last_requested

  def initialize
    @last_requested = '/last_req.txt'
  end

  def add_destination_path(destination_path)
    @last_requested = "#{destination_path}#{last_requested}"
  end

  def first_run?(qualified_file_name)
    !File.exist? qualified_file_name
  end

  def hash_changed_for?(plugins)
    @requested = plugins
    @hash_from_last_req = eval File.read("#{resource[:dest_path]}/last_req.txt")

    return false if @requested == @hash_from_last_req

    update_last_requested_plugins
    true
  end

end
