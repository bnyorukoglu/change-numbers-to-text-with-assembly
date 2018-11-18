.data  
buffer:     .space 1024
ibuffer:    .space 80 
fbuffer:    .space 80
newContent: .space 256
request:    .asciiz "Enter file name: "
forZero:    .asciiz "zero"
forOne:	    .asciiz "one"
forTwo:     .asciiz "two"
forThree:   .asciiz "three"
forFour:    .asciiz "four"
forFive:    .asciiz "five"
forSix:	    .asciiz "six"
forSeven:   .asciiz "seven"
forEight:   .asciiz "eight"
forNine:    .asciiz "nine"
.text
	#prompt for and get file name
 	li	$v0,4
        la	$a0,request
 	syscall 
 	li	$v0,8 
 	la	$a0,ibuffer 
 	li	$a1,80 
 	syscall
 	
 	la $a1, fbuffer
 	li $t0, 0
 	li $t1, 0
 	li $t2, 46 #nokta
 	removeSpace:
 		lb $t3, 0($a0)
 		beq $t3, $t2, ifremove
 			sb $t3, 0($a1)
 			addi $a0, $a0, 1
 			addi $a1, $a1, 1
 		j doneremove
 		ifremove:
 			sb $t3, 0($a1)
 
 			addi $a0, $a0, 1
 			addi $a1, $a1, 1
 			lb $t3, 0($a0)
 			sb $t3, 0($a1)
 
  			addi $a0, $a0, 1
 			addi $a1, $a1, 1
 			lb $t3, 0($a0)
 			sb $t3, 0($a1)
 
  			addi $a0, $a0, 1
 			addi $a1, $a1, 1
 			lb $t3, 0($a0)
 			sb $t3, 0($a1)
 			
 			j finish
 		doneremove:
 	j removeSpace
 	finish:

	# Open file for reading
	li   $v0, 13          			
	la   $a0, fbuffer      			# input file name
	li   $a1, 0           			# flag for reading
	li   $a2, 0           			# mode is ignored
	syscall               			# open a file 
	move $s0, $v0         			

	# reading from file just opened
	li   $v0, 14        			# system call for reading from file
	move $a0, $s0       			# file descriptor 
	la   $a1, buffer    			# address of buffer from which to read
	li   $a2,  256       			
	syscall             			

	#Operation on array section
	la $t0, buffer  			# Load the array
	la $a3,newContent 			#Load the newContent first address
	li $t1, 0         			# Create the loop counter
	li $v0, 11        			# Syscall code for print character       
	add $t2, $t0, $t1    			# Load the address for the element at the current index 
	li $t3, 32				# boþluk karakteri ascii deðeri
	li $t7, 46				# nokta ascii deðeri 
	li $t5, 1				# boþluk kontrolünden sonra çýkarma için kullanýlacak
	add $t8, $t0, $t1 
	readArrayloop:  		
        lb $a0, 0($t2)       			
        
        # 0 kontrolü 
        li $t1, 48
        beq $a0, $t1, ifZero
		# 1 kontrolü 
		li $t1, 49
		beq $a0, $t1, ifOne
			# 2 kontrolü
			li $t1, 50
			beq $a0, $t1, ifTwo
				# 3 kontrolü 
				li $t1, 51
				beq $a0, $t1, ifThree
					# 4 kontrolü
					li $t1, 52
					beq $a0, $t1, ifFour
						# 5 kontrolü
						li $t1, 53
						beq $a0, $t1, ifFive
							# 6 kontrolü
							li $t1, 54
							beq $a0, $t1, ifSix
								# 7 kontrolü
								li $t1, 55
								beq $a0, $t1, ifSeven
									# 8 kontrolü
									li $t1, 56
									beq $a0, $t1, ifEight
										# 9 kontrolü
										li $t1, 57
										beq $a0, $t1, ifNine				
        										sb $a0,0($a3)
        										beq $a0, $zero,exitLoop 	
        										addi $t2, $t2, 1     		
      											addi $a3, $a3, 1
      										j doneNine
      										ifNine:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace9
      										 	
      										 		beq $a0, $t7, checkDot9
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot9
      										 		checkDot9:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c9
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d9
      													c9:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forNine
														jal convert_number
      													d9:
      										 		doneDot9:
      										 	j doneSpace9
      										 	frontSpace9:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace9	
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first9
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst9
      										 			first9:
														la $a0, forNine
														jal convert_number		 			
      										 			donefirst9:
      										 			

      										 		j doneBackSpace9
      										 		backSpace9:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forNine
													jal convert_number	 		
      										 		doneBackSpace9:
      										 	doneSpace9:																														
      										doneNine:
      									j doneEight
      									ifEight:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace8
      										 	
      										 		beq $a0, $t7, checkDot8
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot8
      										 		checkDot8:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c8
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d8
      													c8:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forEight
														jal convert_number
      													d8:
      										 		doneDot8:
      										 	j doneSpace8
      										 	frontSpace8:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace8
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first8
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst8
      										 			first8:
														la $a0, forEight
														jal convert_number		 			
      										 			donefirst8:
      										 		j doneBackSpace8
      										 		backSpace8:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forEight
													jal convert_number	 		
      										 		doneBackSpace8:
      										 	doneSpace8:	  	
      									doneEight:
      								j doneSeven
      								ifSeven:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace7
      										 	
      										 		beq $a0, $t7, checkDot7
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot7
      										 		checkDot7:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c7
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d7
      													c7:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forSeven
														jal convert_number
      													d7:
      										 		doneDot7:
      										 	j doneSpace7
      										 	frontSpace7:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace7	
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first7
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst7
      										 			first7:
														la $a0, forSeven
														jal convert_number		 			
      										 			donefirst7:
      										 		j doneBackSpace7
      										 		backSpace7:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forSeven
													jal convert_number	 		
      										 		doneBackSpace7:
      										 	doneSpace7:
      								doneSeven:
      							j doneSix
      							ifSix:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace6
      										 	
      										 		beq $a0, $t7, checkDot6
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot6
      										 		checkDot6:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c6
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d6
      													c6:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forSix
														jal convert_number
      													d6:
      										 		doneDot6:
      										 	j doneSpace6
      										 	frontSpace6:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace6	
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first6
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst6
      										 			first6:
														la $a0, forSix
														jal convert_number		 			
      										 			donefirst6:
      										 		j doneBackSpace6
      										 		backSpace6:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forSix
													jal convert_number	 		
      										 		doneBackSpace6:
      										 	doneSpace6:
      							doneSix:
      						j doneFive
      						ifFive:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace5
      										 	
      										 		beq $a0, $t7, checkDot5
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot5
      										 		checkDot5:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c5
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d5
      													c5:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forFive
														jal convert_number
      													d5:
      										 		doneDot5:
      										 	j doneSpace5
      										 	frontSpace5:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace5	
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst5
      										 			first5:
														la $a0, forFive
														jal convert_number		 			
      										 			donefirst5:
      										 		j doneBackSpace5
      										 		backSpace5:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forFive
													jal convert_number	 		
      										 		doneBackSpace5:
      										 	doneSpace5:
      						doneFive:
      					j doneFour
      					ifFour:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace4
      										 	
      										 		beq $a0, $t7, checkDot4
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot4
      										 		checkDot4:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c4
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d4
      													c4:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forFour
														jal convert_number
      													d4:
      										 		doneDot4:
      										 	j doneSpace4
      										 	frontSpace4:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace4	
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first4
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst4
      										 			first4:
														la $a0, forFour
														jal convert_number		 			
      										 			donefirst4:
      										 		j doneBackSpace4
      										 		backSpace4:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forFour
													jal convert_number	 		
      										 		doneBackSpace4:
      										 	doneSpace4:
      					doneFour:
      				j doneThree
      				ifThree:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace3
      										 	
      										 		beq $a0, $t7, checkDot3
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot3
      										 		checkDot3:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c3
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d3
      													c3:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forThree
														jal convert_number
      													d3:
      										 		doneDot3:
      										 	j doneSpace3
      										 	frontSpace3:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace3	
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first3
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst3
      										 			first3:
														la $a0, forThree
														jal convert_number		 			
      										 			donefirst3:
      										 		j doneBackSpace3
      										 		backSpace3:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forThree
													jal convert_number	 		
      										 		doneBackSpace3:
      										 	doneSpace3:
      				doneThree:
      			j doneTwo
      			ifTwo:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace2
      										 	
      										 		beq $a0, $t7, checkDot2
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot2
      										 		checkDot2:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c2
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d2
      													c2:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forTwo
														jal convert_number
      													d2:
      										 		doneDot2:
      										 	j doneSpace2
      										 	frontSpace2:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace2	
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first2
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst2
      										 			first2:
														la $a0, forTwo
														jal convert_number		 			
      										 			donefirst2:
      										 		j doneBackSpace2
      										 		backSpace2:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forTwo
													jal convert_number	 		
      										 		doneBackSpace2:
      										 	doneSpace2:
      			doneTwo:   		
		j doneOne
		ifOne:
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace1
      										 	
      										 		beq $a0, $t7, checkDot1
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot1
      										 		checkDot1:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c1
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d1
      													c1:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forOne
														jal convert_number
      													d1:
      										 		doneDot1:
      										 	j doneSpace1
      										 	frontSpace1:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace1
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first1
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst1
      										 			first1:
														la $a0, forOne
														jal convert_number		 			
      										 			donefirst1:
      										 		j doneBackSpace1
      										 		backSpace1:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forOne
													jal convert_number	 		
      										 		doneBackSpace1:
      										 	doneSpace1:	
		doneOne:
	j doneZero
	ifZero : 
        										addi $t2, $t2, 1     		
      											lb $a0, 0($t2)
      										 	beq $a0, $t3, frontSpace0
      										 	
      										 		beq $a0, $t7, checkDot0
      										 			sub $t2, $t2, $t5
      										 			lb $a0, 0($t2)
      										 			sb $a0, 0($a3)
      										 			addi $t2, $t2, 1  
      										 			addi $a3, $a3, 1
      										 		j doneDot0
      										 		checkDot0:
        												addi $t2, $t2, 1     		
      													lb $a0, 0($t2)	
      													
      													beq $a0, $t3, c0
      														sub $t2, $t2, $t5
      										 				sub $t2, $t2, $t5
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1  
      										 				addi $a3, $a3, 1			
      													j d0
      													c0:
      														sub $t2, $t2, 1
      										 				sub $t2, $t2, 1
      										 				lb $a0, 0($t2)																															
														la $a0, forZero
														jal convert_number
      													d0:
      										 		doneDot0:
      										 	j doneSpace0
      										 	frontSpace0:
      										 		sub $t2, $t2, $t5
      										 		sub $t2, $t2, $t5
      										 		lb $a0, 0($t2)	
      										 		beq $a0, $t3, backSpace0	
      										 			addi $t2, $t2, 1
      										 			beq $t2, $t8, first0
      										 				lb $a0, 0($t2)
      										 				sb $a0, 0($a3)
      										 				addi $t2, $t2, 1 
      										 				addi $a3, $a3, 1								 			
      										 			j donefirst0
      										 			first0:
														la $a0, forZero
														jal convert_number		 			
      										 			donefirst0:
      										 		j doneBackSpace0
      										 		backSpace0:
      										 			addi $t2, $t2, 1
      										 			lb $a0, 0($t2)																															
													la $a0, forZero
													jal convert_number	 		
      										 		doneBackSpace0:
      										 	doneSpace0:
	doneZero:
        
        j readArrayloop                # Jump to the beginning of the loop    
        ############### convert number function ##########################
 	convert_number:
		numberArray:
			lb $a1, 0($a0) 
			sb $a1, 0($a3)
			beq $a1, $zero, exit
			
			addi $a0, $a0, 1 
			addi $a3, $a3, 1
			j numberArray
		exit:
			addi $t2, $t2, 1   
		jr $ra      
 	####################################################################
	exitLoop: 				# Should be reached once you have hit the end of the string

	#####################convert upper case#############################
	la $a0, newContent
	li $t0, 0
	li $t1, 46 #nokta 
	li $t2, 0
	li $t4, 96
	loopUpperCase:
	lb $a1, 0($a0)
		beq $a1, $t1 if
			beq $a1, $zero, exitUpperCase
			addi $a0, $a0, 1
		j done
		if:
			addi $a0, $a0, 1
			lb $a1, 0($a0)
			beq $a1, $zero, exitUpperCase
			addi $a0, $a0, 1
			lb $a1, 0($a0)
			beq $a1, $zero, exitUpperCase
	
				slt $t3, $a1, $t4
				beq $t3, $t2 , ifCase
				addi $a0, $a0, 1
			j doneCase
			ifCase:
				sub, $a1, $a1, 32
				sb $a1, 0($a0)
				addi $a0, $a0, 1
			doneCase:
		done:
		
	j loopUpperCase
	exitUpperCase:

	li $v0,4
	la $a0, newContent          		# address of the first element
	syscall                       		# issue a system call	
    	
	li $v0, 10      			# Finish the Program
	syscall
