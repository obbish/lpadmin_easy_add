#!/bin/bash

# Define printers and customizations

printer1="5321X114787"
printer1_device="lpd://5321X114787.eduprint.stockholm.se"
printer1_driver="/Library/Printers/PPDs/Contents/Resources/RICOH P C600"
printer1_location="B407"
printer1_is_shared="false"

printer2="5323X136622"
printer2_device="lpd://5323X136622.eduprint.stockholm.se"
printer2_driver="/Library/Printers/PPDs/Contents/Resources/RICOH P C600"
printer2_location="B307"
printer2_is_shared="false"

# Function to install printer
install_printer() {
    local name="$1"
    local device="$2"
    local driver="$3"
    local location="$4"
    local is_shared="$5"

    echo "Installing printer: $name"
    if lpadmin -p "$name" -E -v "$device" -m "$driver" -L "$location" -o printer-is-shared="$is_shared" 2>&1; then
    	echo
     	echo "Printer '$name' installed successfully."
    else
    	echo
     	echo "Failed to install printer '$name'. Check CUPS error log for details."
    fi
}

# Loop to allow selecting multiple printers
while true; do
    # Prompt user to choose a printer or exit
    echo
    echo "Printers available:"
    echo "1. $printer1 (Location: $printer1_location)"
    echo "2. $printer2 (Location: $printer2_location)"
    echo
    read -p "Enter the number of a printer to install (or type 'done' to finish): " choice

    case $choice in
        1)
            install_printer "$printer1" "$printer1_device" "$printer1_driver" "$printer1_location" "$printer1_is_shared"
            ;;
        2)
            install_printer "$printer2" "$printer2_device" "$printer2_driver" "$printer2_location" "$printer2_is_shared"
            ;;
        done)
            echo "Installation complete."
            break
            ;;
        *)
            echo "Invalid input. Please enter a valid printer number or 'done'."
            ;;
    esac
done
