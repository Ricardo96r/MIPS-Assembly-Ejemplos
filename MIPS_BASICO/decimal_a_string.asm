# Ricardo Rodríguez <ricardo96r@gmail.com>
# Pide un numero y lo imprime por syscall 4, usando el stack

.data
pedir_num: .asciiz "\n- Insertar el numero: "
salida: .asciiz "\n- Por syscall 4: "

.text
main:	li $v0 4
	la $a0 pedir_num
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # Guardado el numero
	li $t1 0 # guardar el resto

# Este loop separa cada digito dividiendo por 10 y convirtiendolo en ascii y guardandolo en el stack
loop:	beqz $t0 mostrar
	div $t0 $t0 10
	mflo $t0
	mfhi $t1
	addi $t1 $t1 48
	subi $sp $sp 1
	sb $t1 ($sp)
	b loop
	
mostrar:la $a0 salida
	li $v0 4
	syscall
	move $a0 $sp
	syscall

exit:	li $v0 10
	syscall