#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define OFFSET	32
#define OFFSET2	35

//#define OFFSET	35

static int hex2int(int val) {

	if ((val>='0') && (val<='9')) return val-'0';
	if ((val>='A') && (val<='F')) return (val-'A')+10;
	if ((val>='a') && (val<='f')) return (val-'a')+10;

	printf("Unknown: %c %d\n",val,val);
	return -1;
}

static int color_count=0;
static int colors[16];

static int find_color(int which) {
	int i;

	for(i=0;i<color_count;i++) {
		if (colors[i]==which) {
//			printf("Found %d at %d\n",which,i);
			return i;
		}
	}

	/* not found */
	colors[color_count]=which;
//	printf("New %d at %d\n",which,color_count);
	color_count++;

	return color_count-1;
}


int main(int argc, char **argv) {

	int i = 0;
	unsigned char in[1024];
	char string[256];
	char *result;
	int op=0;
	int color;


	memset(in,0,sizeof(in));

	memset(colors,0,sizeof(colors));

	while(1) {
		result=fgets(string,256,stdin);
		if (result==NULL) break;

		for(i=0;i<strlen(string);i++) {
			if (string[i]=='$') {
				color=find_color(hex2int(string[i+1]));
				in[op]=color;
				op++;
				color=find_color(hex2int(string[i+2]));
				in[op]=color;
				op++;
			}
		}
	}
	printf("Raw Image was %d bytes, %d colors\n",op,color_count);

	for(i=0;i<8;i++) printf("%c",colors[i]+35);

	for(i=0;i<op;i+=2) printf("%c",((in[i]<<3)+in[i+1])+35);

	printf("\n");

	return 0;
}
