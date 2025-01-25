# BashBase

BashBase is a lightweight, terminal-based database engine written entirely in Bash. It allows users to create and manage databases, perform CRUD operations on tables, and query data efficiently using simple commands.

## Features
- Create and delete databases.
- Connect to a database.
- List all available databases.
- Create and manage tables within a database.
- Perform basic CRUD operations:
  - **Select**: Retrieve records from a table.
  - **Insert**: Add new records to a table.
  - **Update**: Modify existing records in a table.
  - **Delete**: Remove records from a table.
- Exit functionality to terminate sessions gracefully.

## File Structure
```
├── home                # Main entry point to manage databases
├── menu                # Handles operations after connecting to a database
│   ├── create_table.sh    # Script to create tables
│   ├── select_records     # Script to query and select records
│   ├── list_tables        # Script to list all tables in a database
│   ├── delete             # Script to delete records
│   ├── insert             # Script to insert new records
│   ├── update             # Script to update existing records
└── exit                # Exit functionality for the menu
```

## Getting Started

### Prerequisites
- A Unix-like operating system (Linux, macOS, or WSL on Windows).
- Bash shell version 4.0 or higher.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/hamzaelmaghraby/bashbase.git
   cd bashbase
   ```
2. Grant execute permissions to all scripts:
   ```bash
   chmod +x home menu/*
   ```

### Usage
1. Start the main entry point:
   ```bash
   ./home
   ```
2. Follow the prompts to:
   - Create, delete, list, or connect to a database.
3. After connecting to a database, navigate through the menu to:
   - Create tables.
   - List all tables.
   - Perform CRUD operations.
4. Exit the menu to terminate the session.

## Example Workflow
1. Start BashBase:
   ```bash
   ./home
   ```
2. Create a new database named `example_db`.
3. Connect to `example_db`.
4. In the menu:
   - Create a table named `users`.
   - Insert a record into the `users` table.
   - Query the `users` table to view the inserted data.
   - Update or delete the record as needed.
5. Exit the session.

## Contributing
Contributions are welcome! Feel free to submit issues or pull requests to improve BashBase.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments
Special thanks to the open-source Bash community for inspiration and support.

