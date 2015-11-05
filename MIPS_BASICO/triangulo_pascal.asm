# Ricardo Rodríguez <ricardo96r@gmail.com>
# Mostrar el triangulo de pascal.
# Maximo hasta 13 lineas. > 13 = OVERFLOW, ya que 14! es muy grande

.data
saludo1: .asciiz "\n Triangulo de pascal"
saludo2: .asciiz "\n Cuantas lineas deseas ver: "
espacio: .asciiz " "
linea: .asciiz "\n"

.text
main:	li $v0 4
	la $a0 saludo1
	syscall
	la $a0 saludo2
	syscall
	li $v0 5
	syscall
	# registro para pascal
	move $t0 $v0 # cantidad de lineas pedidos
	li $t1 0 # cantidad de lineas mostradas
	li $t7 0 # contador de numeros de la linea
	# registro para combinacion
	li $t2 0 # numero de combinacion r y/o combinacion total
	li $t3 0 # numero de combinacion k
	li $t4 0 # numero temporal que guarda $t2-t3 para combinacion
	# registro para factorial
	li $t5 0 # numero actual del factorial
	li $t6 0 # $t6-1

pascal_lineas:
	beq $t0 $t1 exit # cantidad de lineas pedidas = mostradas
	b actual_linea

sumar_linea:
	addi $t1 $t1 1 # sumar +1 a lineas mostradas
	li $t7 0 # resetar el registro de numeros mostrados por linea
	li $v0 4
	la $a0 linea
	syscall
	b pascal_lineas
	
actual_linea:
	bgt $t7 $t1 sumar_linea # numero de linea < numeros mostrados en la linea
	move $t2 $t1 # $t2 sera el numero de lineas
	move $t3 $t7 # $t3 sera el contador de numeros mostrados por linea
	jal combinacion
	move $a0 $t2 # $t2 es donde esta el resultado de la combinacion
	li $v0 1
	syscall
	li $v0 4
	la $a0 espacio
	syscall
	addi $t7 $t7 1 # Sumar 1 a numeros mostrados por la linea actual
	b actual_linea

# (r!)/(r-k)!(k!) = (t2!)/($t2-$t3)!($t3!)
combinacion:
	move $s1 $ra
	sub $t4 $t2 $t3 # $t4 = r-k
	move $t5 $t4
	jal factorial
	move $t4 $t5 # $t4 = (r-k)!
	move $t5 $t3
	jal factorial
	move $t3 $t5 # $t3 = k!
	move $t5 $t2
	jal factorial
	move $t2 $t5 # $t2 = r!
	mul $t4 $t4 $t3
	beqz $t2 combinacion_cero # division por 0
	beqz $t4 combinacion_cero # division por 0
	div $t2 $t2 $t4
	b combinacion_return
	
combinacion_cero:
	li $t2 1
	b combinacion_return
	
combinacion_return: 
	jr $s1

factorial:
	move $t6 $t5
	subi $t6 $t6 1
	beqz $t5 factorial_cero # division por 0
	b factorial_loop
	
factorial_loop:
	beqz $t6 factorial_return # termino
	mul $t5 $t5 $t6
	subi $t6 $t6 1
	b factorial_loop
	
factorial_cero:
	li $t5 1
	b factorial_return
	
factorial_return: 
	jr $ra
	
exit:	li $v0 10
	syscall
