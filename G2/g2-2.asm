main:
  # initialize stack pointer
  ori $sp, $sp, 0xFFFC

  # call longest_path(10)
  addi $a0, $zero, 10
  jal longest_path
  add $s0, $zero, $v0         # store result in $s0

  # call longest_path(50)
  addi $a0, $zero, 50
  jal longest_path
  add $s1, $zero, $v0         # store result in $s1

  j done

longest_path:
	addi $t0, $zero, 1    # n is initialized
	add $t1, $a0, $zero   # limit is initialized
	add $t2, $zero, $zero # max-length initialized
	sub $sp, $sp, 4       # Make room for the return address
	sw $ra, 0($sp)        # Save the return address
	long_loop:
	   addi $a0, $t0, 0 # Store n as an argument
		sub $sp, $sp, 12 # make room for four elements on the stack
		sw $t2, 8($sp)   # Save max-length
		sw $t1, 4($sp)   # Save limit
		sw $t0, 0($sp)   # Save n
		
		jal collatz
		
		lw $t2, 8($sp)    # Load max-length
		lw $t1, 4($sp)    # Load limit
		lw $t0, 0($sp)    # Load n
		addi $sp, $sp, 12 # Pop the stack

		slt $t3, $t2, $v0      # $t3 = 1 if max-length < length
		bne $t3, 1, long_endif
		add $t2, $v0, $zero    # max-length = length
		
		long_endif:
		addi $t0, $t0, 1  # n++
		slt $t4, $t0, $t1 # $t4 = 1 if n < limit
		bne $t4, $zero, long_loop
		
	lw $ra, 0($sp)   # Load the return address
	addi $sp, $sp, 4 # Pop the stack
	addi $v0, $t2, 0 # Store the result
	jr $ra

collatz:
	add $v0, $zero, $zero # set the result to 0
	
	coll_if:
		bne $a0, 1, coll_elif
		j coll_done
		
	coll_elif:
		andi $t1, $a0, 1 # $t1 = 0 if n%2 == 0
		bne $t1, $zero, coll_else
		div $a0, $a0, 2
		j coll_endif
		
	coll_else:
		add $t2, $a0, $a0 # 2*n
		add $t2, $t2, $a0 # 3*n
		addi $a0, $t2, 1  # 3*n+1
		
	coll_endif:
		addi $v0, $v0, 1  # result = 1 + collatz(n)
		j coll_if
		
	coll_done:
	jr $ra

done:
  # at this point $s0 and $s1 should contain the results from the two 
  # calls to longest_path
