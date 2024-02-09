Provide permissions to the Script
chmod +x calculate_folder_sizes_from_file.sh

Calc the Script
./calculate_folder_sizes_from_file.sh "2024-01-01" "2024-02-01" folder_list.txt



    # Calculate total file size in bytes within the specified period for the folder
    local total_size=$(hdfs dfs -du "$folder_path" | while IFS= read -r line; do
        file_size=$(echo "$line" | awk '{print $1}')
        file_timestamp=$(echo "$line" | awk '{print $2}')
        if [[ "$file_timestamp" -ge "$start_timestamp" && "$file_timestamp" -le "$end_timestamp" ]]; then
            echo "$file_size"
        fi
    done | awk '{sum+=$1} END {print sum}')



#!/bin/bash

# Function to calculate folder size and display in gigabytes
function calculate_folder_size() {
    local folder_path="$1"
    local file_pattern="$2"
    
    # Calculate total file size in bytes matching the pattern for the folder
    local total_size=$(hdfs dfs -du -h "$folder_path/$file_pattern" | awk '{sum+=$1} END {print sum}')
    
    # Convert total file size to gigabytes
    local total_size_gb=$(echo "scale=2; $total_size / (1024 * 1024 * 1024)" | bc)
    
    # Display total file size in gigabytes
    echo "Total file size matching pattern '$file_pattern' in $folder_path: $total_size_gb GB"
}

# Read the list of folder locations from the text file
while IFS= read -r folder_path; do
    calculate_folder_size "$folder_path" "$1"
done < "$2"







#!/bin/bash

# Function to calculate folder size and display in gigabytes
function calculate_folder_size() {
    local folder_pattern="$1"
    local file_pattern="$2"
    
    # Get a list of folder paths matching the pattern
    local folders=$(hdfs dfs -ls -d "$folder_pattern" | awk '{print $NF}')
    
    # Iterate over each folder and calculate the size
    while IFS= read -r folder_path; do
        # Calculate total file size in bytes for the folder
        local total_size=$(hdfs dfs -du -h "$folder_path/$file_pattern" | awk '{sum+=$1} END {print sum}')
        
        # Convert total file size to gigabytes
        local total_size_gb=$(echo "scale=2; $total_size / (1024 * 1024 * 1024)" | bc)
        
        # Display total file size in gigabytes
        echo "Total file size matching pattern '$file_pattern' in $folder_path: $total_size_gb GB"
    done <<< "$folders"
}

# Read the list of folder locations from the text file
while IFS= read -r folder_pattern; do
    calculate_folder_size "$folder_pattern" "$1"
done < "$2"
