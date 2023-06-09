TOOLCHAIN_PREFIX = riscv64-unknown-elf-
AS = $(TOOLCHAIN_PREFIX)as
LD = $(TOOLCHAIN_PREFIX)ld
OBJCOPY = $(TOOLCHAIN_PREFIX)objcopy
GDB = $(TOOLCHAIN_PREFIX)gdb
QEMU32 = qemu-system-riscv32
QEMU64 = qemu-system-riscv64

.PHONY: all
all: hello.bin

hello.bin: hello.elf
	$(OBJCOPY) -O binary hello.elf hello.bin

hello.elf: hello.o link.lds
	$(LD) --nostdlib -melf32lriscv -T link.lds -Map hello.map -o hello.elf hello.o

hello.o: hello.s
	$(AS) -march=rv32i -o hello.o hello.s

.PHONY: run
run: run32

run32: all
	$(QEMU32) -machine virt -nographic -device loader,file=hello.elf

.PHONY: run64
run64: all
	$(QEMU64) -machine virt -nographic -device loader,file=hello.elf

.PHONY: debug
debug: debug32

.PHONY: debug32
debug32: all
	@echo "In another window:"
	@echo "$(GDB) -x gdb.txt"
	$(QEMU32) -machine virt -nographic -device loader,file=hello.elf -s -S

.PHONY: dts
dts:
	$(QEMU32) -machine virt,dumpdtb=qemu-riscv32-virt.dtb
	dtc qemu-riscv32-virt.dtb > qemu-riscv32-virt.dts
	$(QEMU64) -machine virt,dumpdtb=qemu-riscv64-virt.dtb
	dtc qemu-riscv64-virt.dtb > qemu-riscv64-virt.dts

.PHONY: clean
clean:
	$(RM) *.o *.elf *.bin *.map *.dtb
