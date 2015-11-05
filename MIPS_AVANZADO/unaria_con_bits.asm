# Ricardo Rodríguez <ricardo96r@gmail.com>
# Mostrar un numero en forma unaria mediante syscall 35

.include "macros.asm"
.data
vector: .space 10 # 10 bytes

.text
.globl main
.eqv numero $t0
.eqv resto $t1
.eqv digitos $t2
.eqv word $t3

main:	print_str("Insertar el numero: ")
	read_int(numero)

separar_digitos:
	beqz numero obtener_num_vector
	div numero numero 10
	mfhi resto
	sb resto vector(digitos)
	addi digitos digitos 1
	b separar_digitos

obtener_num_vector:
	beqz digitos mostrar
	subi digitos digitos 1
	lb numero vector(digitos)
	jal unaria
	bnez digitos unaria_separador
	b obtener_num_vector
	
unaria:	sll word word 1
	addi word word 1
	subi numero numero 1
	bnez numero unaria
	jr $ra
	
unaria_separador:
	sll word word 1
	b obtener_num_vector
	
mostrar:print_binary(word)

exit: exit()
