# Mind-link 🧠
Project creating a proof-of-concept brain-computer interface from scratch. If you are looking for a working system using the method of EEG, look at using old Mind-Flex hardware, and this mod PCB: https://github.com/sam-astro/MindFlexFast-Mod

### Compilation and Uploading Steps:

Edit `makefile` LUFA library path:

```makefile
LUFA_PATH    = ../lufa/LUFA
```

Run `make`

```
make
```

There should be a file named `Mind-link.hex` inside of the current directory.

Using a USBasp programmer, attached to the Mind-link ICSP header, we will now use avrdude to upload the hex file.

```
avrdude -p m32u2 -P usb -c usbasp -u -U flash:w:Mind-link.hex
```
