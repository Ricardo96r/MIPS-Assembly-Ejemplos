# Ricardo Rodríguez <ricardo96r@gmail.com>
# Uso de la libreria de macros llamada: macros_matriz
.include "macros.asm"
.include "macros_matriz.asm"

.eqv sizeI $t0
.eqv sizeJ $t1
.eqv size $t2

.data
matriz: .byte 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 20, 0, 4, 5, 6, 1 # Suponemos matriz 4x4
sizeMatriz_i: .byte 4 # FILAS
sizeMatriz_j: .byte 4 # COLUMNAS
copy_matriz: .space 15

.text
.globl main
main:	lb sizeI sizeMatriz_i
	lb sizeJ sizeMatriz_j
	# Tamaño de la matriz -1
	size_matriz(size, sizeI, sizeJ)
	
	# Mostrar la matriz original
	print_str("\n La matriz original es: \n")
	mostrar(matriz, sizeI, sizeJ)
	
	# Mostrar la transversal de la matriz original
	print_str("\n La transversal de la matriz original es: \n")
	matriz_transversal(matriz, size, sizeI, sizeJ)
	
	# Copia la matriz en otra matriz
	copiar_matriz(copy_matriz, matriz, size)
	print_str("\n \n La matriz original copiada es: \n")
	mostrar(copy_matriz, sizeI, sizeJ)
	
	# Ordena la matriz de menor a mayor de izquierda derecha arriba abajo. SUPER DIFICIL
	matriz_ordenar(copy_matriz, size, sizeI, sizeJ)
	print_str("\n La matriz original copiada ordenada es: \n")
	mostrar(copy_matriz, sizeI, sizeJ)

exit:	exit()
