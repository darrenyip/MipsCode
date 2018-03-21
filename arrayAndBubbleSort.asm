.data
hey: .asciiz  "\n\nEnter size of array: "  # Prompt asking for user input
enterNnumber: .asciiz "Please enter the number: "
print: .asciiz "\nthe sorted array: "
space: .asciiz " "

.text
main:
	####### Print : Enter size of array ###########
	li $v0, 4
	la $a0, hey
	syscall
	addi $v0, $0, 5
	syscall
	add $t2, $zero, $v0
	#############
	############ get input from user
	
	#############
	add $t1, $zero, $sp
	add $t0, $zero, $zero  #increment t0, uppper bound is t2 which is the size of the array
	jal input
	########################################
	
	add $t1, $0, $sp
	add $t6, $0, $sp
	move $t0, $0
   	jal bubble
   	
   	###################
	li $v0, 4
	la $a0, print
	syscall
   	add $t1, $0, $t6
   	add $t0, $0, $0
   	jal printArray
   	
   	
   	
    	j exit
    	
input:
	li $v0, 4
	la $a0, enterNnumber
	syscall 

	addi $v0, $0, 5
	syscall
	sw $v0, 0($t1)
	add $t1, $t1, 4
	
	add $t0, $t0, 1
	blt $t0, $t2, input
	jr $ra
	
bubble:
	add $s0, $0, $0
	
	outter:
		beq $s0, $t2, jrra   # if s1 = s7 return to the main func   for( i< n-1  )
		
		sub $t7, $t2, $s0      #t7 = inner loop n-i
		addi $t7, $t7, -1      #t7 = inner loop j   = n - i- 1
		
		add $s1, $0, $0		#increment for inner loop  j
		
		inner:
			beq $s1, $t7, cont
			
			#######load array i and array i+1
			mul $s3, $s1, 4
			add $t1, $t6, $s3
			lw $t3, ($t1)
				addi $t1, $t1, 4
			lw $t4, ($t1)
			##########  If (Array[i]) > ascii(Array[i+1])  swap ##########
			sgt $s2, $t3, $t4
			######else store
			beq $s2, $zero, cool
			sw $t3, ($t1)
				addi $t1, $t1, -4
			sw $t4, ($t1)
			
			cool:
				addi $s1, $s1, 1
				j inner
			
		cont:
			addi $s0, $s0, 1
			j outter

printArray:
	
	lw $t4, 0($t1)
	add $t1, $t1, 4
	
	
	add $a0, $t4, $0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	add $t0, $t0,1
	blt $t0, $t2, printArray
	jr $ra
	
	
jrra:
	jr $ra
	
exit:
	li $v0, 10
	syscall	
