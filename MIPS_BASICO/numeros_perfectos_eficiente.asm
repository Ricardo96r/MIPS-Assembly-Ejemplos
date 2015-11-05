# Ricardo Rodríguez <ricardo96r@gmail.com>
# Mostrar los numeros perfectos eficientemente por teorema (2´n-1)((2´n) - 1) donde n es primo
# Solo se pueden ver los 6 primeros numeros perfectos, ya que sobrepasa el tamaño de un word

.data
cant_num: .asciiz "\n Cuantos numeros perfectos quieres ver: "
espacio: .asciiz " "

.text
main:	la $a0 cant_num
	li $v0 4
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # cantidad de numeros a mostrar
	li $t1 0 # contador de numeros mostrados
	li $t7 0 # guardar en el 2 ala n-1 // guarda el numero perfecto
	li $t8 0 # guardar en el (2 ala n) - 1
	# obtener primo
	li $s0 1 # guardar el primo actual
	li $s1 2 # contador, se toma como divisores
	li $s2 0 # guardar resto
	# Potenciacion
	li $t2 0 # guardar la base de la potenciacion
	li $t3 0 # guardar el exponente
	li $t4 0 # contador
	li $t5 0 # guardar la potenciacion
	li $t6 1 # cuando el exponente es 1
	b numeros_perfectos_loop
	
siguiente_primo:
	beq $s0 $s1 primo_return
	div $s0 $s1
	mfhi $s2
	beqz $s2 no_primo
	addi $s1 $s1 1
	b siguiente_primo
	
no_primo:
	li $s1 2
	addi $s0 $s0 1
	b siguiente_primo
	
primo_return:
	li $s1 2
	jr $ra

numeros_perfectos_loop:
	beq $t0 $t1 exit
	addi $s0 $s0 1
	jal siguiente_primo
	# 2 ala n-1
	move $t3 $s0
	subi $t3 $t3 1
	li $t2 2
	jal potenciacion
	move $t7 $t5
	# (2 ala n) - 1
	move $t3 $s0
	li $t2 2
	jal potenciacion
	move $t8 $t5
	subi $t8 $t8 1
	# $t8 * $t7
	mulu $t7 $t7 $t8
	jal mostrar_perfecto
	addi $t1 $t1 1
	b numeros_perfectos_loop
	
mostrar_perfecto:
	li $v0 1
	move $a0 $t7
	syscall
	li $v0 4
	la $a0 espacio
	syscall
	jr $ra
	
potenciacion:
	beqz $t3 potenciacion_cero
	beq $t3 $t6 potenciacion_uno
	li $t4 1 # cuando el exponente es mayor a 2
	li $t5 2
	b potenciacion_loop

potenciacion_loop:
	beq $t4 $t3 potenciacion_return
	addi $t4 $t4 1
	mulu $t5 $t5 $t2
	b potenciacion_loop
	
potenciacion_uno:
	move $t5 $t2
	b potenciacion_return

potenciacion_cero:
	li $t5 1
	b potenciacion_return
	
potenciacion_return:
	jr $ra

exit:	li $v0 10
	syscall