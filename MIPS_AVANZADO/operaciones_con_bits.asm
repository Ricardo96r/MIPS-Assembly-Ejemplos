# Ricardo Rodríguez <ricardo96r@gmail.com>
# Ejemplo de lo que se puede hacer con los numeros binarios

.include "macros.asm"
.macro bin_datos(%str)
	print_str(%str)
	print_binary($t1)
	print_str(" -> ")
	print_int($t1)
	print_str("\n")
.end_macro

.data
.text
main:	.eqv numero $t0
	li $t2 -1 # 32 unos existen por complemento 2
	.eqv unos $t2
	li $t3 31
	print_str("- Insertar un numero: ")
	read_int(numero)
	print_str("El numero en binary: ")
	print_binary(numero)
	print_str("\n")
	
	#cantidad de ceros a la izquierda
	clz $t1 numero
	print_str("Cantidad de ceros desde izquierda: ")
	print_int($t1)
	print_str("\n")
	
	# cantidad de unos a la izquierda
	clo $t1 numero
	print_str("Cantidad de unos desde la izquierda: ")
	print_int($t1)
	print_str("\n")
	
	# negacion
	neg $t1 numero # COMPLEMENTO 2!
	bin_datos("La negacion es: ")
	
	# NOT
	not $t1 numero # COMPLEMENTO 2!
	bin_datos("NOT: ")
	
	# NOR
	nor $t1 numero $zero
	bin_datos("NOR con CEROS: ")

	# OR
	or $t1 numero unos
	bin_datos("OR con CEROS: ")
	
	# Shift Left Logical.  Ignora el complemento 2
	sll $t1 numero 1 # o sllv
	bin_datos("SLL 1: ")
	
	# Shift right Logical. Ignora el complemento 2
	srl $t1 numero 1 # o sllv
	bin_datos("SRL 1: ")
	
	# Shift right arithmetic. Usa complemento 2
	sra $t1 numero 1 # o srav
	bin_datos("SRA 1: ")
	
	# Rotate left
	rol $t1 numero 1
	bin_datos("ROL 1: ")
	
	# Rotate right
	ror $t1 numero 1
	bin_datos("ROR 1: ")

exit:	exit()
