# lenovo-300w-experiment
Trying to get a lenovo 300w working with Ubuntu 23.10


# Touchpad
The biggest issue this laptop has is the touchpad. The touchscreen works, but cannot appear to simulate a right-click via long press in all applications (Firefox works; terminal and desktop don't).

Thanks to a_lameira on Reddit, we know part of the problem is a bad ACPI table. There is a weird if/else in the ACPI code that tries to determine which of two touchpad models is present based on a value. That value seems to be hard-coded, but the problem appears to be the variable name they used - CDAT appears to be referenced in a different part of the table.

```
    Name (CDAT, 0x00)
    Scope (_SB.I2CD)
    {
        Device (TPD0)
        {
            Name (_HID, "ELAN0642")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            ICMS = 0x0A
            DCMS = 0x01
            ICMS = 0x20
            CDAT = DCMS /* \DCMS */
            If ((CDAT == 0x02))
            {
                _HID = "SYNA2392"
            }

            If ((CDAT == 0x01))
            {
               _HID = "ELAN0642"
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((CDAT == 0x00))
                {
                    Return (0x00)
                }
                Else
                {
                    Return (0x0F)
                }
            }
```


I've written scripts to try to extract and rebuild the broken ACPI table. Run both with sudo, the modify the files in the root user dir. You need to then modify you grub commands to point to the modified initrd. While the error is suppressed, the touchpad doesn't work, at least with the following modification. 

```
    Scope (_SB.I2CD)
    {
        Device (TPD0)
        {
            Name (_HID, "ELAN0642")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            ICMS = 0x0A
            DCMS = 0x01
            ICMS = 0x20
            _HID = "ELAN0642"

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

```

# Accelerometer
TODO: Try to get screen orientation working.

# Touchscreen
TODO: Try to get consistent long-touch right-click (only works in Firefox).


# Performance
This machine is not fast - that's OK. We just need to make the best of the limited hardware present.

 
