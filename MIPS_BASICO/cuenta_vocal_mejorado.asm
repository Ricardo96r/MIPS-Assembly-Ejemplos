.data
texto: .asciiz "LOS SISTEMICOS SON LO MEJOR"
vocales:
	.space 65
	.byte 1,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0
	.space 165
.text
main: li $t0 0

loop:	lb $t1 texto($t0)
	beqz $t1 mostrar
	lb $t2 vocales($t1)
	add $t3 $t3 $t2
	addi $t0 $t0 1
	b loop
	
mostrar:move $a0 $t3
	li $v0 1
	syscall

exit:	li $v0 10
	syscall