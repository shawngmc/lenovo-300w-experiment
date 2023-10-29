#!/bin/bash

mkdir -pv ~/tmp/acpi
cd ~/tmp/acpi

acpidump -b
iasl -d dsdt.dat


