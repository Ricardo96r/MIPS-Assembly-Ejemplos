# Ricardo Rodríguez <ricardo96r@gmail.com>
# Contar Bits Apagados
.include "macros.asm"
.data

.text
.globl main
main:	.eqv numero $t0
	.eqv contador $t1
	.eqv leftLogical $t2
	.eqv apagados $t3
	print_str("- Insertar un numero: ")
	read_int(numero)
	b loop
	
loop:	beq contador 32 mostrar
	li leftLogical 1
	sllv leftLogical leftLogical contador
	xori leftLogical leftLogical -1
	nor leftLogical numero leftLogical
	addi contador contador 1
	bnez leftLogical apagado
	b loop
	
apagado:
	addi apagados apagados 1
	li leftLogical 0
	b loop

mostrar:
	print_binary(numero)
	print_str("\n")
	print_str("La cantidad de bits apagados en el numero son: ")
	print_int(apagados)
	b exit
	
exit:	exit()