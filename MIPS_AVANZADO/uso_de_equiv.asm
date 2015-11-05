# Ricardo Rodríguez <ricardo96r@gmail.com>
# Ejemplo del uso de equivalence

.include "macros.asm"
.data

.text
.globl main
main:	.eqv var $t0
	.eqv foo $t1
	.macro telt()
	# .eqv foo $t3 ILEGAL =(
	.end_macro
	.eqv foo2 $t2
	.eqv CLEAR_VAR addi var $zero 0
	CLEAR_VAR
	li foo 10
	li foo2 30
	suma(var, foo, foo2)
	print_int(var)
	print_str(" ")
	.eqv foo3 $t0 # FUNCIONA!
	suma(foo3, foo, foo2)
	print_int(var)
	exit()
