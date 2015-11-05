# Ricardo Rodríguez <ricardo96r@gmail.com>
# Prender bit de un numero
.include "macros.asm"
.data

.text
.globl main
.eqv numero $t0
.eqv logicalLeft $t1
.eqv uno $t2

main:	print_str("Insertar un numero: ")
	read_int(numero)
	print_str("Insertar el bit a prender (0-31): ")
	read_int(logicalLeft)
	li uno 1
	print_binary(numero)
	print_str("\n")
	sllv logicalLeft uno logicalLeft
	or numero numero logicalLeft
	print_binary(numero)
	print_str(" -> ")
	print_int(numero)

exit:	exit()
