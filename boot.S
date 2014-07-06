BOOTSEG		= 0x07C0		/* original address of boot-sector */
	.code16
	.global	_start
_start:
	movw	$0xbeef, %ax
_loop:
	ljmp	$BOOTSEG, $_loop
