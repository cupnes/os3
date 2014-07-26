	.code16
	.text
	jmp		entry

	.byte	0x90
	.ascii	"HELLOIPL"		# ブートセクタの名前
	.word	512				# 1セクタの大きさ
	.byte	1				# クラスタの大きさ
	.word	1				# FATがどこから始まるか
	.byte	2				# FATの個数
	.word	224				# ルートディレクトリのサイズ
	.word	2880			# このドライブの大きさ
	.byte	0xf0			# メディアのタイプ
	.word	9				# FAT領域の長さ
	.word	18				# 1トラックにいくつのセクタがあるか
	.word	2				# ヘッドの数
	.int	0				# 必ず0
	.int	2880			# ドライブのサイズ
	.byte	0, 0, 0x29
	.int	0xffffffff		# ボリュームのシリアル番号
	.ascii	"HELLO-OS   "	# ディスクの名前
	.ascii	"FAT12   "		# フォーマットの名前
	.skip	18, 0x00		# 18バイト空ける

# プログラム本体
entry:
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

readloop:
	movw	$0x0000, %si	/* Fault num counter	*/
retry:
	movb	$0x02, %ah	/* Read from disk	*/
	movb	$0x01, %al	/* 1 sector			*/
	movw	$0x0000, %bx
	movb	$0x00, %dl	/* Drive A			*/
	int		$0x13		/* Call disk BIOS	*/
	jnc		next
	addw	$1, %si
	cmpw	$5, %si
	jae		error
	movb	$0x00, %ah
	movb	$0x00, %dl
	int		$0x13
	jmp		retry
next:
	movw	%es, %ax
	addw	$0x0020, %ax
	movw	%ax, %es
	addb	$1, %cl
	cmpb	$18, %cl
	jbe		readloop

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
