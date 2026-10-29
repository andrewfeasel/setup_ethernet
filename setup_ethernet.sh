#!/bin/sh
set -e

printf "Enter an Ethernet device from the options:\n"
printf "THIS PROGRAM WILL WIPE/REPLACE ALL IP ADDRESSES ON THE DEVICE!!\n\n"

ip -json addr show | jq -r '.[] | select (.link_type == "ether") | .ifname'
printf "\n"
read ethernet_device
printf "\n"

sudo ip addr flush dev "$ethernet_device"

echo "Select the IP address to use for the Ethernet device:"
read ethernet_ip_address
printf "\n"

ip addr add "$ethernet_ip_address" dev "$ethernet_device"
ip link set "$ethernet_device" up

echo "Ethernet setup complete. Ethernet device status:"
ip addr show dev "$ethernet_device"
