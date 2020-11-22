#Name: Joel Tanig

.data
extraspace: .asciiz " "
array: .word 1:5
prompt: .asciiz "Enter a number you silly goose "
result: .asciiz "You entered this: "
ihatemyself: .asciiz "\nThe largest which is: "

.text
	la $s0, array #load $s0 to the address of an array
	addi $s3, $s0, 0 #Make a dummy array to manipulate values in it
	addi $s1, $0, 0 #Make i = 0
	addi $t2, $0, 5 #This will be a stopping point
	addi $s6, $s0, 0 #Make a third dummy array for later for the max

loop:
	#Loop checker
	slt $t0,$s1,$t2 #checks if s1 >= 5
	beq $t0, $0, aldone # if it is STOP
	
	#Print the prompt
	li $v0, 4	#Call a service number of 4 to print the string
	la $a0, prompt	#Load address of prompt
	syscall
	
	#Read the int the loser put 
	li $v0, 5 #The Service number for reading an int
	syscall
	
	
	# Do stuff with arrays here
	sw $v0,($s3) #Take the var and save it TO THE ARRAY
	addi $s1, $s1, 1 #Add to the loop counter 
	addi $s3, $s3, 4 #Arrays are indexed by 4.
	
	j loop  #Keep looping until this is done 5 times
	

	
aldone: 
	addi $s3, $s0, 0 #Reset the dummy array.
	li $v0, 4 # print the result string 
	addi $s1, $0, 0 #Make i = 0, I am resetting the counters
	addi $t2, $0, 5 #This will be a stopping point, I am resetting the counters 
	la $a0, result #"You entered this"
	syscall
	j while
	
while: # Print out the saved array 
	slt $t0,$s1,$t2 #checks if s1 >= 5
	beq $t0, $0, transition # if it is STOP
	
	lw $t5, ($s3) #Store this array[i] into a temp var
	move $a0, $t5 #An array is an address
	li $v0, 1 #Make a call to the system to print a string 
	syscall #Wait for user input 
	la $a0, extraspace #Load address of prompt
	li $v0, 4 #Tell the janitor to load the string command 
	syscall	
	
	
	
	
	addi $s1, $s1, 1 #Increment the counter for our loop 
	addi $s3, $s3, 4 #Arrays are indexed by 4
	j while
	 

transition: 
	addi  $s2, $s6, 0 #Set the dummy array for the max array
	addi  $s5, $s6, 0 #Set the second dummy array to look ahead 
	addi  $t2, $0, 4 #This will be a stopping point -1 in length like a java array !!!! :)
	addi  $s1, $0, 0 #Reset whatever was in $s1!!!!! 
	j findMax
	


findMax:
	#loop counter
	slt $t0,$s1,$t2 #if s1 > t2, it return 1, else 0
	beq $t0, $0,final #When there is nothing left in the array go to the final piece of code
	addi $s5, $s5, 4 #Arrays are indexed by 4, this is the index(s2) !!!!
	lw $t3,($s2) #Go to the array and grab the value at that index  and set to temp
	lw $t4,($s5) #Go to the array and grab the value at that index  and set to temp
	slt $t5,$t4,$t3 #if s2 < s5 it return 1, else 0
	
	beq $t5, $0, findMaxHelper  # 1 beq if its greater 
	##lw $t5, ($s3) #Store this array[i] into a temp var
	addi $s1,$s1, 1 #Loop through findmax
	j findMax
	
		
			
findMaxHelper:
	add $s2, $0, $s5 #Overwrite the master max var/array with the value we know that is greater than it 
	addi $s1, $s1, 1 #Add to the loop counter
	j findMax #Jumps back to the findMax function for the rest of the arrayy
	
	

final:
	
	li $v0, 4 #Print the space
	la $a0, extraspace
	syscall	
	
	li $v0, 4 #Print the final prompt of the of "The largest which is "
	la $a0, ihatemyself
	syscall
	
	li $v0, 1 #Print the largest thing we have 
	lw $t3,($s2) # Go to the array and grab the value at that index  and set to temp
	move $a0, $t3 #Swtich to an address line
	syscall
	
	li $v0, 10 #Calls the program to stop with code 10 
	syscall
