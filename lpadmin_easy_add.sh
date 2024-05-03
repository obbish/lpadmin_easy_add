#!/bin/bash


# To accommodate for more printers,
# just copy the rows of an existing printer,
# and update with a new number, 
# in the sections:
#
# a) printer definitions
# b) selection menu
# c) choices


# For troubleshooting remove "2>/dev/null"
# For more support run "man lpupdate" in terminal


# a) printer definitions - This is where the printers' options are defined
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


# b) selection menu - This displays the menu of available printers to add
display_printer_menu() {
    
    clear
    echo
    echo "List of available printers:"
    echo
    echo " 1. $printer1 (Location: $printer1_location)"
    echo " 2. $printer2 (Location: $printer2_location)"
    echo
    
}


# c) choices - This makes the printers availble and allows the user to make a choice
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


# Lastly, this adds the printer using lpadmin, checks if it worked, then returns user to the menu
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
