#! /usr/bin/bash  
LC_COLLATE=C 
shopt -s extglob

export PS3=">>>"

function check_name_of_db(){
        
        if [[ $1 = [0-9]* ]] ; then 
            echo "Error 0x0001 : DB Name Can't Start With Number"
            return 1
        else 
            case $1 in 
                    +([a-zA-Z_0-9])) 
                        #echo "Mixed Character & Numbers"
                        return 0
                    ;;
                     *) 
                        echo "Error 0x0002 : DB Name Can't Contain Special Character"
                        return 1
                    ;;
            esac 
        fi
}
if [[ -d $HOME/.Shehabdb ]];then 
    echo "Already Exist"
else
    mkdir $HOME/.Shehabdb
    echo "create Foleder ...."
    sleep 2
fi 
select choice in CreateDB  ConnectDB ListDB RemoveDB "Exit"
do  
    
    case $REPLY in 
        1) #CreateDB
            read -r -p "Enter DataBase Name : " dbname 
            dbname=$(echo $dbname | tr ' ' '_') # Replace any Space to _
            check_name_of_db $dbname
            if (( $? == 0 )) ; then 
                if [[ -d $HOME/.Shehabdb/$dbname ]] ; then 
                    echo "Error 0x0003 : DB Already Exist ...."
                else  
                    mkdir $HOME/.Shehabdb/$dbname
                    echo "DB is Created ....."
                    sleep 1
                    
                fi 
            fi 
            
        ;;
        2) #ConnectDB   iti iti_2024
            read -r -p "Enter DataBase Name : " dbname   
            dbname=$(echo $dbname | tr ' ' '_') # Replace any Space to _
            check_name_of_db $dbname
            if (( $? == 0 )) ; then 
                 if [[ -d $HOME/.Shehabdb/$dbname ]];then 
                    cd  $HOME/.Shehabdb/$dbname 
                    echo "Enter $dbname  DB ..."
                    sleep 1
                    source /mnt/e/4\ months/linux/bash/bash_project/menus.sh $dbname
                else
                    echo "Error 0x0004 : 404 DB Not Found :) "
                fi
            fi
            
        ;;
        3) #ListDB
            echo "DB is : "
            ls -F ~/.Shehabdb/ | grep / | tr '/' ' ' #List all Folders
            
        ;;
        4) #RemoveDB
            read -r -p "Enter DataBase Name : " dbname 
            dbname=$(echo $dbname | tr ' ' '_') # Replace any Space to _
            check_name_of_db $dbname
            if (( $? == 0 )) ; then #Valid Name 
                if [[ -d $HOME/.Shehabdb/$dbname ]];then 
                    rm -r $HOME/.Shehabdb/$dbname
                    echo "DB is Removed ......"
                    sleep 1
                else
                    echo "Error 0x0004 : 404 DB Not Found :) "
                fi 
            fi 
            
        ;;
        5) #Exit
            break
        ;;
        *)
            echo "Not Valid Choice please try again ..."
        ;;
    esac
done 

#AWK SED 