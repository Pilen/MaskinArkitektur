# Instructions to be tested
#  - R-type  addu subu and or nor slt sll srl sra jr
#  - I-type  addiu andi ori slti beq sw lw
#  - J-type  j jal


# addu, subu, addiu
  addiu $1, $0, 0x1      # $1 = 0x1
  addiu $2, $0, 0xc      # $2 = 0xc
  addiu $3, $0, 0xffff   # $3 = 0xffffffff
  addu  $4, $1, $2       # $4 = 0xd
  subu  $5, $2, $1       # $5 = 0xb
  subu  $6, $1, $2       # $6 = 0xfffffff5

# slt, slti
  slt   $7, $2, $0       # $7 = 0x0
  slt   $8, $0, $2       # $8 = 0x1
  slti  $9, $2, 0x0      # $9 = 0x0
  slti  $10, $0, 0xf     # $10 = 0x1
  slti  $11, $3, 0xffff  # $11 = 0x0
  slti  $12, $6, 0xffff  # $12 = 0x1

# and, or, nor
  or    $13, $0, $2      # $13 = 0xc
  or    $14, $3, $0      # $14 = 0xffffffff
  nor   $13, $13, $13    # $13 = 0xfffffff3
  nor   $14, $14, $14    # $14 = 0x0
  and   $15, $14, $0     # $15 = 0x0
  and   $16, $13, $13     # $16 = 0xfffffff3

# andi, ori
  ori   $17, $0, 0xf     # $17 = 0xf
  ori   $18, $17, 0x8000 # $18 = 0x800f
  andi  $19, $3, 0xffff  # $19 = 0xffff
  andi  $20, $3, 0x4000  # $20 = 0x4000

# sll, srl, sra
  sll $21, $1, 16        # $21 = 0x10000
  srl $21, $21, 16       # $21 = 0x1
  sll $21, $21, 16       # $21 = 0x10000
  sra $21, $21, 16       # $21 = 0x1
  sll $21, $21, 31       # $21 = 0x80000000
  srl $21, $21, 31       # $21 = 0x1
  sll $21, $21, 31       # $21 = 0x80000000
  sra $21, $21, 31       # $21 = 0xffffffff

# lw, sw
  sw $1, 0($0)           # M[0x0] = 0x1
  sw $2, 8($0)           # M[0x8] = 0xc
  sw $3, 0($2)           # M[0xc] = 0xffffffff
  lw $22, 0($0)          # $22 = 0x1
  lw $23, 8($0)          # $23 = 0xc
  lw $24, 0($2)          # $24 = 0xffffffff

# beq
  ori $25, $0, 0xdead    # $25 = 0xdead
  sll $25, $25, 16       # $25 = 0xdead0000
  beq $25, $25, l_beq1
  and $25, $0, $0        # $25 = 0x0 (= fail)
l_beq1:
  beq $0, $1, l_beq2
  ori $25, $25, 0xbeef   # $25 = 0xdeadbeef
l_beq2:

# j, jr, jal
  j     l_jump0
  addiu $26, $26, 0xffff # $26 = 0xffffffff (= fail)
l_jump0:
  ori $26, $0, 0xdefe    # $26 = 0xdefe
  sll $26, $26, 16       # $26 = 0xdefe0000
  jal   l_jump1
  beq $0, $0, l_jump2
  add $26, $0, $0        # $26 = 0x0 (= fail)
l_jump1:
  ori $26, $26, 0xc8ed   # $26 = 0xdefec8ed
  jr    $ra
  addiu $26, $0, 0x0     # $26 = 0x0 (= fail)
l_jump2:

