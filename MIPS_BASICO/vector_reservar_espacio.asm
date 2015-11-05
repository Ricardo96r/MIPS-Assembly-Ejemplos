# Ricardo Rodríguez <ricardo96r@gmail.com>
# Un vector reserva un espacio de bytes para guardar en el datos durante el programa

.data
cantidad_num: .asciiz "\n Cuantos numeros tendra el vector?: "
pedir_num: .asciiz "\n Insertar el numero para el vector: "
vector: .space 36 # Guarda 10 word = 10 numeros. Cada word son 4 bytes
espacio: .asciiz " "

.text
main:	li $v0 4
	la $a0 cantidad_num
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # cantidad de  numeros que lleva el vector
	li $t1 0 # contador de numeros guardados
	li $t2 0 # contador de bytes
	
pedir_nums:
	beq $t1 $t0 mostrar_vector
	li $v0 4
	la $a0 pedir_num
	syscall
	li $v0 5
	syscall
	sw $v0 vector($t2)
	addi $t1 $t1 1
	addi $t2 $t2 4
	b pedir_nums
	
mostrar_vector:
	li $t2 0
	mul $t1 $t1 4
	b mostrar_vector_loop
	
mostrar_vector_loop:
	beq $t1 $t2 exit
	lw $a0 vector($t2)
	li $v0 1
	syscall
	li $v0 4
	la $a0 espacio
	syscall
	addi $t2 $t2 4
	b mostrar_vector_loop

exit:	li $v0 10
	syscall
