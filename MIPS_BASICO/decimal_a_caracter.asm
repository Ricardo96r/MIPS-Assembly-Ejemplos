# Ricardo Rodríguez <ricardo96r@gmail.com>
# convierte un digito decimal a la tabla ascii y lo imprime por syscall 11

.data
cuantos_numeros: .asciiz "\n ¿Cuántos números desea agregar?: "
pedir_numero: .asciiz "\n Insertar el numero: "
espacio: .asciiz " "
vector: .space 1000 # 250 word

.text
main:	li $v0 4
	la $a0 cuantos_numeros
	syscall
	li $v0 5
	syscall
	move $t0 $v0
	li $t1 0 # contador de numero agregados al stack
	li $t2 0 # contador de bytes
	
pedir_numero_loop:
	beq $t0 $t1 guardar_en_vector
	li $v0 4
	la $a0 pedir_numero
	syscall
	li $v0 5
	syscall
	subi $sp $sp 1
	addi $v0 $v0 49
	sb $v0 ($sp)
	addi $t1 $t1 1
	b pedir_numero_loop
	
guardar_en_vector:
	beq $t0 $t2 a_string
	lb $t1 ($sp)
	sb $t1 vector($t2)
	addi $t2 $t2 1
	addi $sp $sp 1
	b guardar_en_vector
	
a_string:
	li $t1 0 # contador de numeros mostrados
	li $t2 0 # contador de bytes
	b mostrar_string
	
mostrar_string:
	beq $t0 $t1 exit
	lb $a0 vector($t1)
	li $v0 11
	syscall
	li $v0 4
	la $a0 espacio
	syscall
	addi $t1 $t1 1
	b mostrar_string

exit:	li $v0 10
	syscall
