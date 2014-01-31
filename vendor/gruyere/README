# The Gruyere Target
Gruyere is a Codelab by Bruce Leban, Mugdha Bendre, and Parisa Tabriz. Gauntlt vendors it here to have a target to run gauntlt attacks against.  We assume no responsibility for the code and we are not distributing the code in a modified form.

It is a vulnerable app and should not be copied or modified.

# Using Gruyere as a Target
We use Gruyere as a target to make sure gauntlt works as expected.  We use the `service_manager` gem to handle starting it up before our cucumber tests run and then shut it down at the end.  In here are also two files prefixed with `manual_` and those are if you want to run Gruyere byhand.

# To run Gruyere by hand
```
$ ./manual_launch.sh
```
You should now be able to go to http://localhost:8008 and use the Gruyere application and target it.

# To stop Gruyere
The kill just looks at the `gruyere.pid` and kills that process.
```
$ ./manual_kill.sh
```
That's it.  You can make sure that it isnt running `ps -ef | grep python` in case you are worried.

# For more details on Gruyere
For more details, please see http://google-gruyere.appspot.com/
