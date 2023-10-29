#!/bin/bash
cd /tmp/acpi

mkdir -pv kernel/firmware/acpi
cp dsdt.aml kernel/firmware/acpi
find kernel | cpio -H newc --create > /boot/instumented_initrd
cat /boot/initrd >> /boot/instrumented_initrd
