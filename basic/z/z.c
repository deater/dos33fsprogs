#include <fcntl.h>
#include <io.h>
#include <stdio.h>
#include <string.h>

static unsigned char decoder[] = "\"******GRASCDEFPOP!i\\DEL0GRRETURN}i\\F0jjjjjjjF0jFORLOGASCsONERR0::=VALpRNDlo";

void main(int argc, char *argv[])
{
	int i, l, j, b2, b6;
	unsigned char b[150];
	unsigned char bb2[150];
	unsigned char bb6[150];
	unsigned char call[10];

	memset(b, 0, sizeof(b));
	i = open(argv[1], O_RDONLY | O_BINARY);
	l = read(i, b, sizeof(b));
	close(i);

	j = 0;
	b2 = 0;
	b6 = sizeof(bb6);

	do
	{
		unsigned char c;

		if (!(j % 3))
		{
			c = ((((b[j + 0] >> 6) & 2) + (b[j + 0] & 1)) << 0)
	 		  + ((((b[j + 1] >> 6) & 2) + (b[j + 1] & 1)) << 2)
			  + ((((b[j + 2] >> 6) & 2) + (b[j + 2] & 1)) << 4)
			  + 0x23;

			bb2[b2++] = c + (int) !j;
		}

		c = ((b[j] >> 1) & 0x3f) + 0x23 + (int) !(j % 3);

		bb6[--b6] = c;
	}
	while (++j < l);

	sprintf(call, "0CALL%d\"", 2049+10+b2+6+(int)sizeof(bb6)-b6+1);
	i = open("out", O_WRONLY | O_BINARY | O_CREAT | O_TRUNC, 0x80);
	write(i, call, strlen(call));
	write(i, bb2, b2);
	write(i, "\r\n1\"", sizeof("\r\n1\"")-1);
	write(i, bb6 + b6, sizeof(bb6) - b6);
	write(i, decoder, sizeof(decoder)-1);
	close(i);
}
