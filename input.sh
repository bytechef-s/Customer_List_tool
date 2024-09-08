#!/bin/bash

# Check if figlet is installed, if not install it
if ! command -v figlet &> /dev/null
then
    echo -e "\033[31mfiglet could not be found, installing...\033[0m"
    sudo apt-get update
    sudo apt-get install figlet -y
fi

# Display "Xenon" using figlet in red color
echo -e "\033[31m$(figlet Xenon)\033[0m" 
echo "Programmer - Xenon"

# Function to check if data is in the file
check_data_in_file() {
    local data="$1"
    if grep -q "$data" "customer.txt"; then
        echo -e "\033[31mData found in the file.\033[0m"
        return 0
    else
        return 1
    fi
}

# Check if customer.txt exists, if not create it
if [ ! -f "customer.txt" ]; then
    echo -e "\033[31mcustomer.txt not found. Creating the file...\033[0m"
    touch customer.txt
fi

# Loop for inputting data
count=0
while true; do
    # Input data from the user
    read -p $'\e[31mEnter customer data: \e[0m' customer_data
    echo "Your number data is : $customer_data "

    # Check if the data is in the file
    if check_data_in_file "$customer_data"; then
        read -p $'\e[31mYour Data number found in the database. Do you want to continue? (1/0): :' choice
        if [[ "$choice" != "1" ]]; then
            echo -e "\033[31mExiting...\033[0m"
            break
        fi
    else
        # Save the data to customer.txt
        echo "$customer_data" >> customer.txt
        count=$((count + 1))
    fi

    # Check if 10 entries have been made
    if (( count % 10 == 0 )); then
        clear
        read -p $'\e[31mYou have entered '$count' entries. Do you want to continue? (1/0):::' choice
        if [[ "$choice" != "1" ]]; then
            echo -e "\033[31mExiting...\033[0m"
            break
        fi
    fi
done
