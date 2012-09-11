#**********************************************************************
#   CSSE 232: Computer Architecture
#
#   File:    p6.asm
#   Written: 3/9/97, Rimli Sengupta
#   Modified by:  J.P. Mellor, 6 Sep. 2004
#
# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm, p3.asm, p4.asm and p5.asm.
#
# It also takes advantage of several spim syscalls and the assembly
# directive .asciiz
#
#**********************************************************************

	.globl	main
	.globl	V


	.data

V:	.word   20, 56, -90, 37, -2, 30, 10, -66, -4, 18
N:	.word	10
message:	.asciiz "The rotated array: "
sep:	.asciiz " "
newline:	.asciiz "\n"

#**********************************************************************

	.text

main:	

	
#----------------------------------------------------------------------
# 	Rotate the array
#----------------------------------------------------------------------

	la	$t1, N		# load the address of N
	lw	$t1, 0($t1)	# load the value of N
	sll     $t1, $t1, 2     # multiply by 4
	addi    $t1, $t1, -4	# calibrate test case to account for last element
	li	$t0, 0		# initialize counter at zero
	lw	$t3, V($t0)	# initialize $t3 as first element(index 0)
loop1:
	move	$t2, $t3	# reassign $t2 to $t3 the last element
	add     $t0, $t0, 4     # increment the index
	lw	$t3, V($t0)	# load next element into $t3
	sw	$t2, V($t0)	# store last element into current index
	bne	$t0, $t1, loop1	#loop if not end of array
	sw	$t3, V($zero)	#store last element into the first index


#----------------------------------------------------------------------
# 	Print the rotated array
#----------------------------------------------------------------------

	la	$t1, N		# load the address of N
	lw	$t1, 0($t1)	# load the value of N
	sll	$t1, $t1, 2     # multiply by 4
	la	$a0, message	# store pointer to message
	li	$v0, 4		# use system call to
	syscall			# print message
	li	$t0, 0		# initialize the index
loop2:	lw	$a0, V($t0)	# store next element
	li	$v0, 1		# use system call to
	syscall			# print the min
	la	$a0, sep	# store pointer to sep
	li	$v0, 4		# use system call to
	syscall			# print sep
	add	$t0, $t0, 4	# increment the index
	bne	$t0, $t1, loop2	# check if we've printed all the elements
	la	$a0, newline	# store pointer to a new line
	li 	$v0, 4		# use system call to
	syscall			# print new line

# --------------------------------------------------------------------
#   Exit 
# ---------------------------------------------------------------------

	li	$v0, 10		# use system call to
	syscall			# exit

