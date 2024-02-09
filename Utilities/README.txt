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