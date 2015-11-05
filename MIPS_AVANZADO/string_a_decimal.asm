.include "macros.asm"
.data
buffer: .space 100
vector: .space 100
.text
.globl main
.eqv contador $t0
.eqv numero $t1
.eqv numMostrados $t2
main:	read_str(buffer, 100)
	
loop:	lb numero buffer(contador)
	beq numero 10 mostrar
	subi numero numero 48
	sb numero vector(contador)
	addi contador contador 1
	b loop
	
mostrar:beq contador numMostrados exit
	lb numero vector(numMostrados)
	print_int(numero)
	addi numMostrados numMostrados 1
	b mostrar

exit: exit()
