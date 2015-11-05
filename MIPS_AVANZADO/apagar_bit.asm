# Ricardo Rodríguez <ricardo96r@gmail.com>
# Apagar bit de un numero
.include "macros.asm"
.data

.text
.globl main
.eqv numero $t0
.eqv logicalLeft $t1
.eqv byteUnos $t2
.eqv uno $t3

main:	print_str("Insertar un numero: ")
	read_int(numero)
	print_str("Insertar el bit a apagar (0-31): ")
	read_int(logicalLeft)
	li byteUnos -1
	li uno 1
	print_binary(numero)
	print_str("\n")
	sllv logicalLeft uno logicalLeft
	xor logicalLeft logicalLeft byteUnos
	print_binary(logicalLeft)
	print_str("\n")
	and numero numero logicalLeft
	print_str("AND____________________________ \n")
	print_binary(numero)
	print_str(" -> ")
	print_int(numero)

exit:	exit()
