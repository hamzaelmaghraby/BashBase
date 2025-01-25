#! /usr/bin/bash  
export PS3="$1 >>"

# Get the database name from the argument
DB_NAME=$1

# Check if the database exists
if [[ ! -d "$HOME/.Shehabdb/$DB_NAME" ]]; then
    echo "Error: Database '$DB_NAME' does not exist."
    exit 1
fi

# Ask for the table name
read -r -p "Enter Table Name: " table_name
table_path="$HOME/.Shehabdb/$DB_NAME/$table_name"
metadata_file="$table_path.meta"
data_file="$table_path.data"

# Check if the table already exists
if [[ -f "$metadata_file" ]]; then
    echo "Error: Table '$table_name' already exists."
    exit 1
else
    # Create metadata and data files
    mkdir "$table_path" || { echo "Error: Could not create table directory."; exit 1; }
    touch "$metadata_file" "$data_file" || { echo "Error: Could not create metadata or data file."; exit 1; }
    echo "Table '$table_name' created successfully."

    # Define table structure
    echo "Define the table structure by specifying column names and data types."
    echo "Format: column_name:data_type (e.g., id:int, name:string)"
    echo "Type 'done' when you are finished."

    header=""
    primary_key_column=""
    while true; do
        read -r -p "Enter column_name:data_type: " column_definition
        if [[ $column_definition == "done" ]]; then
            break
        fi

        # Validate column definition format
        if [[ $column_definition =~ ^[a-zA-Z_]+:(int|string)$ ]]; then
            column_name=$(echo "$column_definition" | cut -d: -f1)
            data_type=$(echo "$column_definition" | cut -d: -f2)

            # Check for duplicate column names
            if grep -q "^$column_name:" "$metadata_file"; then
                echo "Error: Column '$column_name' already exists."
                continue
            fi

            # Mark the first column as primary key
            if [[ -z "$primary_key_column" ]]; then
                primary_key_column="$column_name"
                data_type="$data_type:primary"
            else
                data_type="$data_type:notprimary"
            fi

            # Add column to metadata file with primary key annotation
            echo "$column_name:$data_type" >> "$metadata_file"
            
            # Add to header for data file
            if [[ -z "$header" ]]; then
                header="$column_name"
            else
                header="$header:$column_name"
            fi
        else
            echo "Invalid format. Please use column_name:data_type."
        fi
    done

    # Save header to data file
    echo "$header" > "$data_file"
    echo "Table structure saved in metadata file:"
    cat "$metadata_file"
    echo "Primary key is set to '$primary_key_column'."
fi
