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
	jr $ra

done:
  # at this point $s0 and $s1 should contain the results from the two 
  # calls to longest_path
