	.code16
	.text

	movw	$0x0000, %ax
	movw	%ax, %ss
	movw	$0x7c00, %sp
	movw	%ax, %ds
	movw	%ax, %es

	movw	$welcome_msg, %si

msg_loop:
	lodsb
	andb	%al, %al
	jz		load_disk
	movb	$0xe, %ah
	movw	$7, %bx
	int		$0x10
	jmp		msg_loop

/* Loading from disk */
load_disk:
	movw	$0x0820, %ax
	movw	%ax, %es
	movb	$0x00, %ch	/* Cylinder	0	*/
	movb	$0x00, %dh	/* Head		0	*/
	movb	$0x02, %cl	/* Sector	2	*/

	movb	$0x02, %ah	/* Read from disk	*/
	movb	$0x01, %al	/* 1 sector			*/
	movw	$0x0000, %bx
	movb	$0x00, %dl	/* Drive A			*/
	int		$0x13		/* Call disk BIOS	*/
	jc		error

bs_loop:
	hlt
	jmp		bs_loop

error:
	hlt
	jmp		error

	.data
welcome_msg:
	.ascii	"Welcome to OS3!"
	.byte	0
