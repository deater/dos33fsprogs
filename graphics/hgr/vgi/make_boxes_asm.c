#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define VGI_CLEARSCREEN		0
#define VGI_RECTANGLE		1
#define VGI_CIRCLE		2
#define VGI_FILLED_CIRCLE	3
#define VGI_POINT		4
#define VGI_LINETO		5
#define VGI_DITHER_RECTANGLE	6
#define VGI_VERT_TRIANGLE	7
#define VGI_HORIZ_TRIANGLE	8
#define VGI_VSTRIPE_RECTANGLE	9
#define VGI_LINE		10
#define VGI_LINE_FAR		11
#define	VGI_END			15

/* non-encoded pseudo-values */
#define VGI_VERT_TRIANGLE_SKIP	128+7

int main(int argc, char **argv) {

	char buffer[1024];
	char *ptr;
	int type,color1,color2,x1,x2,y1,y2,r,xl,xr,yt,yb;
	int line=1;
	int size=0;
	int skip=0;

	while(1) {

		type=0;

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;

		if (buffer[0]==';') continue;

		if (isalpha(buffer[0])) {
			if (!strncmp(buffer,"CLS",3)) {
				type=VGI_CLEARSCREEN;
			}
			if (!strncmp(buffer,"RECT",4)) {
				type=VGI_RECTANGLE;
			}
			if (!strncmp(buffer,"CIRC",4)) {
				type=VGI_CIRCLE;
			}
			if (!strncmp(buffer,"FCIRC",5)) {
				type=VGI_FILLED_CIRCLE;
			}
			if (!strncmp(buffer,"POINT",5)) {
				type=VGI_POINT;
			}
			if (!strncmp(buffer,"LINETO",6)) {
				type=VGI_LINETO;
			}
			else if (!strncmp(buffer,"LINEF",5)) {
				type=VGI_LINE_FAR;
			}
			else if (!strncmp(buffer,"LINE",4)) {
				type=VGI_LINE;
			}
			if (!strncmp(buffer,"DRECT",5)) {
				type=VGI_DITHER_RECTANGLE;
			}
			if (!strncmp(buffer,"VTRISK",6)) {
				type=VGI_VERT_TRIANGLE_SKIP;
			} else if (!strncmp(buffer,"VTRI",4)) {
				type=VGI_VERT_TRIANGLE;
			}
			if (!strncmp(buffer,"HTRI",4)) {
				type=VGI_HORIZ_TRIANGLE;
			}
			if (!strncmp(buffer,"VSTRP",5)) {
				type=VGI_VSTRIPE_RECTANGLE;
			}
			if (!strncmp(buffer,"END",3)) {
				type=VGI_END;
			}
		}
		else {
			sscanf(buffer,"%i",&type);
		}

		switch(type) {
			case VGI_CLEARSCREEN: /* clear screen */
				sscanf(buffer,"%*s %i",&color1);
				printf(".byte $%02X,",(type<<4)|2);
				printf("$%02X\n",color1);
				size+=2;
				break;

			case VGI_RECTANGLE: /* compact rectangle */
				sscanf(buffer,"%*s %i %i %i %i %i %i",
					&color1,&color2,
					&x1,&y1,&x2,&y2);
				printf(".byte $%02X,",(type<<4)|6);
				printf("$%02X,",(color1<<4)|color2);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",x2-x1);
				printf("$%02X\n",y2-y1);
				size+=6;
				break;

			case VGI_CIRCLE: /* circle */
				sscanf(buffer,"%*s %i %i %i %i",
					&color1,
					&x1,&y1,&r);
				printf(".byte $%02X,",(type<<4)|5);
				printf("$%02X,",color1);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X\n",r);
				size+=5;
				break;

			case VGI_FILLED_CIRCLE: /* filled circle */
				sscanf(buffer,"%*s %i %i %i %i",
					&color1,
					&x1,&y1,&r);
				printf(".byte $%02X,",(type<<4)|5);
				printf("$%02X,",color1);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X\n",r);
				size+=5;
				break;

			case VGI_POINT: /* point */
				sscanf(buffer,"%*s %i %i %i",
					&color1,
					&x1,&y1);
				printf(".byte $%02X,",(type<<4)|4);
				if (x1>255) {
					x1=x1&0xff;
					color1|=128;
				}
				printf("$%02X,",color1);
				printf("$%02X,",x1);
				printf("$%02X\n",y1);
				size+=4;
				break;

			case VGI_LINETO: /* line to */
				sscanf(buffer,"%*s %i %i",
					&x1,&y1);
				printf(".byte $%02X,",(type<<4)|3);
				printf("$%02X,",x1);
				printf("$%02X\n",y1);
				size+=3;
				break;

			case VGI_DITHER_RECTANGLE: /* dithered rectangle */
				sscanf(buffer,"%*s %i %i %i %i %i %i",
					&color1,&color2,
					&x1,&y1,&x2,&y2);
				printf(".byte $%02X,",(type<<4)|7);
				printf("$%02X,",color1);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",x2-x1);
				printf("$%02X,",y2-y1);
				printf("$%02X\n",color2);
				size+=7;
				break;

			case VGI_VERT_TRIANGLE: /* vertical triangle */
				sscanf(buffer,"%*s %i %i %i %i %i %i",
					&color1,
					&x1,&y1,&xl,&xr,&yb);
				printf(".byte $%02X,",(type<<4)|7);
				printf("$%02X,",(1<<4)|color1);	/* skip=1 */
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",xl);
				printf("$%02X,",xr);
				printf("$%02X\n",yb);
				size+=7;
				break;

			case VGI_VERT_TRIANGLE_SKIP: /* vertical triangle w skip*/
				sscanf(buffer,"%*s %i %i %i %i %i %i %i",
					&color1,
					&x1,&y1,&xl,&xr,&yb,&skip);
				printf(".byte $%02X,",(VGI_VERT_TRIANGLE<<4)|7);
				printf("$%02X,",(skip<<4)|color1);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",xl);
				printf("$%02X,",xr);
				printf("$%02X\n",yb);
				size+=7;
				break;

			case VGI_HORIZ_TRIANGLE: /* horizontal triangle */
				sscanf(buffer,"%*s %i %i %i %i %i %i",
					&color1,
					&x1,&y1,&yt,&yb,&xr);
				printf(".byte $%02X,",(type<<4)|7);
				printf("$%02X,",color1);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",yt);
				printf("$%02X,",yb);
				printf("$%02X\n",xr);
				size+=7;
				break;

			case VGI_VSTRIPE_RECTANGLE: /* vstriped rectangle */
				sscanf(buffer,"%*s %i %i %i %i %i %i",
					&color1,&color2,
					&x1,&y1,&x2,&y2);
				printf(".byte $%02X,",(type<<4)|7);
				printf("$%02X,",color1);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",x2-x1);
				printf("$%02X,",y2-y1);
				printf("$%02X\n",color2);
				size+=7;
				break;

			case VGI_LINE: /* line */
				sscanf(buffer,"%*s %i %i %i %i %i",
					&color1,
					&x1,&y1,&x2,&y2);
				printf(".byte $%02X,",(type<<4)|6);
				if (x1>255) {
					x1=x1&0xff;
					color1|=128;
				}
				printf("$%02X,",color1);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",x2);
				printf("$%02X\n",y2);
				size+=6;
				break;

			case VGI_LINE_FAR: /* line */
				sscanf(buffer,"%*s %i %i %i %i %i",
					&color1,
					&x1,&y1,&x2,&y2);
				printf(".byte $%02X,",(type<<4)|6);
				if (x1>255) {
					x1=x1&0xff;
					color1|=128;
				}
				if (x2<256) {
					fprintf(stderr,"Error!  X2 too small %d on line %d\n",x2,line);
				}
				x2=x2&0xff;
				printf("$%02X,",color1);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",x2);
				printf("$%02X\n",y2);
				size+=6;
				break;


			case VGI_END: /* end */
				printf(".byte $FF\n");
				size+=1;
				break;

			default:
				fprintf(stderr,"Unknown type %i line %d\n",
					type,line);
				break;
		}

		line++;

	}

	printf("\n");

	fprintf(stderr,"Size is %d bytes\n",size);
	return 0;
}
