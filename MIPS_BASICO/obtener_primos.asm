# Ricardo Rodríguez <ricardo96r@gmail.com>
# Obtener los numeros primos

.data
saludo1: .asciiz "\n Programa que te saca los numeros primos"
saludo2: .asciiz "\n ¿Cuatos numeros primos quieres obtener?: "
espacio: .asciiz " "

.text
main:	la $a0 saludo1
	li $v0 4
	syscall
	la $a0 saludo2
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # $t0 = la cantidad de primos pedidos
	li $t1 0 # $t1 = veces que se han mostrado los primos
	li $t2 2 # $t2 = numero actual del primo
	li $t3 2 # $t3 = numero actual que divide al $t2 para saber si es primo
	
loop:	beq $t0 $t1 exit # Fin del loop, ya que se han mostrado los numeros primos
	beq $t2 $t3 es_primo # $t2 == $t3, el numero de $t2 es primo!
	li $t5 2
	div $t2 $t5 # Dividir entre 2 al numero primo actual
	mfhi $t4
	beq $t4 0 no_primo # Es par el numero
	div $t2 $t3 # Dividir el numero actual con $t3
	mfhi $t4
	beq $t4 0 no_primo # El numero no es primo
	bne $t2 $t3 sum_t3
	b es_primo

sum_t3: addi $t3 $t3+2
	b loop
	
no_primo:
	addi $t2 $t2+1
	li $t3 3
	b loop
	
es_primo:
	move $a0 $t2
	li $v0 1
	syscall
	addi $t1 $t1+1
	li $v0 4
	la $a0 espacio
	syscall
	b no_primo
	
exit:	li $v0 10
	syscall
