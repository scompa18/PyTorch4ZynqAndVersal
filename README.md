# Building PyTorch for AMD Xilinx Zynq and Versal
## Requirements
It is necessary to have Docker or Podman installed (obviously). If your CPU architecture is not aarch64 (almost always), you need to install QEMU in order to emulate it. In Ubuntu, the installation goes as follows (this does not work if done in a container, it needs to be on the host machine)

```bash
sudo apt install qemu-user-static binfmt-support
update-binfmts --display
```

Check that the emulator has been correctly registered by verifying the presence of

```bash
cat /proc/sys/fs/binfmt_misc/qemu-aarch64
```

This step is fundamental as it registers the emulator so that it gets automatically called when a binary file with the aarch64 architecture is executed.

At least 32 GB of RAM are usually necessary for building the system. If you have less add some swap. It will make the compilation even slower but should ensure your system won't run out of memory.

## Building
Just run
```bash
./create_stuff.sh
```

The will should be found in the home directory of the build system.

It will take ~20 hours on a 16 thread machine. You could also simply get the built wheel.