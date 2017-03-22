**TEST vuln-31.attack**

This is a Gauntlt test to check if the vulnerability in WebGoat located at General => Http Basics (vuln-31 - Session Management Flaws => Spoof an Authentication Cookie) exists.

It will print out:

* __\*\*\*Vulnerability Present\*\*\*__ if the vulnerability is present

* __\*\*\*No Vulnerability\*\*\*__ if the vulnerability is fixed (aka not present)

1). You have requests installed. If you don't have requests installed on your machine, you can follow these steps to install it:

Clone the public repo:
		
	$ git clone git://github.com/kennethreitz/requests.git
		

Once you have the copy of the source, install it by issuing this command:
		
	$ python setup.py install
		

2).There is a local proxy running on 127.0.0.1:8888

Testing vuln-00 can be done outside of Gauntlt by navigating to the webgoat/vuln-00 directory and running:

	$ python exploit-vuln-31.py


*This Gauntlt test was written by Tin Vo (tinnvo1101@gmail.com) and Uyviet Nguyen (uyviet.nguyen@utexas.edu) on 10 Dec 2015*