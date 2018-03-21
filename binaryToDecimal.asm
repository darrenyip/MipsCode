li $v0, 5   #get user input
syscall
move $t0, $v0

li $t1, 2147483648   # mask 1000.....000000
li $t2, 31 # counter for all 16 digits binary numbers
li $t4, 1  #just an integer nummber 1

Loop:
  and $t3, $t1, $t0 # save the number into t3
  beq $t3, $zero, print  #if t3 == zero print 0
  
  addi $a0, $t4, 0  # else print number 1
  li $v0, 1
  syscall

  srl $t1, $t1,1  #shift right 1
  sub $t2, $t2, 1 #counter -1
  j Loop

print:

sub $t2, $t2, 1 #counter -1
blt $t2, -1, exit	# if counter is less than 01 then exit the program
srl $t1, $t1,1  #shift left 1

li $v0, 4	#print number 0 
la $a0, print0
syscall
j Loop



exit: 

li $v0, 10
syscall

.data
print1: .ascii "1"
print0: .ascii "0"
