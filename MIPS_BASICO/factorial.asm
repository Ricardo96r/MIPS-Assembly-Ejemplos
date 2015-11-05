# Ricardo Rodríguez <ricardo96r@gmail.com>
# Saca el factorial de un numero. Maximo 13!

.data
saludo: .asciiz "\n Programa que obtiene el factorial de un numero"
saludo1: .asciiz "\n Inserter el numero: "
saludo2: .asciiz "\n El factorial es: "

.text
main:	# Intro
	la $a0 saludo
	li $v0 4
	syscall
	# Pedir numero
	la $a0 saludo1
	syscall
	li $v0 5 # pedir numero
	syscall
	move $t0 $v0 # Guardar el numero en $t0
	beqz  $t0 factorial_zero
	addi $t1 $t0-1 # $t1 - 1 para el factorial
	
loop:	beqz $t1 fact # hasta que $t1 sea 0
	mul $t0 $t0 $t1 # t0 = $t0 * $t1
	addi $t1 $t1-1 # t1 -= 1 
	b loop

fact:	la $a0 saludo2
	li $v0 4
	syscall
	move $a0 $t0
	li $v0 1
	syscall
	b exit
	
factorial_zero:
	li $t0 1
	b fact
	
exit:	li $v0 10
	syscall
