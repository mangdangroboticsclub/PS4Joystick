#!/usr/bin/env sh

if [ "$(uname)" == "Darwin" ]; then
	echo "ds4drv doesn't work on Mac OS!"
	echo "try installing pygame (commented out in this script) and running mac_joystick.py"
	exit 0
fi

FOLDER=$(dirname $(realpath "$0"))
cd $FOLDER


#pygame is no longer needed!
# sudo apt-get install -y libsdl-ttf2.0-0
# yes | python3 -m python3 -m pip install --break-system-packages --break-system-packages pygame

yes | python3 -m python3 -m pip install --break-system-packages --break-system-packages ds4drv
sudo python3 setup.py clean --all install

exit
# we don't want the example joystick service installed by default

for file in *.service; do
	[ -f "$file" ] || break
	sudo ln -s $FOLDER/$file /lib/systemd/system/
done


sudo systemctl daemon-reload
