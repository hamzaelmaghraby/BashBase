#! /usr/bin/bash  

export PS3="$1 >>"

# Get the database name from the argument
DB_NAME=$1

# Check if the database exists
if [[ ! -d "$HOME/.Shehabdb/$DB_NAME" ]]; then
    echo "Error: Database '$DB_NAME' does not exist."
    exit 1
fi

# Table management options
select choice in CreateTable SelectTable ListTable RemoveTable  Insert  Update "Exit"
do
    case $REPLY in
        1) # CreateTable
            source /mnt/e/4\ months/linux/bash/bash_project/create_table.sh $DB_NAME
        ;;

        2) # SelectTable
            read -r -p "Enter Table Name to select: " table_name
            table_path="$HOME/.Shehabdb/$DB_NAME/$table_name"
            read -r -p "Enter  condition " condition
            source /mnt/e/4\ months/linux/bash/bash_project/select_records "$table_path" "$condition"

        ;;

        3) # ListTable
            echo "Tables in database '$DB_NAME':"
            ls -1 "$HOME/.Shehabdb/$DB_NAME" | grep -E "\.meta$" | sed 's/.meta//'
        ;;

        4) # RemoveTable
          
            read -r -p "Enter Table Name to select: " table_name
            table_path="$HOME/.Shehabdb/$DB_NAME/$table_name"
            read -r -p "Enter  condition " condition
            

            if (( ${#condition} == 0 )); then
                    source /mnt/e/4\ months/linux/bash/bash_project/delete "$table_path" 
            else
                source /mnt/e/4\ months/linux/bash/bash_project/delete "$table_path" "$condition"
            fi       
        ;;



        5) # Insert
            
            read -r -p "Enter Table Name to insert data into: " table_name
            table_path="$HOME/.Shehabdb/$DB_NAME/$table_name"
            metadata_file="$table_path.meta"
            data_file="$table_path.data"

            # Display table metadata for reference
            echo "Inserting data into table '$table_name'."
            echo "Table Metadata:"
            cat "$metadata_file"

            # Prompt for values separated by `:`
            read -r -p "Enter values separated by colons (:): " values
            source /mnt/e/4\ months/linux/bash/bash_project/insert "$table_path" "$values"
            
        ;;

        6) # Update
            read -r -p "Enter Table Name to select: " table_name
            table_path="$HOME/.Shehabdb/$DB_NAME/$table_name"
            read -r -p "Enter set " new_var
            read -r -p "Enter  condition " condition

        
            
            source /mnt/e/4\ months/linux/bash/bash_project/update "$table_path" "$new_var" "$condition"
             
        ;;
        7) # Exit
            break
        ;;

        *)
            echo "Invalid choice. Please try again."
        ;;
    esac
done
