# Ricardo Rodríguez <ricardo96r@gmail.com>
# Saber si un numero es primo

.data
intro: .asciiz "\n Saber si un numero es primo"
pedir_num: .asciiz "\n Insertar el numero: "
saludo_no: .asciiz "\n El numero no es primo"
saludo_si: .asciiz "\n El numero es primo"

.text
main:	li $v0 4
	la $a0 intro
	syscall
	la $a0 pedir_num
	syscall
	li $v0 5
	syscall
	move $t0 $v0
	li $t1 2
	
loop:   beq $t0 $t1 es_primo
	div $t0 $t1
	mfhi $t2
	beqz $t2 no_primo
	addi $t1 $t1 1
	b loop
	
no_primo:
	li $v0 4
	la $a0 saludo_no
	syscall
	b exit
	
es_primo:
	li $v0 4
	la $a0 saludo_si
	syscall
	b exit
	
exit:	li $v0 10
	syscall