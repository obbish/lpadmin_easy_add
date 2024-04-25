#!/bin/bash

# Prompt user to choose a printer
echo "Choose a printer to install:"
echo "1. Printer 1"
echo "2. Printer 2"
echo "3. Printer 3"
read -p "Enter your choice (1, 2, or 3): " choice

# Variables to store printer information
printer_name=""
printer_device=""
printer_driver=""

# Set printer information based on user choice
case $choice in
    1)
        printer_name="Printer1"
        printer_device="/dev/usb/lp0"
        printer_driver="driver/for/printer1"
        ;;
    2)
        printer_name="Printer2"
        printer_device="/dev/usb/lp1"
        printer_driver="driver/for/printer2"
        ;;
    3)
        printer_name="Printer3"
        printer_device="/dev/usb/lp2"
        printer_driver="driver/for/printer3"
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac

# Install the selected printer and check for errors
if lpadmin -p "$printer_name" -E -v "$printer_device" -m "$printer_driver" 2>&1; then
    echo "$printer_name has been installed successfully."
else
    echo "Error: Failed to install $printer_name. Error message: $output"
fi