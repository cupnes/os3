	.file	"bootpack.c"
	.text
	.globl	OSMain
	.type	OSMain, @function
OSMain:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
.L2:
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	OSMain, .-OSMain
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
