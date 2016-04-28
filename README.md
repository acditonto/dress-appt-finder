dress-appt-finder
=================

BASH script that curls a list of websites, searches each for a list of patterns, and then sends an email to a list of email addresses if that pattern is found.


To make this work 
1. edit the url, and search patterns

2. make sure that there are no files in the tmp directory

3. sudo crontab -e 

add the following line:
*/1 * * * * sudo sh /Users/ditonto/mortalkombat/dress-appt-finder/bhldn-dress-appt-notify

NOTE Make sure the file is executable
#!/usr/bin/ bash
chmod +x your_bash_file

4. set up email using postfix

$ vim /etc/postfix/main.cf
add/modify the following lines:

	relayhost = [smtp.gmail.com]:587
	smtp_use_tls = yes
	smtp_sasl_auth_enable = yes
	smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
	smtp_tls_CAfile = /etc/postfix/cacert.pem
	smtp_sasl_security_options =

Validate Certificate & Open/Create sasl_passwd:
	$ cat /etc/ssl/certs/Thawte_Premium_Server_CA.pem | sudo tee -a /etc/postfix/cacert.pem 
	
Set up Password
	$ sudo vim /etc/postfix/sasl/sasl_passwd
	Add the following line
		[smtp.gmail.com]:587 USERNAME@gmail.com:PASSWORD


FOR DEBUGGING MAIL: 
	tail -f /var/log/mail.log
	echo "hello" | mail -s "test" alec.ditonto@gmail.com alec.ditonto@gmail.com
