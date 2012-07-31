module ProfileHelper
  def hostname
    raise "No host defined" if @hostname.nil?

    @hostname
  end

  def set_hostname(s)
    @hostname = s
  end
end
World(ProfileHelper)