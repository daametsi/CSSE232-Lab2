# File:         P5.asm
# Written by:   Larry Merkle, Dec. 5, 2002
# Modified by:  J.P. Mellor, 6 Sep. 2004
#
# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm, p3.asm and p4.asm plus
# the following:
#
#   beq rs, rt, label	- Conditionally branch to label if register rs
#			  equals rt.
#   j label		- Unconditionally jump to label. 
#   sll rd, rt, shamt	- Shift register rt left by the distance indicated by 
#			  immediate shamt and put the result in register rd.
#			  Note:  this is an efficient way to multiply by a
#			  power of 2.  In this program this instruction is
#			  used to multiply by 4.
#   slt rd, rs, rt      - rd is set to a 1 if rs is less than rt otherwise
#			  rd is set to a 0.
#
# It finds the largest element of a zero-based array of non-negative
# integers, as well as its index.
#
# It is intended to help CSSE 232 students familiarize themselves with MIPS
# and SPIM.
#
# After running and understanding this program, students are asked to
# modify it so that it swaps the largest element with the last element.
#
# Register usage
#
# $t0 - two uses:
#       1) the address of N
#       2) the value of N
# $t1 - the constant 1
# $t2 - i (the counter)
# $t3 - unused
# $t4 - the base address of A
# $t5 - two uses:
#       1) the address of A[i]
#       2) the value of A[i]
# $t6 - max (the maximum known element)
# $t7 - maxindex (the index of max)
# $t8 - flag (set to 1 if max < A[i], otherwise 0)

	.globl main		# Make main, A, N, loop, ok and exit globl
	.globl N		# so you can refer to them by name in SPIM.
	.globl ok
	.globl loop
	.globl exit


	.data			# Data section of the program.

A:	.word 32, 16, 64, 80, 48
N:	.word 5


	.text			# Text section of the program

main:				# Program starts at MAIN.
#
# Initialization
#
        la	$t0, N		# Set $t0 to the address of N
	lw	$t0, 0($t0)	# Set $t0 to the value of N
	li	$t1, 1		# Set $t1 to 1
	li	$t2, 0		# Set $t2 (hereafter called i) to 0
	la	$t4, A		# Set $t4 to the address of A[i]
	# $t5 is assigned in the loop before it is used
	# uncomment the following line when you comment out sll
	# li	$t5, 1
	li	$t6, -1		# Set $t6 (hereafter called max) to -1
	# $t7 and $t8 are assigned in the loop before they are used

loop:
	beq	$t2, $t0, exit	# Continue loop if i < N

	# Load the next element
	sll	$t5, $t2, 2	# Set $t5 to i*4
	add	$t5, $t5, $t4	# Set $t5 to address of A[i]
	lw	$t5, 0($t5)	# Set $t5 to A[i]

	# Update max and maxindex if necessary
	slt	$t8, $t6, $t5	# Set flag to 1 if max < A[i], and 0 otherwise
	beq	$t8, $0, ok	# Skip update if flag is 0
	add	$t6, $t5, $0	# Set max to A[i]
	add	$t7, $t2, $0	# Set maxindex to i

	bne     $t2, $t0, loop	# if not last element, continue loop
        sw      $t5, 0($t7)	# move last element to index of max
        sw      $t6, 0($t2)	# move max to last element
ok:
	add	$t2, $t2, $t1	# Increment i
	j	loop		# Continue loop

exit:

	li	$v0, 10		# Prepare to exit
	syscall			#   ... Exit.

