.include "macros.asm"
# Insertar un string y que te devuelva la cantidad de letras 
# y ordenarlo en forma descendente 

.data
cadena: .space 80
abecedario: .space 26

.text
.globl main
main: 	li $v0 8
	la $a0 cadena
	li $a1 80
	syscall
	li $t0 0
	li $t1 65
	
contar:	beq $t1 91 ord
	li $t0 0 # <----
	jal contar_letras
	addi $t1 $t1 1
	b contar
	
contar_letras:
	lb $t2 cadena($t0)
	addi $t0 $t0 1
	beq $t2 10 contar_return
	bne $t2 $t1 contar_letras
	subi $t3 $t1 65
	lb $t4 abecedario($t3)
	addi $t4 $t4 1
	sb $t4 abecedario($t3)
	b contar_letras
	
contar_return:
	jr $ra
	
ord:	li $t0 -1

siga:	addi $t0 $t0 1
ordenar:lb $t1 cadena($t0)
	beq $t1 10 mostrar
	move $t2 $t0
loop:	addi $t2 $t2 1
	lb $t3 cadena($t2)
	beq $t3 10 siga
	bge $t1 $t3 loop
	sb $t1 cadena($t2)
	sb $t3 cadena($t0)
	move $t1 $t3
	b loop	

mostrar:li $t0 -1
m_contar:
	addi $t0 $t0 1
	lb $t1 abecedario($t0)
	beq $t0 25 vector_mostrar
	beqz $t1 m_contar
	li $v0 11
	move $a0 $t0
	addi $a0 $a0 65
	syscall
	print_str(" = ")
	move $a0 $t1
	li $v0 1
	syscall
	print_str(" ")
	b m_contar
	
vector_mostrar: li $t0 0
v_mostrar:
	lb $a0 cadena($t0)
	beq $a0 10 exit
	li $v0 11
	syscall
	addi $t0 $t0 1
	b v_mostrar

exit:	li $v0 10
	syscall
