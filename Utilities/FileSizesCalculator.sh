#!/bin/bash

# Function to convert Gregorian calendar date to Unix timestamp
function gregorian_to_unix_timestamp() {
    local date_str="$1"
    date -d "$date_str" +%s
}

# Function to calculate folder size and display in gigabytes
function calculate_folder_size() {
    local folder_path="$1"
    local start_timestamp="$2"
    local end_timestamp="$3"
    
    # Calculate total file size in bytes within the specified period for the folder
    local total_size=$(hdfs dfs -du -t ${start_timestamp},${end_timestamp} "$folder_path" | awk '{sum+=$1} END {print sum}')
    
    # Convert total file size to gigabytes
    local total_size_gb=$(echo "scale=2; $total_size / (1024 * 1024 * 1024)" | bc)
    
    # Display total file size in gigabytes
    echo "Total file size created between $4 and $5 in $folder_path: $total_size_gb GB"
}

# Convert start and end dates to Unix timestamp
start_timestamp=$(gregorian_to_unix_timestamp "$1")
end_timestamp=$(gregorian_to_unix_timestamp "$2")

# Read the list of folder locations from the text file
while IFS= read -r folder_path; do
    calculate_folder_size "$folder_path" "$start_timestamp" "$end_timestamp" "$1" "$2"
done < "$3"
