main:
    # initialize stack pointer
    ori $sp, $sp, 0xFFFC

    # call longest_path(10)
    addiu $a0, $zero, 10
    jal longest_path
    addu $s0, $zero, $v0         # store result in $s0

    # call longest_path(50)
    addiu $a0, $zero, 50
    jal longest_path
    addu $s1, $zero, $v0         # store result in $s1

    j done

longest_path:
    addiu $t0, $zero, 1    # n is initialized
    addu $t1, $a0, $zero   # limit is initialized
    addu $t2, $zero, $zero # max-length initialized
    addiu $sp, $sp, -4     # Make room for the return address
    sw $ra, 0($sp)         # Save the return address

    long_loop:
        addiu $a0, $t0, 0      # Store n as an argument
		addu $a1, $zero, $zero # Store CURRENT iteration as an argument
        addiu $sp, $sp, -12    # make room for four elements on the stack
        sw $t2, 8($sp)         # Save max-length
        sw $t1, 4($sp)         # Save limit
        sw $t0, 0($sp)         # Save n

        jal collatz

        lw $t2, 8($sp)    # Load max-length
        lw $t1, 4($sp)    # Load limit
        lw $t0, 0($sp)    # Load n
        addiu $sp, $sp, 12 # Reserve space on the stack

        slt $t3, $t2, $v0          # $t3 = 1 if max-length < length
        beq $t3, $zero, long_endif # jump if max-length >= length
        addu $t2, $v0, $zero       # max-length = length

        long_endif:
        addiu $t0, $t0, 1       # n++
        slt $t4, $t0, $t1       # $t4 = 1 if n < limit
        addiu $t5, $zero, 1     # Create a 1 for comparison
        beq $t4, $t5, long_loop # jump if n < limit

    lw $ra, 0($sp)    # Load the return address
    addiu $sp, $sp, 4 # Remove reservation on stack
    addiu $v0, $t2, 0 # Store the result
    jr $ra

collatz:
    slt $t4, $zero, $a1   # t4 = 1 if 0 < iteration
    addiu $t5, $zero, 1   # Create a 1 for comparison
    beq $t4, $t5, coll_if # Branch if iteration > 0
	addiu $sp, $sp, -4    # Reserve space on the stack
	sw $ra, 0($sp)        # Store return address of the ORIGINAL caller

    coll_if:
        beq $a0, $t5, coll_done

        andi $t1, $a0, 1 # $t1 = 0 if n%2 == 0
        beq $t1, $zero, coll_elif

        addu $t2, $a0, $a0 # 2*n
        addu $t2, $t2, $a0 # 3*n
        addiu $a0, $t2, 1  # 3*n+1
        j coll_endif

    coll_elif:
        srl $a0, $a0, 1 # n = n/2

    coll_endif:
    addiu $a1, $a1, 1 # iteration = 1 + collatz(n)
    jal collatz       # The two arguments a0, a1 is again given as arguments

    coll_done:
	lw $ra 0($sp)        # Load ORIGINAL callers return address
	addiu $sp, $sp, 4    # Remove reservation on stack
	addu $v0, $a1, $zero # store the final iteration a result
    jr $ra

done:
    # at this point $s0 and $s1 should contain the results from the two
    # calls to longest_path
