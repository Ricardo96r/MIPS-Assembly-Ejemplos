# Ricardo Rodríguez <ricardo96r@gmail.com>
# Uso de lui
.include "macros.asm"

.data

.text
.globl main
main:	lui $t0 0x0001 # lui hace un sll de 16bits
	print_binary($t0)
	print_str("\n")
	print_int($t0)
	print_str("\n")
	print_hex($t0)

exit:	exit()