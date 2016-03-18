switch="$1"
if [[ $switch == "A" ]] ; then
    ./get_poe.exp "10.42.0.3"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.3" | grep " on" | wc -l
elif [[ $switch == "a" ]] ; then
    ./get_poe.exp "10.42.0.3"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.3" | grep " on" | wc -l
elif [[ $switch == "B" ]] ; then
    ./get_poe.exp "10.42.0.3"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.3" | grep " on" | wc -l
elif [[ $switch == "b" ]] ; then
    ./get_poe.exp "10.42.0.3"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.3" | grep " on" | wc -l
elif [[ $switch == "C" ]] ; then
    ./get_poe.exp "10.42.0.4"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.4" | grep " on" | wc -l
elif [[ $switch == "c" ]] ; then
    ./get_poe.exp "10.42.0.4"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.4" | grep " on" | wc -l
elif [[ $switch == "D" ]] ; then
    ./get_poe.exp "10.42.0.5"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.5" | grep " on" | wc -l
elif [[ $switch == "d" ]] ; then
    ./get_poe.exp "10.42.0.5"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.5" | grep " on" | wc -l
elif [[ $switch == "E" ]] ; then
    ./get_poe.exp "10.42.0.6"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.6" | grep " on" | wc -l
elif [[ $switch == "e" ]] ; then
    ./get_poe.exp "10.42.0.6"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.6" | grep " on" | wc -l
elif [[ $switch == "F" ]] ; then
    ./get_poe.exp "10.42.0.7"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.7" | grep " on" | wc -l
elif [[ $switch == "f" ]] ; then
    ./get_poe.exp "10.42.0.7"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.7" | grep " on" | wc -l
elif [[ $switch == "G" ]] ; then
    ./get_poe.exp "10.42.0.8"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.8" | grep " on" | wc -l
elif [[ $switch == "g" ]] ; then
    ./get_poe.exp "10.42.0.8"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.8" | grep " on" | wc -l
elif [[ $switch == "H" ]] ; then
    ./get_poe.exp "10.42.0.9"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.9" | grep " on" | wc -l
elif [[ $switch == "h" ]] ; then
    ./get_poe.exp "10.42.0.9"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.9" | grep " on" | wc -l
elif [[ $switch == "I" ]] ; then
    ./get_poe.exp "10.42.0.10"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.10" | grep " on" | wc -l
elif [[ $switch == "i" ]] ; then
    ./get_poe.exp "10.42.0.10"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.10" | grep " on" | wc -l
elif [[ $switch == "J" ]] ; then
    ./get_poe.exp "10.42.0.11"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.11" | grep "on" | wc -l
elif [[ $switch == "j" ]] ; then
    ./get_poe.exp "10.42.0.11"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.11" | grep " on" | wc -l
elif [[ $switch == "K" ]] ; then
    ./get_poe.exp "10.42.0.12"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.12" | grep " on" | wc -l
elif [[ $switch == "k" ]] ; then
    ./get_poe.exp "10.42.0.12"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.12" | grep " on" | wc -l
elif [[ $switch == "L" ]] ; then
    ./get_poe.exp "10.42.0.13"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.13" | grep " on" | wc -l
elif [[ $switch == "l" ]] ; then
    ./get_poe.exp "10.42.0.13"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.13" | grep " on" | wc -l
elif [[ $switch == "M" ]] ; then
    ./get_poe.exp "10.42.0.14"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.14" | grep " on" | wc -l
elif [[ $switch == "m" ]] ; then
    ./get_poe.exp "10.42.0.14"
    echo
    echo "total devices on poe:"
    ./get_poe.exp "10.42.0.14" | grep " on" | wc -l
else
    echo "don't recognize switch name"
fi