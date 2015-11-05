.data
saludo1: .asciiz "\n Hola Mundo!"

.text

main:
	la $a0 saludo1
	li $v0 4
	syscall
	li $v0 10
	syscall