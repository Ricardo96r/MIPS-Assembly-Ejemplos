# Ricardo Rodríguez <ricardo96r@gmail.com>
# Empaqueta 2 numeros hexadecimales en un word

.include "macros.asm"
.data

.text
main:	li $t0 0x000F
	li $t1 0x0003
	sll $t0 $t0 4 # 4 bits hacia la derecha
	or $t0 $t0 $t1 # empaquetado
	print_binary($t0)
	print_str("\n")
	print_hex($t0) # IMPRIME F3. FUNCIONA

exit:	exit()
