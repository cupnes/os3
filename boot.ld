OUTPUT_FORMAT("binary");
IPLBASE = 0x7c00;

SECTIONS
{
		. = IPLBASE;
		.text	: {*(.text)}
		.data	: {*(.data)}

		. = IPLBASE + 510;
		.sign	: {SHORT(0xaa55)}
		.sign	: {LONG(0xbeefcafe)}

		. = IPLBASE + 1024;
		.sign	: {LONG(0x01234567)}
}
