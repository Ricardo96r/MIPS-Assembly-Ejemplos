# Ricardo Rodríguez <ricardo96r@gmail.com>
# MACROS BASICOS UTILES

.eqv return jr $ra

.macro print_str(%str)
	.data
string: .asciiz %str # AL USARLO SE CAMBIA A string_M1...string_M99999
	.text
	li $v0 4
	la $a0 string
	syscall
.end_macro

.macro print_char(%char)
	li $v0 11
	add $a0 $zero %char
	syscall
.end_macro

.macro print_int(%int)
	li $v0 1
	add $a0 $zero %int
	syscall
.end_macro

.macro print_binary(%int)
	li $v0 35
	add $a0 $zero %int
	syscall
.end_macro

.macro print_hex(%int)
	li $v0 34
	add $a0 $zero %int
	syscall
.end_macro

.macro read_int(%save)
	li $v0 5
	syscall
	move %save $v0
.end_macro

.macro read_str(%vector, %size)
	li $v0 8
	la $a0 %vector
	li $a1 %size
	syscall
.end_macro

.macro read_char(%save)
	li $v0 12
	syscall
	move %save $v0
.end_macro

.macro suma(%save, %x1)
	add $v0 $v0 %x1
	move %save $v0
.end_macro 

.macro suma(%save, %x1, %x2)
	add $v0 $zero %x1
	add $v0 $v0 %x2
	move %save $v0
.end_macro 

.macro suma(%save, %x1, %x2, %x3)
	add $v0 $zero %x1
	add $v0 $v0 %x2
	add $v0 $v0 %x3
	move %save $v0
.end_macro 

.macro exit()
	li $v0 10
	syscall
.end_macro

.macro exit (%termination_value)
	li $a0, %termination_value
	li $v0, 17
	syscall
.end_macro

.macro for (%regIterator, %from, %to, %bodyMacroName)
	add %regIterator, $zero, %from
	Loop:
	%bodyMacroName ()
	add %regIterator, %regIterator, 1
	ble %regIterator, %to, Loop
.end_macro