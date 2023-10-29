#!/bin/bash

mkdir -pv /tmp/acpi
cd /tmp/acpi

sudo acpidump -b
iasl -d dsdt.dat


