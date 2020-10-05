/* code by qkumba */

#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {

	int i = 0;
	int e = 0,filesize;
	unsigned char in[1024];
	unsigned char enc[1024];

	filesize=read(0,in,1024);
	do {
		enc[e++] = ((in[i + 2] & 3) << 4) +
			((in[i + 1] & 3) << 2) + (in[i + 0] & 3) + 32;
		in[i + 0] = (in[i + 0] >> 2) + 32;
		in[i + 1] = (in[i + 1] >> 2) + 32;
		in[i + 2] = (in[i + 2] >> 2) + 32;
		printf("%c%c%c",in[i],in[i+1],in[i+2]);//write(o, in + i, 3);
	} while ((i += 3) < filesize);
	enc[e]=0;
	printf("%s\n",enc);

	return 0;
}
