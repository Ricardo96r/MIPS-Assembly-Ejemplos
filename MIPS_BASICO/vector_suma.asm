.data
vector: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9

.text
main:	li $t0 0 # acumulador
	li $t1 0 # contador de 4 en 4
	
loop:	beq $t1 40 print
	lw $t2 vector($t1)
	add $t0 $t0 $t2
	add $t1 $t1 4
	b loop

print:	move $a0 $t0
	li $v0 1
	syscall
	b exit
		
exit:	li $v0 10
	syscall
