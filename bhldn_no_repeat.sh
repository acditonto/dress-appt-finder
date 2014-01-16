#!/bin/bash
# this script hits this URL http://bhldnbeverlyhills.fullslate.com/services/1?start=2218&view=bare
# every minute to look for an opening on 2/8 or 2/9
# days: 2225 | 2226
# time: >=50400 | <=54000

clear

# this is the URL that will be tested against
url="http://bhldnbeverlyhills.fullslate.com/services/1?start=2218&view=bare"
# this is the term that will be searched for
searchterm="/book?day=2223&services%5B%5D=1&time=50400&view=bare"

if [ ! -f found.txt ]
  then
    
    echo "Retrieving web data from: http://bhldnbeverlyhills.fullslate.com/services/1?start=2218&view=bare ..."
    
    # get ther URL content
    content="$(curl -s "$url")"

    # put content into text.txt file
    echo "$content"> text.txt

    echo "Analyzing results..."

    #search for the search term
    result=$(grep $searchterm text.txt)

    #check status of the grep command
    if [ $? -eq 0 ]
      then
        echo "Date found..."

        #create the found doc so the script won't repeat itself  
        echo "found"> found.txt
        
        #create a file to hold the email message and create the message
        message="message.txt"
        echo "Date found at http://bhldnbeverlyhills.fullslate.com/services/1?start=2218&view=bare"> $message 
        
        #send the email
        $(mail -s "date found" "hiptonto@50cubes.com" < $message)
        
        echo "Email sent..."
      else
        echo 'No date found...'
    fi
  else
    echo "File found. Terminating..."
fi

