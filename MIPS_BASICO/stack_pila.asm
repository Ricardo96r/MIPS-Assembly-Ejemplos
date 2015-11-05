# Ricardo Rodríguez <ricardo96r@gmail.com>
# Ejemplo de uso del stack.
# Pide una cantidad de numeros que se guardan... 
# ...en el stack, para luego mostrarlos desde el mismo stack

.data
cuantos_numeros: .asciiz "\n ¿Cuántos números desea agregar?: "
pedir_numero: .asciiz "\n Insertar el numero: "
espacio: .asciiz " "

.text
main:	li $v0 4
	la $a0 cuantos_numeros
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # Cantidad de numeros
	li $t1 0 # Contador de numeros
	li $t2 0 # temporal, para guardar en el stack
	b pedir_numeros
	
pedir_numeros:
	beq $t0 $t1 mostrar_numeros
	li $v0 4
	la $a0 pedir_numero
	syscall
	li $v0 5
	syscall
	move $t2 $v0
	add $t1 $t1 1
	sub $sp $sp 1
	sb $t2 ($sp)
	b pedir_numeros
	
mostrar_numeros:
	lb $a0 ($sp)
	add $sp $sp 1
	beqz $a0 exit
	li $v0 1
	syscall
	li $v0 4
	la $a0 espacio
	syscall
	b mostrar_numeros
	
exit:	li $v0 10
	syscall
