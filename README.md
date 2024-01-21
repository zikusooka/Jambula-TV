Introduction
------------

JambulaTV is a smart home hub that automates several tasks in your house or apartment while providing security and privacy to you and your family.  As an automation and entertainment controller, JambulaTV transforms your home into a modern and smart residence by intelligently managing your home's security, emergencies, lighting, temperature, doors, windows, energy usage, TV, music, schedules, and much more. 

Read more about JambulaTV at:

https://jambulatv.com

**NOTE:** This code is still experimental but is already being used in some homes. 

Your contributions are welcome.  For bug fixes, please open an issue.


For updates to this, and other contributions, please follow:

**JambulaTV:**

.[!["https://twitter.com/JambulaTV"](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/JambulaTV)

.[!["https://x.com/JambulaTV"](https://img.shields.io/badge/X-000000?style=for-the-badge&logo=x&logoColor=white
)](https://x.com/JambulaTV)

.[!["https://www.facebook.com/JambulaTV"](https://img.shields.io/badge/Facebook-%231877F2.svg?style=for-the-badge&logo=Facebook&logoColor=white)](https://www.facebook.com/JambulaTV)

.[!["http://ug.linkedin.com/in/JambulaTV"](https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](http://ug.linkedin.com/in/JambulaTV)

.[!["https://www.youtube.com/channel/UCk2hQcMx661iZxk1oQaQsFg"](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](https://www.youtube.com/channel/UCRqM44g8cCj5vX2xqEnppfw)


**Joseph Zikusooka - Zik:**

.[!["https://mastodon.social/@jzik"](https://img.shields.io/badge/Mastodon-6364FF?style=for-the-badge&logo=Mastodon&logoColor=white)](https://mastodon.social/@jzik)

.[!["https://twitter.com/jzikusooka"](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/jzikusooka)

.[!["https://x.com/jzikusooka"](https://img.shields.io/badge/X-000000?style=for-the-badge&logo=x&logoColor=white
)](https://x.com/jzikusooka)

.[!["https://www.linkedin.com/in/zik-joseph"](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/zik-joseph)

.[!["https://joseph.zikusooka.com"](https://img.shields.io/badge/Wordpress-21759B?style=for-the-badge&logo=wordpress&logoColor=white
)](https://joseph.zikusooka.com)


**If you like the content I have created, feel free to share or
buy me a coffee:**

.[!["https://ko-fi.com/jzikusooka"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://ko-fi.com/jzikusooka)


System Boards tested on
-----------------------
- Asus Mini-ITX Motherboards


Supported Platforms
-------------------
- Linux (Tested on Fedora versions 20+)


Requirements
------------
1. JambulaOS Linux
2. Hardware and related smart home accessories depending on your use cases and locality


Installation
------------

Install Fedora Linux:  There are two ways you can install the Linux operating system used by JambulaTV:

a) **Quick method:**

Use the supplied JambulaOS Linux image.  Check out the project page at: 

https://github.com/zikusooka/Jambula-OS 

or feel free to request me for one.

b) **Long method:**

Set up a Linux installation server.  This server will use PXE/TFTP boot method to serve a Fedora kickstart install file to the client.  I highly recommend using the open source software package called Cobbler.  Cobbler is a Linux provisioning server that facilitates and automates the network-based system installation of multiple computer operating systems from a central point using services such as DHCP, TFTP, and DNS. 

Configure cobbler server and ensure that the following kickstart files will be served correctly.  For instructions, please visit:

https://cobbler.readthedocs.io/en/latest/quickstart-guide.html

Change the kickstart files to suit your needs i.e. Modify the files: jambulatv-system.ks and jambulatv-packages.ks located in this project's contrib directory


Post installation:
-----------------

1. Login as root user

2. Clone this repo

   git clone https://github.com/zikusooka/Jambula-TV.git

3. Run "install.sh" script


NOTES: 
-----
In order to run and complete the install process, you will need to have access to the JambulaTV packages repository FTP site i.e. sftp.jambulatv.com

For this project, I used Fedora 20 which was released in December 2013, however, you should still be able to use the latest Linux versions with minimal changes.
