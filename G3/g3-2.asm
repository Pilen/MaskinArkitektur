  addiu $1, $0, 10
  addiu $2, $0, 0
l1:
  slt $3, $1, $2
  # This branch should be predicted correctly after the first
  # loop iteration.
  beq $3, $0, l2
  nop
  nop
  j l3
l2:
  addiu $2, $2, 1
  j l1
  nop
l3:
  nop

