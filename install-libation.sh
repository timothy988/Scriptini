#!/bin/bash

FILE=$1

if [ -z "$FILE" ]
 then echo "This script must be called with a the Libation Linux bin zip file as an argument."
 exit
fi

if [[ "$EUID" -ne 0 ]]
  then echo "Please run as root"
  exit
fi

if [ ! -f "$FILE" ]
 then echo "The file \"$FILE\" does not exist."
 exit
fi

echo "Extracting $FILE"

FOLDER="$(dirname "$FILE")/libation_src"
echo "$FOLDER"

sudo -u $SUDO_USER unzip -q -o ${FILE} -d ${FOLDER}

if [ $? -ne 0 ]
 then echo "Error unzipping ${FILE}"
 exit
fi

sudo -u $SUDO_USER chmod +700 ${FOLDER}/Libation
sudo -u $SUDO_USER chmod +700 ${FOLDER}/Hangover
sudo -u $SUDO_USER chmod +700 ${FOLDER}/LibationCli

#Remove previous installation program files and sym link
rm /usr/bin/Libation
rm /usr/bin/Hangover
rm /usr/bin/LibationCli
rm /usr/bin/libationcli
rm /usr/lib/libation -r

#Copy install files, icon and desktop file
cp ${FOLDER}/glass-with-glow_256.svg /usr/share/icons/hicolor/scalable/apps/libation.svg
cp ${FOLDER}/Libation.desktop /usr/share/applications/Libation.desktop
mv ${FOLDER}/ /usr/lib/libation

chmod +666 /usr/share/icons/hicolor/scalable/apps/libation.svg
gtk-update-icon-cache -f /usr/share/icons/hicolor/
ln -s /usr/lib/libation/Libation /usr/bin/Libation
ln -s /usr/lib/libation/Hangover /usr/bin/Hangover
ln -s /usr/lib/libation/LibationCli /usr/bin/LibationCli
ln -s /usr/lib/libation/LibationCli /usr/bin/libationcli

echo "Done!"
