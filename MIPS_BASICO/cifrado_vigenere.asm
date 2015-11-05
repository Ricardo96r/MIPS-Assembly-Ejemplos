# Ricardo Rodríguez <ricardo96r@gmail.com>
# Cifrado de Vigenere

.data
saludo: .asciiz "\n Cifrado de Vigenere \n"
opcion: .asciiz "\n- Quiere Cifrar o Descifrar un mensaje (cifrar = 0/descifrar = 1): "
mensaje_pregunta: .asciiz "\n- Insertar el mensaje: "
mensaje: .space 1000 # maximo 1000 caracteres
clave_pregunta: .asciiz "\n- Insertar la clave: "
clave: .space 1000
mensaje_procesado: .space 1000
abecedario: .byte 26 # CANTIDAD DE LETRAS QUE EXISTEN EN EL ABECEDARIO
mostrar_mensaje: .asciiz "\nMENSAJE:"
mostrar_clave: .asciiz "CLAVE:       "
mostrar_procesado: .asciiz "RESPUESTA:"
tabulador: .asciiz "\t"

.text
main:	
	li $t0 0 # 0 = CIFRAR // 1 = DESCIFRAR
	li $t1 0 # MENSAJE
	li $t2 0 # CLAVE
	li $t3 0 # CONTADOR DE BYTES DE MENSAJE
	li $t4 0 # CONTADOR DE BYTES DE CLAVE
	li $t5 10 # ASCII(NEW LINE) por CULPA de syscall 8. Se usa como parada de un BRANCH
	jal preguntar_opcion
	jal preguntar_mensaje
	jal preguntar_clave
	b menu
	
preguntar_opcion:
	li $v0 4
	la $a0 saludo
	syscall
	la $a0 opcion
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # 0 = CIFRAR, 1 = DESCIFRAR
	jr $ra
	
preguntar_mensaje:
	li $v0 4
	la $a0 mensaje_pregunta
	syscall
	li $v0 8
	la $a0 mensaje
	li $a1 1000
	syscall
	move $t1 $a0 # mensaje insertado guardado
	jr $ra
	
preguntar_clave:
	li $v0 4
	la $a0 clave_pregunta
	syscall
	li $v0 8
	la $a0 clave
	li $a1 1000
	syscall
	move $t2 $a0 # mensaje insertado guardado
	jr $ra

menu:	beqz $t0 cifrar
	b descifrar
	
cifrar:	lb $t1 mensaje($t3)
	lb $t2 clave($t4)
	beq $t2 $t5 clave_reiniciar_cifrar
	b cifrar_loop

cifrar_loop:
	beq $t1 $t5 mostrar
	subi $t1 $t1 97
	subi $t2 $t2 97
	add $t1 $t1 $t2
	lb $t2 abecedario
	div $t1 $t1 $t2
	mfhi $t1
	addi $t1 $t1 97
	jal guardar_en_mensaje_procesado
	addi $t3 $t3 1
	addi $t4 $t4 1
	b cifrar
	
# La clave es mas pequeña que el mensaje, por lo tanto se comienza de 0 otra vez
clave_reiniciar_cifrar:
	li $t4 0
	lb $t2 clave($t4)
	b cifrar_loop
	
descifrar:
	lb $t1 mensaje($t3)
	lb $t2 clave($t4)
	beq $t2 $t5 clave_reiniciar_descifrar
	bge $t1 $t2 descifrar_2
	b descifrar_1

# Si $t1 < $t2
descifrar_1:
	beq $t1 $t5 mostrar
	subi $t1 $t1 97
	subi $t2 $t2 97
	sub $t1 $t1 $t2
	lb $t2 abecedario
	add $t1 $t1 $t2
	addi $t1 $t1 97
	jal guardar_en_mensaje_procesado
	addi $t3 $t3 1
	addi $t4 $t4 1
	b descifrar

# Si $t1 >= $t2
descifrar_2:
	beq $t1 $t5 mostrar
	subi $t1 $t1 97
	subi $t2 $t2 97
	sub $t1 $t1 $t2
	lb $t2 abecedario
	div $t1 $t1 $t2
	mfhi $t1
	addi $t1 $t1 97
	jal guardar_en_mensaje_procesado
	addi $t3 $t3 1
	addi $t4 $t4 1
	b descifrar
	
# Guarda en el vector mensaje_procesado el valor de $t1 
# Usa $t3 como la posicion del byte ACTUAL
guardar_en_mensaje_procesado:
	sb $t1 mensaje_procesado($t3)
	jr $ra

# La clave es mas pequeña que el mensaje, por lo tanto se comienza de 0 otra vez
clave_reiniciar_descifrar:
	li $t4 0
	b descifrar
	
mostrar:
	li $v0 4
	la $a0 mostrar_mensaje
	syscall
	la $a0 tabulador
	syscall
	la $a0 mensaje
	syscall
	la $a0 mostrar_clave
	syscall
	la $a0 tabulador
	syscall
	la $a0 clave
	syscall
	la $a0 mostrar_procesado
	syscall
	la $a0 tabulador
	syscall
	la $a0 mensaje_procesado
	syscall
	b exit

exit:	li $v0 10
	syscall
