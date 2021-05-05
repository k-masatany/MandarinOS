TARGET = mandarinos.elf
BOOTLOADER_DIR = ./src/bootloader/
BINARY_DIR = ./bin/isofiles/boot/
BOOT_OBJ = multiboot_header.o boot.o

all:	iso

# ブートローダ
multiboot_header.o:
	nasm -f elf64 ${BOOTLOADER_DIR}multiboot_header.asm

boot.o:
	nasm -f elf64 ${BOOTLOADER_DIR}boot.asm

# カーネルビルド
kernel: ${BOOT_OBJ}
	ld -n -o ${BINARY_DIR}${TARGET} -T ${BOOTLOADER_DIR}linker.ld ${BOOTLOADER_DIR}multiboot_header.o ${BOOTLOADER_DIR}boot.o

# ディスクイメージ作成
iso: kernel
	grub-mkrescue -o ./bin/mandarin_os.iso bin/isofiles/

# 不要ファイルの削除
.PHONY:	clean
clean:
	-${RM}  -f *~ *.lo *.o

# エミュレータ実行
.PHONY:	run
run:
	qemu-system-x86_64 -m 512 -boot order=d -cdrom ./bin/mandarin_os.iso
