.include "macros.asm"
# Ricardo Rodríguez <ricardo96r@gmail.com>
# Desempaquetar un numero

.data
saludo:	.asciiz "Insertar numero: "
unos_4_bits: .word 0x0F # nibble 1111

.text
.globl main
main:	li $t0 -1
	sb $t0 ($sp) # parada
	li $v0 4
	la $a0 saludo
	syscall
	li $v0 5
	syscall
	move $t0 $v0
	
if_neg:	li $t1 1
	sll $t1 $t1 31
	and $t1 $t0 $t1
	beqz $t1 loop
	neg $t0 $t0 # combierte a positivo con complemento 2
	li $t2 1 # negativo
	
loop:	beqz $t0 desempaquetar
	div $t0 $t0 10
	mfhi $t1
	subi $sp $sp 1
	sb $t1 ($sp)
	b loop
	
desempaquetar:
	lb $t3 ($sp)
	beq $t3 -1 if_signo
	lbu $t1 unos_4_bits
	sll $t1 $t1 4 # 1111 0000
	sll $t0 $t0 8
	or $t1 $t1 $t3
	or $t0 $t0 $t1
	addi $sp $sp 1
	b desempaquetar

if_signo:
	beqz $t2 else_signo
	andi $t0 $t0 0xFFFFFFDF
	b mostrar

else_signo:
	andi $t0 $t0 0xFFFFFFCF

mostrar:print_hex($t0)
	print_str("\n")
	
exit:	li $v0 10
	syscall