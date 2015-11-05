# Ricardo Rodríguez <ricardo96r@gmail.com>
# Libreria de macros para matrices

###############################################################
# Limpia los contenidos de los registros
.macro reset()
	li $a0 0
	li $a1 0
	li $a2 0
	li $a3 0
	li $s0 0
	li $s1 0
	li $s2 0
.end_macro

###############################################################
# Cantidad de numeros de la matriz. Retorna (size-1)
.macro size_matriz(%save, %sizeI, %sizeJ)
	mul $v0 %sizeI %sizeJ
	subi $v0 $v0 1
	move %save $v0
.end_macro

###############################################################
# Subrutina. Muestra por pantalla la matriz
# numero   $a0
# _i       $a1
# _j       $a2
# contador $a3

.macro mostrar(%matriz, %sizeI, %sizeJ)
mostrar:reset()
	b mostrar_loop_i
mostrar_loop_i:
	beq $a1 %sizeJ mostrar_return
	li $a2 0
	jal mostrar_loop_j
	print_str("\n")
	addi $a1 $a1 1
	b mostrar_loop_i
mostrar_loop_j:
	beq $a2 %sizeI mostrar_loop_i_return
	lb $a0 %matriz($a3)
	print_int($a0)
	print_str("\t")
	addi $a2 $a2 1
	addi $a3 $a3 1
	b mostrar_loop_j
mostrar_loop_i_return:
	return
mostrar_return:
	# FIN
.end_macro

###############################################################
# Copia la matriz en otra matriz
# numero   $a0
# contador $a1
.macro copiar_matriz(%save, %matriz, %size)
copiar_matriz:
	reset()
	b copiar_matriz_loop
	
copiar_matriz_loop:
	lb $a0 %matriz($a1)
	sb $a0 %save($a1)
	beq $a1 %size copiar_matriz_return
	addi $a1 $a1 1
	b copiar_matriz_loop
	
copiar_matriz_return:
	# FIN
.end_macro

###############################################################
# Obtener la transversal de la matriz y mostrarla por pantalla
# numero   $a0
# _i       $a1
# _j       $a2
# contador $a3
.macro matriz_transversal(%matriz, %size, %sizeI, %sizeJ)
mostrar_transversal:
	reset()
	b mostrar_transversal_loop
	
mostrar_transversal_loop:
	beq $a3 %size mostrar_transversal_return
	beq %sizeI $a1 mostrar_transversal_return
	beq %sizeJ $a2 mostrar_transversal_return
	mul $a3 $a1 %sizeI
	add $a3 $a3 $a2
	lb $a0 %matriz($a3)
	print_int($a0)
	print_str("\t")
	addi $a1 $a1 1 # baja una fila en la matriz
	addi $a2 $a2 1 # se mueve una columna hacia la derecha
	b mostrar_transversal_loop
	
mostrar_transversal_return:
.end_macro

###############################################################
# !ORDENA DE MENOR A MAYOR POR ORDENAMIENTO SELECTIVO!
# SUPER DIFICIL
# numero   $a0
# _i       $a1
# _j       $a2
# contador $a3
# menor	   $s0
# ordenados 	 $s1
# posicion_menor $s2
.macro matriz_ordenar(%matriz, %size, %sizeI, %sizeJ)
ordenar:reset()
	lb $s0 %matriz($s1)
	b ordenar_loop_i
	
ordenar_loop_i:
	beq $s1 size ordenar_return
	beq $a1 sizeI ordenar_es_menor
	jal ordenar_loop_j
	li $a2 0
	addi $a1 $a1 1
	b ordenar_loop_i
	
ordenar_loop_j:
	beq $a2 %sizeJ ordenar_loop_i_return
	lb $a0 %matriz($a3)
	bge $s0 $a0 ordenar_nuevo_menor
	addi $a2 $a2 1
	addi $a3 $a3 1
	b ordenar_loop_j
	
ordenar_loop_i_return:
	return
	
ordenar_nuevo_menor:
	move $s2 $a3 # guardar posicion del numero
	move $s0 $a0
	addi $a2 $a2 1
	addi $a3 $a3 1
	b ordenar_loop_j

ordenar_es_menor:
	lb $a0 %matriz($s1)
	sb $s0 %matriz($s1)
	sb $a0 %matriz($s2)
	addi $s1 $s1 1
	div $a1 $s1 4
	mfhi $a2
	move $a3 $s1
	addi $a3 $a3 1
	lb $s0 %matriz($s1)
	bnez $a1 ordenar_loop_i
	move $a2 $s1
	b ordenar_loop_i

ordenar_return:
	# FIN
	
.end_macro

