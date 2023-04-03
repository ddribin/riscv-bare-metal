# UART Device, NS16550A compatible
.equ UART_BASE, 0x10000000

# Transmit Holding Register (THR)
# Information written to this port are treated as data words
# and will be transmitted by the UART.
.equ UART_THR, 0

# SiFive Test Device
.equ SIFIVE_TEST, 0x100000
.equ SIFIVE_TEST_POWEROFF_ERROR, 0x3333
.equ SIFIVE_TEST_POWEROFF_SUCCESS, 0x5555
.equ SIFIVE_TEST_REBOOT, 0x7777


.section .text
.globl _start

_start:
    li      s1, UART_BASE   # s1 := 0x1000_0000
    la      s2, message     # s2 := <message>
1:
    lb      s4, 0(s2)       # s4 := (s2)
    beqz    s4, finish      # if s4 == 0, branch to finish
    sb      s4, UART_THR(s1)       # (s1) := s4
    addi    s2, s2, 1       # s2 := s2 + 1
    j       1b              # branch back to 1

finish:
    # Causes QEMU machine to power off, a.k.a exit
    li      s1, SIFIVE_TEST
    li      s2, SIFIVE_TEST_POWEROFF_SUCCESS
    sw      s2, 0(s1)

.section .rodata
message:
  .string "Hello, world!\n"
