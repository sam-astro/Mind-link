# Mind-link 🧠
Project creating a proof-of-concept brain-computer interface from scratch. If you are looking for a working system using the method of EEG, look at using old Mind-Flex hardware, and this mod PCB: https://github.com/sam-astro/MindFlexFast-Mod

<img width="50%" alt="vlcsnap-2025-06-25-21h47m47s892" src="https://github.com/user-attachments/assets/8e6cca74-9a17-41f1-9ec4-bdeceecad39c" />

> An image of the PCB stack module

<img width="50%" alt="image" src="https://github.com/user-attachments/assets/8215e19b-1a90-4462-a958-d969c4d6243f" />

> An image of a body made of different materials

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
