#!/bin/bash
# this script hits this URL http://bhldnbeverlyhills.fullslate.com/services/1?start=2218&view=bare
# every minute to look for an opening on 2/8 or 2/9
# days: 2225 | 2226

clear # clean things up a bit

# this is the URL that will be tested against
url="http://bhldnbeverlyhills.fullslate.com/services/1?start=2218&view=bare"
# this is the term that will be searched for
searchterms=( "/book?day=2225" "/book?day=2226" )
# email that notification is sent to
email="alec.ditonto@gmail.com"
# flag file -- used to determine if the script ever ran successfully
flag="tmp/flag.txt"
# var used to determine if this should repeatedly send emails despite the flag
repeat=true

if [ ! -f $flag ] || [ $repeat ]
  then
    
    echo "Retrieving web data from:" $url
    
    # get ther URL content
    content="$(curl -s "$url")"

    # put content into text.txt file
    echo "$content"> tmp/text.txt

    echo "Analyzing results..."

    for i in "${searchterms[@]}"
    do
        echo $i
        #search for the search term
        result=$(grep $i tmp/text.txt)

        #check status of the grep command
        if [ $? -eq 0 ]
          then
            echo "Date found..."

            #create the found doc so the script won't repeat itself  
            echo "flagged"> $flag
            echo $i
            #create a file to hold the email message and create the message
            message="tmp/message.txt"
            echo "Date found at http://bhldnbeverlyhills.fullslate.com/services/1?start=2218&view=bare" "$i"> $message 
            
            #send the email
            $(mail -s "date found" $email< $message)
            
            echo "Email sent..."
          else
            echo 'No date found...'
        fi
    done
  else
    echo "File found. Terminating..."
fi