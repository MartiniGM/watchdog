if [ $# -ne 2 ]
  then
    echo "build_devlist.sh: creates persistent names for attached Arduinos."
    echo "Put output file in /etc/udev/rules.d to create Arduino symlinks."
    echo "Usage: build_devlist.sh [input files] [output file]..."
    echo "Example: build_devlist.sh /dev/ttyACM /etc/udev/rules.d/99-usb-serial.rules"
    exit
fi

if [ -f $2 ] ; then
echo "$2 found, renaming original to $2.old"
mv $2 $2.old
fi

x=1

for i in $(ls $1*); do
  echo $i
  vendorstring=`udevadm info -a -n $i`
  serial=`grep '{serial}' <<< "$vendorstring" | head -n1 | sed 's/.*"\(.*\)"[^"]*$/\1/'`
  echo "serial" $serial
  vendor=`grep '{idVendor}' <<< "$vendorstring" | head -n1 | sed 's/.*"\(.*\)"[^"]*$/\1/'`
  echo "vendor" $vendor
  product=`grep '{idProduct}' <<< "$vendorstring" | head -n1 | sed 's/.*"\(.*\)"[^"]*$/\1/'`
  echo "product" $product

  echo "SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"$vendor\", ATTRS{idProduct}==\"$product\", ATTRS{serial}==\"$serial\", SYMLINK+=\"arduino$x\""

  echo "SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"$vendor\", ATTRS{idProduct}==\"$product\", ATTRS{serial}==\"$serial\", SYMLINK+=\"arduino$x\"" >> $2

  x=$((x+1))
  echo
done

echo "$((x-1)) arduino entries outputted to $2. Done."