# Ricardo Rodríguez <ricardo96r@gmail.com>
# Ejemplo del uso de macros

.include "macros.asm"
.data

.text
main:	.macro body()
		print_int($t0)
		print_str("\n")
	.end_macro
	for($t0, 1, 10, body)
	exit()