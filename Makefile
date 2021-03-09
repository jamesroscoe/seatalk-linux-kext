obj-m += seatalk.o
seatalk-y := seatalk_module.o ../seatalk-hardware-linux-gpio/seatalk_hardware_layer.o ../seatalk-instruments/boat_status.o ../seatalk-instruments/boat_sensor.o ../seatalk/seatalk_transport_layer.o ../seatalk/seatalk_datagram.o ../seatalk/seatalk_protocol.o ../seatalk-instruments/seatalk_command.o timeout.o

KDIR = /lib/modules/$(shell uname -r)/build

all:
	make -C $(KDIR)  M=$(shell pwd) modules

clean:
	make -C $(KDIR)  M=$(shell pwd) clean

modules_install: all
	#(MAKE) -C $(KERNEL_SRC) M=$(SRC) modules_install
	$(DEPMOD)
