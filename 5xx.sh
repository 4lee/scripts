#/bin/bash
INSTANCEIP=$(curl ifconfig.me) #Store Public IP in a variable
domain_file=/data/ril_domains.txt
count=0
mail_count=0
status_code_count=0
while true
do
	for URL in `cat $domain_file`
	do
    		while [ $count -le 20 ]
    		do
    			curl_code=`curl -o /dev/null --silent --head --write-out '%{http_code}\n' $URL`
    			#if [ "$curl_code" =~ 400|401|402|403|404|405|500|501|502|503|504|505 ];then
    			if [ "$curl_code" =~ 200 ];then
        			status_code_count=`expr $status_code_count + 1`
    			fi
    	`			count=`expr $count + 1`
    		done
    		if [ $status_code_count -ge 18 ];then
			if [ $mail_count -le 3 ];then
				echo "We are recieving multiple URL faliure for $URL on $INSTANCEIP" > /data/status_code.log
				echo "Current count is $status_code_count" > /data/status_code.log
				python /data/mail.py
				mail_count=`expr $mail_count + 1`
				sleep 5m
			else
				echo "Do nothing"
    		else
			status_code_count=0
			echo "No alert triggered" > /data/status_code.log
    		fi
    	status_code_count=0
	count=0
	done
done
