# Ricardo Rodríguez <ricardo96r@gmail.com>
# Obtiene el numero en forma unaria

.data
saludo1: .asciiz "\n Representacion unaria de un numero"
saludo2: .asciiz "\n Inserte el numero: "
unaria: .asciiz "|"

.text
main:	li $v0 4
	la $a0 saludo1
	syscall
	la $a0 saludo2
	syscall
	li $v0 5
	syscall
	move $t0 $v0
	li $t1 0 # contador
	
loop: 	beq $t1 $t0 exit
	la $a0 unaria
	li $v0 4
	syscall
	addi $t1 $t1 1
	b loop

exit:	li $v0 10
	syscall