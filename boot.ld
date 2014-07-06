OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS
{
	. = 0;
	.bstext		: { *(.bstext) }

	. = 510;
	.bsfooter	: { *(.bsfooter) }
}
