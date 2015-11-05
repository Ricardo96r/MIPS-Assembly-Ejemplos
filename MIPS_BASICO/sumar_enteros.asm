# Ricardo Rodríguez <ricardo96r@gmail.com>
# Promagra que suma dos numeros enteros

.data
saludo1: .asciiz "\n Programa que suma dos numeros!"
saludo2: .asciiz "\n Inserte el 1er numero: "
saludo3: .asciiz "\n Inserte el 2do numero: "
saludo4: .asciiz "\n La suma es: "

.text

main:
	# Intro
	la $a0 saludo1
	li $v0 4
	syscall
	
	# Pedir Numero 1
	la $a0 saludo2
	li $v0 4
	syscall
	li $v0 5
	syscall
	move $t0 $v0
	
	# Pedir numero 2
	la $a0 saludo3
	li $v0 4
	syscall
	li $v0 5
	syscall
	move $t1 $v0
	
	# Sumar los numeros
	la $a0 saludo4
	li $v0 4
	syscall
	add $a0 $t0 $t1
	li $v0 1
	syscall
	
	# Cierre del programa
	li $v0 10
	syscall