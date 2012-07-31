require 'English'
# English.rb adds human-readable names for things like $?, $!, etc.:
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/English/rdoc/English_rb.html

module SystemHelper
  def installed?(bin_name)
    `which #{bin_name}` && $CHILD_STATUS.success?
  end

  def ensure_cli_installed(bin)
    raise "#{bin} is not installed or is not in your path" unless installed?(bin)
  end
end
World(SystemHelper)