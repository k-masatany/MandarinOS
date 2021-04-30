TARGET = mandarinos.elf

CC = gcc
LN_S = ln -s
RANLIB = ranlib
INCLUDES = -I./src/include
FLAGS = -m32 -ffreestanding -fno-common -fno-builtin -fomit-frame-pointer -O2 -c
LD = ld  -melf_i386  -Ttext=0x100000 --oformat elf32-i386 -o

.S.o:
		${CC} ${INCLUDES} ${FLAGS} $<
.c.o:
		${CC} ${INCLUDES} ${FLAGS} $<

BOOT_S = ./src/bootloader/load.S
BOOT_C = ./src/bootloader/boot.c

BOOT_OBJ=${BOOT_S:.S=.o} ${BOOT_C:.c=.o}

all:	mandarinos

mandarinos:   ${BOOT_OBJ}
		${LD} bin/isofiles/boot/${TARGET} ${BOOT_OBJ}
		grub-mkrescue -o ./bin/mandarin_os.iso bin/isofiles/

${BOOT_OBJ}:	${BOOT_SRC}

.PHONY:	clean
clean:
	-${RM}  -f *~ *.lo *.o

.PHONY:	run
run:
	qemu-system-x86_64 -m 512 -boot order=d -cdrom ./bin/mandarin_os.iso
