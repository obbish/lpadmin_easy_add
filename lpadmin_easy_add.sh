#!/bin/bash

# Define printers and customizations

# Printer1
printer1="5321X114787"
printer1_device="lpd://5321X114787.eduprint.stockholm.se"
printer1_driver="/Library/Printers/PPDs/Contents/Resources/RICOH P C600"
printer1_location="B407"
printer1_is_shared="false"

# Printer 2
printer2="5323X136622"
printer2_device="lpd://5323X136622.eduprint.stockholm.se"
printer2_driver="/Library/Printers/PPDs/Contents/Resources/RICOH P C600"
printer2_location="B307"
printer2_is_shared="false"

while true; do

    # Prompt user to choose a printer, or exit

    echo
    echo "Printers available:"
    echo
    echo "	1." 
    echo "	Name: $printer1"
    echo "	Location: $printer1_location"
    echo
    echo "	2."
    echo "	Name: $printer2"
    echo "	Location: $printer2_location"
    echo
    read -p "Enter a choice (1, 2), or type 'exit' to quit: " user_input

    case $user_input in
        1)
            printer_name="$printer1"
            printer_device="$printer1_device"
            printer_driver="$printer1_driver"
            printer_location="$printer1_location"
            printer_is_shared="$printer1_is_shared"
            break
            ;;
        2)
            printer_name="$printer2"
            printer_device="$printer2_device"
            printer_driver="$printer2_driver"
            printer_location="$printer2_location"
            printer_is_shared="$printer2_is_shared"
            break
            ;;
        exit)
			echo
            echo "Script exited."
            echo
            exit 0
            ;;
        *)
            echo
            echo "Invalid input '"$user_input"'."
            ;;
    esac
done

# Run lpadmin with your customizations, error check, and finish

echo
echo "Installing printer: "$user_input". "$printer_name"... "
echo

if lpadmin -p "$printer_name" -E -v "$printer_device" -m "$printer_driver" -L "$printer_location" -o printer-is-shared="$printer_is_shared" 2>&1; then
    echo
    echo "Script completed." 
    echo
    
else
    echo
    echo "An error occurred while installing "$user_input". "$printer_name"... "
    echo
    echo "CUPS logfile reads:"
    tail /var/log/cups/error_log
    echo
    echo "Script failed."
    echo
fi
