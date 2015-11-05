# Ricardo Rodríguez <ricardo96r@gmail.com>
# Numeros perfecto por definicion. Este metodo es el mas largo y nada eficiente
.data
insertar_numero: .asciiz "\n Insertar el numero: "
siperfecto: .asciiz "\n El numero es perfecto"
noperfecto: .asciiz "\n El numero no es perfecto"
divisores: .space 1000 # Maximo 250 divisores del numero
espacio: .asciiz " "

.text
main:	li $v0 4
	la $a0 insertar_numero
	syscall
	li $v0 5
	syscall
	move $t0 $v0
	move $t1 $t0 # contador de divisor
	li $t2 0 # guardar el cociente // numero de divisores
	li $t3 0 # guardar el resto // contador de divisores sumados
	li $t4 0 # contador de bytes del vector
	li $t5 1 # Usado por el brach en divisores_loop como parada
	b divisores_loop
	
divisores_loop:
	beq $t1 $t5 sumar_vector
	div $t2 $t0 $t1
	mfhi $t3
	subi $t1 $t1 1
	jal guardar_en_vector
	b divisores_loop
	
guardar_en_vector:
	bnez $t3 divisores_return
	sh $t2 divisores($t4)
	addi $t4 $t4 2
	b divisores_return

divisores_return:
	jr $ra
	
sumar_vector:
	div $t2 $t4 2 # numero de divisores
	li $t4 0 # contador de bytes
	li $t1 0 # donde se guarda la suma
	b sumar_vector_loop # cambiar con mostrar_vector para test
	
sumar_vector_loop:
	beq $t2 $t3 perfecto
	lh $t5 divisores($t4)
	add $t1 $t1 $t5
	addi $t4 $t4 2
	addi $t3 $t3 1
	b sumar_vector_loop
	
perfecto:
	beq $t0 $t1 es_perfecto
	b no_perfecto
	
es_perfecto:
	la $a0 siperfecto
	li $v0 4
	syscall
	b exit
	
no_perfecto:
	la $a0 noperfecto
	li $v0 4
	syscall
	b exit

# Label no usado en el programa, solo es para mostrar el vector para probar lo que esta en el vector	
mostrar_vector:
	beq $t2 $t3 exit
	lh $a0 divisores($t4)
	li $v0 1
	syscall
	la $a0 espacio
	li $v0 4
	syscall
	addi $t4 $t4 2
	addi $t3 $t3 1
	b mostrar_vector

exit:	li $v0 10
	syscall