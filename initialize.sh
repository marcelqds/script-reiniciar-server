#!/bin/bash

previous_hash=
pid=

create_hash(){
    hash_created=`cat ./index.js | sha1sum`
    echo $hash_created
}

check_hash(){
    current_hash=$( create_hash )

    if [[ "$current_hash" !=  "$previous_hash" ]]; then
        stop_app
        start_app
        check_pid
        previous_hash=$current_hash
        echo "Reiniciando o server"    
    fi
    
}

start_app(){
    rm -rf nd.pid
    echo "Starting server..."
    node ./index.js &
}

stop_app(){    
    echo "Matando serviço: $pid"
    kill $pid
    rm -rf nd.pid
}

check_pid(){
	is_file=true
	while $is_file
	do
	    if [[ -f nd.pid ]]; then
	        is_file=false
	        pid=`cat nd.pid`
	    else
	        sleep 1
	    fi
	done
}


previous_hash=$( create_hash )
start_app
check_pid

echo "Simbora meu camarada $pid"

is_infinity=true
while $is_infinity
do
    check_hash
    sleep 3
done
