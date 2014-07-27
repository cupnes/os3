	.equ	CYLS,	0x0ff0
	.equ	LEDS,	0x0ff1
	.equ	VMODE,	0x0ff2
	.equ	SCRNX,	0x0ff4
	.equ	SCRNY,	0x0ff6
	.equ	VRAM,	0x0ff8

	.text
	.code16
	movb	$0x13, %al
	movb	$0x00, %ah
	int		$0x10
	movb	$8, (VMODE)
	movw	$320, (SCRNX)
	movw	$200, (SCRNY)
	movl	$0x000a0000, (VRAM)

	movb	$0x02, %ah
	int		$0x16
	movb	%al, (LEDS)

fin:
	hlt
	jmp		fin
