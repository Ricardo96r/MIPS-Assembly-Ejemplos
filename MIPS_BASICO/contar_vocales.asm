# Ricardo Rodríguez <ricardo96r@gmail.com>
# Contar las vocales que tiene un STRING

.data
vocales: .asciiz "AEIOUaeiou"
texto: .asciiz "Esto es una oracion hecha con caracteres ascii"
saludo: .asciiz "\n La cantidad de vocales que existen son: "
.text
main:	li $t0 0 # contador de bytes de texto
	li $t1 1 # donde se guarda la letra de texto
	li $t2 0 # contador de bytes de vocales
	li $t3 1 # donde se guarda la letra texto
	li $t4 0 # contador de vocales 
	
texto_loop:
	beqz $t1 mostrar
	lb $t1 texto($t0)
	jal vocales_loop
	addi $t0 $t0 1
	b texto_loop
	
vocales_loop:
	beqz $t3 vocales_return
	beq $t1 $t3 iguales
	lb $t3 vocales($t2)
	addi $t2 $t2 1
	b vocales_loop
	
iguales:
	addi $t4 $t4 1
	b vocales_return
	
vocales_return:
	li $t2 0
	li $t3 1
	jr $ra
	
mostrar:
	la $a0 saludo
	li $v0 4
	syscall
	move $a0 $t4
	li $v0 1
	syscall
	b exit

exit:	li $v0 10
	syscall