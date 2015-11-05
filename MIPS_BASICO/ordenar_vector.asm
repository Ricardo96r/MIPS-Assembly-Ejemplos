# Ricardo Rodríguez <ricardo96r@gmail.com>
# Ordenar vector por metodo selectivo

.data
vector: .byte 9, 7, 4, 2, 3, 11, 0, 8, 5, 6, 10
espacio: .asciiz " "
linea: .asciiz "\n"

.text
main:	li $t0 0 # numeros ordenados, posicion i
	li $t1 0 # contador posicion J
	lb $t2 vector($t0) # donde se guarda el menor
	li $t3 0 # donde se guarda el numero de la posicion J
	li $t4 11 # cantidad de numeros del vector
	li $t5 0 # donde se guarda la posicion del menor

ordenar:beq $t0 $t4 exit
	beq $t1 $t4 es_menor
	addi $t1 $t1 1
	lb $t3 vector($t1)
	bge $t2 $t3 nuevo_menor
	b ordenar

nuevo_menor:
	move $t2 $t3
	move $t5 $t1
	b ordenar
	
es_menor:
	lb $t3 vector($t0)
	beq $t2 $t3 preparar # cuando el menor es el mismo menor
	sb $t3 vector($t5)
	sb $t2 vector($t0)
	b preparar

# prepara el siguiente loop de ordenacion	
preparar:
	addi $t0 $t0 1
	lb $t2 vector($t0)
	move $t1 $t0
	jal mostrar
	b ordenar
	
mostrar:li $t6 0
	b mostrar_loop
	
mostrar_loop:
	beq $t6 $t4 return
	lb $a0 vector($t6)
	li $v0 1
	syscall
	la $a0 espacio
	li $v0 4
	syscall
	addi $t6 $t6 1
	b mostrar_loop
	
return:	la $a0 linea
	li $v0 4
	syscall
	jr $ra

exit:	li $v0 4
	syscall
