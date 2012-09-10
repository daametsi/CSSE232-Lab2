# File:         p4.asm
# Written by:   Larry Merkle, Dec. 5, 2002
# Modified by:  J.P. Mellor, 6 Sep. 2004
#
# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm and p3.asm plus the following:
#
#   bne rs, rt, label	- Conditionally branch to label if register rs is
#			  not equal to register rt.
#
# It adds the numbers from 1 to N.  It assumes N > 0.
#
# It is intended to help CSSE 232 students familiarize themselves with MIPS
# and SPIM.
#
# After running and understanding this program, students are asked to
# modify it so that it works for N = 0 using these instructions:
#
#   beq rs, rt, label	- Conditionally branch to label if register rs
#			  equals rt.
#   j label		- Unconditionally jump to label. 
#
# Register usage
#
# $t0 - several uses:
#       1) the address of N
#       2) the value of N
#       3) the address of Sum
# $t1 - the constant 1
# $t2 - i (the counter)
# $t3 - total (the running total)

	.globl main		# Make main, N, Sum, loop and exit globl
	.globl N		# so you can refer to them by name in SPIM.
	.globl Sum
	.globl loop
	.globl exit


	.data			# Data section of the program.

N:	.word 5
Sum:	.word 0


	.text			# Text section of the program
	
main:				# Program starts at MAIN.
#
# Initialization
#
        la	$t0, N		# Set $t0 to the address of N
	lw	$t0, 0($t0)	# Set $t0 to the value of N
	li	$t1, 1		# Set $t1 to 1
	li	$t2, 0		# Set $t2 (hereafter called i) to 0
	li	$t3, 0		# Set $t3 (hereater called total) to 0

	beq	$t0,$zero,exit	# Exit if N is 0
loop:
	add	$t2, $t2, $t1	# Increment i
	add	$t3, $t3, $t2	# Add i to total
	bne	$t2, $t0, loop	# Continue loop if i < N

exit:
	la	$t0, Sum	# Set $t0 to the address of Sum
	sw	$t3, 0($t0)	# Store the total in Sum

	li	$v0, 10		# Prepare to exit
	syscall			#   ... Exit.
