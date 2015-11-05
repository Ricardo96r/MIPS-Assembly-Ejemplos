# Ricardo Rodríguez <ricardo96r@gmail.com>
# ¿Que hay en el Stack?
.include "macros.asm"
.data

.text
.globl main
main:	.eqv stack $sp
	.eqv contador $t0
	.eqv byte $t1
	
loop:	beq contador 1000 exit
	lb byte (stack)
	print_int(byte)
	print_str(" ")
	addi contador contador 1
	b loop
	
exit:	exit()
