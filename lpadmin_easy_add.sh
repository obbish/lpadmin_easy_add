#!/bin/bash

# Define printer names
printer1="Printer 1"
printer2="Printer 2"
printer3="Printer 3"

# Prompt user to choose a printer
echo "Choose a printer to install:"
echo "1. $printer1"
echo "2. $printer2"
echo "3. $printer3"
read -p "Enter your choice (1, 2, or 3): " choice

# Variables to store printer information
printer_name=""
printer_device=""
printer_driver=""

# Set printer information based on user choice
case $choice in
    1)
        printer_name="$printer1"
        printer_device="lpd://printer1-hostname"
        printer_driver="/path/to/printer3/PPD"
        ;;
    2)
        printer_name="$printer2"
        printer_device="smb://printer2-hostname"
        printer_driver="/path/to/printer2/PPD"
        ;;
    3)
        printer_name="$printer3"
        printer_device="ipp://printer3-hostname"
        printer_driver="/path/to/printer3/PPD"
        ;;
    *)
        echo "We don't have $choice here yet, exiting..."
        exit 1
        ;;
esac

# Install the selected printer and check for errors
if lpadmin -p "$printer_name" -E -v "$printer_device" -m "$printer_driver" 2>&1; then
    echo "$printer_name has been installed successfully."
else
    echo "Error: Failed to install $printer_name, check your logfile by runnning "tail /var/log/cups/error_log""
fi
