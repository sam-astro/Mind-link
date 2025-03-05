# Mind-link

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
