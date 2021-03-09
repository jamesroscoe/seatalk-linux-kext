# Linux Kernel Extension example for open-source SeaTalk library

These files are vanilla C code so *.cpp could in theory be renamed to .c if for some reason that became necessary.

This is not officially supported in any way, shape or form by anyone. *Use this at your own risk!*

This could not have been possible without Thomas Knauf's absolutely indispensible SeaTalk reference found here: http://www.thomasknauf.de/seatalk.htm. Thank you, Thomas, for all the work it must have taken to work out the protocol details! I am in awe.

This is a library only and will not compile a executable file. Related projects:
- (seatalk)[https://github.com/jamesroscoe/seatalk.git] The base SeaTalk library.
- (seatalk-hardware-linux-gpio)[https://github.com/jamesroscoe/seatalk-hardware-linux-gpio.git] Use GPIO pins on a Linux device (eg Raspberry Pi) to read and write SeaTalk data. Use in conjunciton with this library as GPIO pins must be manipulated from within kernel space.

## Using the Linux kernel extension

This has been tested on a Raspberry Pi. There is nothing in the source code that is obviously RPi-specific so in theory it should compile for any Linux machine that provides you with GPIO pins.

The Linux kernel extension (once compiled) makes this very easy. You
To compile the kernel extension you will first need to have the kernel headers for your specific Linux version. That is beyond the scope of this README. Once you have that:

    $ cd seatalk/linux
    $ sudo make

Install the kernel extension using:

    $ sudo insmod seatalk.ko

Should you need to uninstall it use:

    $ sudo rmmod seatalk.ko

You can then connect to the computer whatever bridge hardware you have and run a loopback test with:

    $ sudo test/test_kernel_extension

The kernel extension will add virtual files in three directories:

    /sys/seatalk/sensors
    /sys/seatalk/status
    /sys/seatalk/commands

* To write a sensor value to the SeaTalk bus write its value to the appropriate file in /sys/seatalk/sensors (eg heading). Note that this can only be done from the root account (ie you need to use "sudo -i" or your program needs to be running as a daemon).
* To read a status value that has been broadcast on the SeaTalk bus read it from the appropriate file in /sys/seatalk/status (eg the autopilot subdirectory).
* all numeric data is presented as an integer. Where decimals are necessary a multiplier (10 or 100) is applied. Status and sensor value names include a description of any such multipliers (eg water_speed_in_knots_times_100).
