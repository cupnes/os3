BOOTSEG		= 0x07C0		/* original address of boot-sector */
	.code16
	movw	$BOOTSEG, %ax
	movw	%ax, %ds
	movw	$welcome_msg, %si

msg_loop:
	lodsb
	andb	%al, %al
	jz		bs_loop
	movb	$0xe, %ah
	movw	$7, %bx
	int		$0x10
	jmp		msg_loop

bs_loop:
	jmp		bs_loop

welcome_msg:
	.ascii	"Welcome to OS3!"
	.byte	0
