#!/bin/sh
OS=`/usr/bin/defaults read /System/Library/CoreServices/SystemVersion ProductVersion | awk '{print substr($1,1,4)}'`

if [[ "$OS" < "10.5" ]]; then
echo "Unlocking region code setting using OS $OS..."
	if [[ -f "/Library/Receipts/AdditionalEssentials.pkg/Contents/Resources/PlistBuddy" ]]; then
		sudo /Library/Receipts/AdditionalEssentials.pkg/Contents/Resources/PlistBuddy -c "Add :rights:system.device.dvd.setregion.change:class string allow" /etc/authorization
		sudo /Library/Receipts/AdditionalEssentials.pkg/Contents/Resources/PlistBuddy -c "Add :rights:system.device.dvd.setregion.change:comment string “Allows any user to change the DVD region code after it has been set the first time.”" /etc/authorization
		sudo /Library/Receipts/AdditionalEssentials.pkg/Contents/Resources/PlistBuddy -c "Add :rights:system.device.dvd.setregion.change:group string user" /etc/authorization
		sudo /Library/Receipts/AdditionalEssentials.pkg/Contents/Resources/PlistBuddy -c "Add :rights:system.device.dvd.setregion.change:shared bool true" /etc/authorization
	else
		echo "PlistBuddy command not found. The DVD region code cannot be unlocked. Please ensure that PlistBuddy is installed at /Library/Receipts/AdditionalEssentials.pkg/Contents/Resources/PlistBuddy."
	fi
	else
echo "Unlocking region code setting using OS $OS..."
	if [[ -f "/usr/libexec/PlistBuddy" ]]; then
		sudo /usr/libexec/PlistBuddy -c "Set :rights:system.device.dvd.setregion.initial:class allow" /etc/authorization
		sudo /usr/libexec/PlistBuddy -c "Add :rights:system.device.dvd.setregion.change:class string allow" /etc/authorization
		sudo /usr/libexec/PlistBuddy -c "Add :rights:system.device.dvd.setregion.change:comment string “Allows any user to change the DVD region code after it has been set the first time.”" /etc/authorization
		sudo /usr/libexec/PlistBuddy -c "Add :rights:system.device.dvd.setregion.change:group string user" /etc/authorization
		sudo /usr/libexec/PlistBuddy -c "Add :rights:system.device.dvd.setregion.change:shared bool true" /etc/authorization
	else
		echo "PlistBuddy command not found. The DVD region code cannot be unlocked. Please ensure that PlistBuddy is installed at /usr/libexec/PlistBuddy."
	fi
fi
