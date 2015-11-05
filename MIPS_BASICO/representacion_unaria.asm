# Ricardo Rodríguez <ricardo96r@gmail.com>
# Representacion unaria de 3 digitos

.data
saludo1: .asciiz  "\n Insertar el numero: "

.text
main:	li $v0 4
	la $a0 saludo1
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # Guardar en numero
	li $t1 0 # Dividir en 100, 10 o 1
	b centenas
	
centenas:
	li $t1 100 # Dividir entre 100
	div $t0 $t1
	mflo $t1
	mfhi $t0
	jal loop
	b decenas
	
decenas:
	jal separador
	li $t1 10
	div $t0 $t1
	mflo $t1
	mfhi $t0
	jal loop
	b unidades
	
unidades:
	jal separador
	li $t1 1
	div $t0 $t1
	mflo $t1
	mfhi $t0
	jal loop
	b exit

loop:	beqz $t1 loop_return
	li $v0 1
	li $a0 1
	syscall
	sub $t1 $t1 1
	b loop

loop_return:
	jr $ra
	
separador:
	li $a0 0
	syscall
	jr $ra
	
exit:	li $v0 10
	syscall
