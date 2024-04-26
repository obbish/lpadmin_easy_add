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

# Function to add printer
install_printer() {
    local name="$1"
    local device="$2"
    local driver="$3"
    local location="$4"
    local is_shared="$5"

    clear
    echo
    echo "Adding printer '$name'..."
    if lpadmin -p "$name" -E -v "$device" -m "$driver" -L "$location" -o printer-is-shared="$is_shared" 2>/dev/null; then
     	echo "Adding printer '$name' was a success ✓"

    else
     	echo "Adding printer '$name' was a failure ❌" 
     	echo "stderr suppressed; check CUPS error log for details."
    fi
}

# Function to display printer selection menu
display_printer_menu() {
    clear
    echo
    echo "List of available printers:"
    echo
    echo " 1. $printer1 (Location: $printer1_location)"
    echo " 2. $printer2 (Location: $printer2_location)"
    echo
}

# Loop to allow selecting multiple printers
while true; do
    display_printer_menu

    echo
    read -p "Enter number to add a printer, or type 'done' to quit: " choice

    case $choice in
        1)
            install_printer "$printer1" "$printer1_device" "$printer1_driver" "$printer1_location" "$printer1_is_shared"
            ;;
        2)
            install_printer "$printer2" "$printer2_device" "$printer2_driver" "$printer2_location" "$printer2_is_shared"
            ;;
        "done")
            
	    clear
            echo
			echo "Done adding printers!"
			echo "Please print responsibly."
            echo
            break
            ;;
        *)
            clear
            echo
            echo "Invalid input."
            echo "Enter a number from the list or type 'done' to quit."
            ;;
    esac
	
	echo
    read -p "Press Enter to continue..."
done
