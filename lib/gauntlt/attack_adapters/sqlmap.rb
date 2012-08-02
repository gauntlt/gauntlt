Given /^sqlmap is installed$/ do
  begin
    path = `echo $SQLMAP_PATH`
    raise if path.strip == ""

    raise "python not found" unless installed?('python')

    When "I run `echo #{path}`"
    steps %{
      Then the output should contain:
      """
      /sqlmap.py
      """
    }
  rescue
    msg = <<-EOS
    sqlmap.py not installed or $SQLMAP_PATH not set!

    1. Download sslyze from: https://github.com/sqlmapproject/sqlmap
    2. In your .zshrc or .bash_profile (or whatever), set $SQLMAP_PATH

       export SQLMAP_PATH=/path/to/sqlmap.py

    3. Make sure you have python installed:

       $ which python


EOS
    raise msg
  end
end