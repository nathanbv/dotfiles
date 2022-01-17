# /etc/profile.d/no_middle_click_on_touchpad.sh
#
# Disable middle click on Lenovo Thinkpad T14 touchpad.
# If `xinput list` returns "id:15" for "Synaptics TM3471-020",
# `xinput get-button-map 15` initially returns "1 2 3 4 5 6 7"
# Depending on the devices connected at boot time the xinput id may change.

XINPUT_TOUCHPAD_ID=$(xinput list | grep "Synaptics" | awk '{print $(NF-3)}' | awk -F "=" '{print $2}')
date >> /tmp/profile.d.log 2>&1
xinput list >> /tmp/profile.d.log 2>&1
echo "xinput id=$XINPUT_TOUCHPAD_ID" >> /tmp/profile.d.log 2>&1
xinput get-button-map ${XINPUT_TOUCHPAD_ID} >> /tmp/profile.d.log 2>&1
xinput set-button-map ${XINPUT_TOUCHPAD_ID} 1 1 3 4 5 6 7 >> /tmp/profile.d.log 2>&1
