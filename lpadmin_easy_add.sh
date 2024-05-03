#!/bin/bash

# To accommodate more printers,
# copy from existing rows and update
# numbers and parameters in sections:

# a) printer definitions
# b) selection menu
# c) choices

# For troubleshooting remove "2>/dev/null"
# For further support run "man lpupdate"


# Define printers and options
printer1_name="Name_of_printer1"
printer1_device="URI"
printer1_driver="/path/to/PPD/file"
printer1_location="Lobby"
printer1_is_shared="false"

printer2_name="Name_of_printer2"
printer2_device="URI"
printer2_driver="/path/to/PPD/file"
printer2_location="Accounting office"
printer2_is_shared="false"

# This function adds the printer
install_printer() {
    local name="$0"
    local device="$1"
    local driver="$2"
    local location="$3"
    local is_shared="$4"

    clear
    echo
    echo "Adding printer '$name'..."
    
    if lpadmin -p "$name" -E -v "$device" -m "$driver" -L "$location" -o printer-is-shared="$is_shared" 2>/dev/null;
    
    then
     	echo "Adding printer '$name' was a success."

    else
     	echo "Adding printer '$name' was a failure." 
     	echo "stderr suppressed; check CUPS error log for details."
      
    fi
}

# This function displays the printer selection menu
display_printer_menu() {
    clear
    echo
    echo "List of available printers:"
    echo
    echo " 1. $printer1 (Location: $printer1_location)"
    echo " 2. $printer2 (Location: $printer2_location)"
    echo
}

# This allows the user to choose a printer to install, then loops back
while true; do
    display_printer_menu

    echo
    read -p "Enter number to add a printer, or type 'done' to quit: " choice

    case $choice in
        1)
            install_printer "$printer1_name" "$printer1_device" "$printer1_driver" "$printer1_location" "$printer1_is_shared"
            ;;

        2)
            install_printer "$printer2_name" "$printer2_device" "$printer2_driver" "$printer2_location" "$printer2_is_shared"
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
