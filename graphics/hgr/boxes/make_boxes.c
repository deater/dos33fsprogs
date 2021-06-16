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
#if 0

	while(1) {

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;

		sscanf(buffer,"%d %d %d %d %d",
			&color,&x1,&x2,&y1,&y2);

//		printf("\t.byte $%02X,$%02X,$%02X,$%02X,$%02X\n",
//			color,x1,x2,y1,y2);

		if (color==old_color) {
			printf("\t.byte $%02X,$%02X,$%02X,$%02X\n",
				y1|0x80,y2,x1,x2);
		}
		else {
			printf("\t.byte $%02X,$%02X,$%02X,$%02X,$%02X\n",
				color,y1,y2,x1,x2);
		}

		old_color=color;

//		output[out_ptr]=color+32;
//		output[out_ptr+1]=x1+32;
//		output[out_ptr+2]=x2+32;
//		output[out_ptr+3]=y1+32;
//		output[out_ptr+4]=y2+32;
//		out_ptr+=5;
	}
//	output[out_ptr]=0;
//	printf("%s\n",output);

	printf("\t.byte $FF\n");
#endif




	while(1) {

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;

		if (buffer[0]==';') continue;

		sscanf(buffer,"%d %d %d %d %d %d",
			&color1,&color2,&x1,&y1,&x2,&y2);

		x2=(x2-x1)/2;
		x1=x1/2;
		y2=(y2-y1)/2;
		y1=y1/2;

		if (x1>94) { printf("X1 too big %d line %d!\n",x1,line); }
		if (x2>94) { printf("X2 too big %d!\n",x2); }
		if (y1>94) { printf("Y1 too big %d!\n",y1); }
		if (y2>94) { printf("Y2 too big %d line %d!\n",y2,line); }


		printf("%c",color1+add);
		printf("%c",color2+add);
		printf("%c",x1+add);
		printf("%c",y1+add);
		printf("%c",x2+add);
		printf("%c",y2+add);

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
