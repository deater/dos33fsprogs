/* code by qkumba */

#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {

	int i = 0;
	int e = 0,filesize;
	unsigned char in[1024];
	unsigned char enc[1024];

	printf("1REM");
	filesize=read(0,in,1024);
	do {
		enc[e++] = ((in[i + 2] & 3) << 4) +
			((in[i + 1] & 3) << 2) + (in[i + 0] & 3) + 32;
		if (i<filesize) printf("%c",(in[i + 0] >> 2) + 32);
		if (i + 1 < filesize) printf("%c",(in[i + 1] >> 2) + 32);
		if (i + 2 < filesize) printf("%c",(in[i + 2] >> 2) + 32);
	} while ((i += 3) < filesize);
	enc[e]=0;

	printf("%s\n",enc);
	printf("2FORI=0TO%d:C=(PEEK(%d+I/3)-32)/4^(I-INT(I/3)*3):POKE768+I,C+4*(PEEK(2054+I)-32-INT(C/4)):NEXT:CALL768\n",
		filesize,2054+filesize);

// note, peek/poke truncate?
//2FORI=1013TO1141:C=(PEEK(1843+I/3)-32)/4^(I-INT(I/3)*3):POKEI,C+4*(PEEK(1041+I)-32-INT(C/4)):NEXT:&

	return 0;
}
