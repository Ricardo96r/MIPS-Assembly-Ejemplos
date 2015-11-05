# Ricardo Rodríguez <ricardo96r@gmail.com>
# Obtener los numeros de fibonacci

.data
saludo1: .asciiz "\n Obtener los numeros de fibonacci"
saludo2: .asciiz "\n Insertar la cantidad de numeros de fibonacci a mostrar: "
espacio: .asciiz " "

.text
main:	li $v0 4
	la $a0 saludo1
	syscall
	la $a0 saludo2
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # cantidad de numeros pedidos
	li $t1 0 # cantidad de numeros mostrados
	li $t2 1 # registro donde se guarda el actual
	li $t3 0 # registro donde se guarda el anterior
	li $t4 0 # registro temporal para copiar $t2 en $t3
	
loop:	beq $t0 $t1 exit
	li $v0 1
	move $a0 $t2
	syscall
	li $v0 4
	la $a0 espacio
	syscall
	move $t4 $t2
	add $t2 $t2 $t3
	move $t3 $t4
	addi $t1 $t1 1
	b loop

exit:	li $v0 10
	syscall