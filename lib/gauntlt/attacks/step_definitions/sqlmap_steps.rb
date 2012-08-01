Given /^sqlmap is installed$/ do
  begin
    steps %{
      When I run `which sqlmap`
      Then the output should contain:
      """
      sqlmap
      """
    }
  rescue
    msg = <<-EOS
    sqlmap.py not installed or sqlmap alias not set!

    1. Download sqlmap from: https://github.com/sqlmapproject/sqlmap
    2. Create a file named 'sqlmap' with the following content:

       #! /usr/bin/env bash
       python /path/to/sqlmap.py

    3. Make sure the file is in your path:

       $ which sqlmap


EOS
    raise msg
  end
end