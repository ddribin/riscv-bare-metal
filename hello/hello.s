.section .text
.global _start

.equ UART_BASE, 0x10000000
.equ UART_THR,  0           # Transmit Holding Register (THR)

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
    j       finish          # infinite loop

.section .rodata
message:
  .string "Hello, world!\n"
