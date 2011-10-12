# Test basic pipeline functionality (no hazards occur).
  addiu $1, $0, 1        # $1 = 0x1
  addiu $2, $0, 2        # $2 = 0x2
  addiu $3, $0, 3        # $3 = 0x3
  addiu $4, $0, 4        # $4 = 0x4

  addu  $1, $1, $1       # $1 = 0x2
  sll   $2, $2, 1        # $2 = 0x4
  ori   $3, $3, 4        # $3 = 0x7
  slt   $4, $4, $3       # $4 = 0x1
  sw    $1, 0($0)        # M[0] = 0x2
  lw    $5, 0($0)        # $5 = 0x2



# Test forwarding.
# Forward from MEM/WB.
  addiu $6, $0, 0x1      # $6 = 0x1
  nop
  addu  $7, $6, $6       # $7 = 0x2
# Forward from EX/MEM.
  addiu $6, $0, 0x2      # $6 = 0x2
  addu  $8, $6, $6       # $8 = 0x4
# Both MEM/WB and EX/MEM are forwarding candidates; forward from EX/MEM.
  addu  $9, $9, $6       # $9 = 0x2
  addu  $9, $9, $6       # $9 = 0x4
  addu  $9, $9, $6       # $9 = 0x6
  addu  $9, $9, $6       # $9 = 0x8



# Test stalling.
# Data hazard caused by lw followed by an immediate use of the
# fetched value.
  addiu $10, $0, 1       # $10 = 0x1
  sw    $10, 0($0)       # M[0] = 0x1
  lw    $10, 0($0)
  addu  $11, $10, $10    # $11 = 0x2


# Test flushing caused by j, jal and jr.
  j     l1
  addiu $30, $0, 1      # $30 != 0 (= fail)
l1:
  # sw to avoid structural hazard at jal
  sw    $0, 0($0)        # M[0] = 0x0
  sw    $0, 0($0)        # M[0] = 0x0
  sw    $0, 0($0)        # M[0] = 0x0
  jal   l2
  j     l3
  addiu $30, $0, 2      # $30 != 0 (= fail)
l2:
  jr    $ra
  addiu $30, $0, 3      # $30 != 0 (= fail)
l3:
# Test flushing caused by beq.
  beq $1, $0, l5
  addiu $12, $12, 1      # $12 = 1
  addiu $12, $12, 1      # $12 = 2
  beq $0, $0, l6
  addiu $29, $0, 1      # $29 != 0 (= fail)
  addiu $29, $0, 2      # $29 != 0 (= fail)
l5:
  addiu $29, $0, 3      # $29 != 0 (= fail)
l6:

