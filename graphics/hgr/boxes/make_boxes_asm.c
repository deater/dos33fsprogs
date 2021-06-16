#include <stdio.h>

int main(int argc, char **argv) {

	char buffer[1024];
	char *ptr;
	int color1,color2,x1,x2,y1,y2;
	char output[1024];
	int out_ptr=0;
	int old_color=0xff;
	int line=1;
	int add=' ';

	while(1) {

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;

		if (buffer[0]==';') continue;

		sscanf(buffer,"%d %d %d %d %d %d",
			&color1,&color2,&x1,&y1,&x2,&y2);

		printf(".byte $%02X,",(color1<<4)|color2);
		printf("$%02X,",x1);
		printf("$%02X,",y1);
		printf("$%02X,",x2-x1);
		printf("$%02X\n",y2-y1);

		line++;

//		printf("\t.byte $%02X,$%02X,$%02X,$%02X\n",
//				y1,y2,
//				((color&0x03)<<6)|x1,
//				((color&0x0c)<<4)|x2);


	}
//	printf("\t.byte $FF\n");


	printf("\n");
	return 0;
}
