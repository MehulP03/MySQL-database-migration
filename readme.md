# Data Migration Using Shell Script
## Overview
This shell script is designed to facilitate data migration from one location to another using a simple and customizable approach. It provides a straightforward method for copying or transferring data between different database providers.

## Prerequisites
### Shell Environment:
Ensure that the script is executed in a shell environment that supports shell scripting (e.g., Bash)
### `yq` Tool:
Install the `yq` tool for processing YAML files. 
```
brew install yq 
```

## Installation
### Clone the Repository:
Clone this repository to your local environment.
Note : Make sure you are inside repo folder created on local machine
### Set Permissions: 
Make the script executable by running the following command:
```
chmod +x migration.sh
```

## Configuration
` config.yaml ` Structure

```
source_database:
  db_host: <source_endpoint>
  db_user: <source_username>
  db_password: <source_password>
  db_name: <source_database_name>

destination_database:
  db_host: <destination_endpoint>
  db_user: <destination_username>
  db_password: <destination_password>
  db_name: <destination_database_name>
```
### NOTE:-
User need to Configure `source_database` and `destination_database` 

## Usage

Then you can execute the script:
```
./migration.sh
```
