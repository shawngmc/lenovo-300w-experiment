#!/bin/bash
cd ~/tmp/acpi

iasl -sa dsdt.dsl
mkdir -pv kernel/firmware/acpi
cp dsdt.aml kernel/firmware/acpi
rm /boot/mod_initrd.img
find kernel | cpio -H newc --create > /boot/mod_initrd.img
cat /boot/initrd.img.old >> /boot/mod_initrd.img
