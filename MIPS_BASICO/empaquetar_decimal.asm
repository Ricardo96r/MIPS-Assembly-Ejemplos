# Ricardo Rodríguez <ricardo96r@gmail.com>
# Empaquetar un numero

.data
saludo: .asciiz "\n Insertar numero: "
positivo: .byte 0x0C # 1100
negativo: .byte 0x0D # 1101

.text
.globl main
main:	li $t0 -1 # parada
	sb $t0 ($sp)
	li $v0 4
	la $a0 saludo
	syscall
	li $v0 5
	syscall
	move $t0 $v0 # Numero
	li $t2 0 # signo
	
if_neg:	li $t1 1
	sll $t1 $t1 31
	and $t1 $t0 $t1
	beqz $t1 loop
	neg $t0 $t0 # combierte a positivo con complemento 2
	li $t2 1 # negativo
	
loop:	beqz $t0 empaquetar
	div $t0 $t0 10
	mfhi $t1
	subi $sp $sp 1
	sb $t1 ($sp)
	b loop
	
empaquetar:
	lb $t1 ($sp)
	beq $t1 -1 if_signo
	or $t0 $t0 $t1
	sll $t0 $t0 4
	addi $sp $sp 1
	b empaquetar
	
if_signo:
	beqz $t2 else_signo
	lb $t1 negativo # 1101 (-)
	or $t0 $t0 $t1
	b mostrar

else_signo:
	lb $t1 positivo # 1100  (+)
	or $t0 $t0 $t1
	
mostrar:li $v0 34
	move $a0 $t0
	syscall

exit:	li $v0 10
	syscall
