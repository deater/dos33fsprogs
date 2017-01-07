/* Dump a shape table.  Trying to debug a weird problem. */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static char name[8][5]={
	"NUP",
	"NRT",
	"NDN",
	"NLT",
	"UP",
	"RT",
	"DN",
	"LT"
};

int main(int argc, char **argv) {

	int ch,i;
	int h,l;
	int num_shapes=0,offset;
	int a,b,c;

	l=fgetc(stdin);
	h=fgetc(stdin);
	printf("BLOAD address: 0x%x\n",(h*256)+l);
	l=fgetc(stdin);
	h=fgetc(stdin);
	printf("BLOAD size: %d\n",(h*256)+l);
	offset=0;

	num_shapes=fgetc(stdin);
	printf("NUM SHAPES = %d\n",num_shapes);
	ch=fgetc(stdin);
	if (ch!=0) printf("\tERROR! NOT ZERO\n");
	offset+=2;

	for(i=0;i<num_shapes;i++) {
		l=fgetc(stdin);
		h=fgetc(stdin);
		printf("SHAPE %d offset = %d\n",i,(h*256)+l);
		offset+=2;
	}

	while(1) {
		ch=fgetc(stdin);
		if (ch<0) break;

		a=ch&0x7;
		b=(ch>>3)&0x7;
		c=(ch>>6)&0x3;

		printf("%d:\t%x ",offset,ch);
		if ((c==0) && (b==0) && (a==0)) {
			printf("END!\n");
		} else{
			printf("\tA: %s ",name[a]);
		}
		if ((c==0) && (b==0)) {
		}
		else {
			printf("\tB: %s ",name[b]);
		}
		if (c!=0) printf("\tC: %s ",name[c]);
		printf("\n");
		offset++;
	}

	return 0;
}
