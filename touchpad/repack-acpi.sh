#!/bin/bash
cd /tmp/acpi

mkdir -pv kernel/firmware/acpi
cp dsdt.aml kernel/firmware/acpi
find kernel | cpio -H newc --create > /boot/mod_initrd.img
cat /boot/initrd.img >> /boot/mod_initrd.img
