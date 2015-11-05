# Ricardo Rodríguez <ricardo96r@gmail.com>
# Contar Bits Prendidos
.include "macros.asm"
.data

.text
.globl main
main:	.eqv numero $t0
	.eqv contador $t1
	.eqv leftLogical $t2
	.eqv prendidos $t3
	print_str("- Insertar un numero: ")
	read_int(numero)
	b loop
	
loop:	beq contador 32 mostrar
	li leftLogical 1
	sllv leftLogical leftLogical contador
	and leftLogical numero leftLogical
	addi contador contador 1
	bnez leftLogical prendido
	b loop
	
prendido:
	addi prendidos prendidos 1
	li leftLogical 0
	b loop

mostrar:
	print_binary(numero)
	print_str("\n")
	print_str("La cantidad de bits prendidos en el numero son: ")
	print_int(prendidos)
	b exit
	
exit:	exit()
