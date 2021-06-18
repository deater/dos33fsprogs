#include <stdio.h>

int main(int argc, char **argv) {

	char buffer[1024];
	char *ptr;
	int type,color1,color2,x1,x2,y1,y2;
	int line=1;

	while(1) {

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;

		if (buffer[0]==';') continue;

		sscanf(buffer,"%d",&type);

		switch(type) {
			case 0: /* clear screen */
				sscanf(buffer,"%d %d",&type,&color1);
				printf(".byte $%02X,",(type<<4)|2);
				printf("$%02X\n",color1);
				break;
			case 1: /* compact rectangle */
				sscanf(buffer,"%d %d %d %d %d %d %d",
					&type,
					&color1,&color2,
					&x1,&y1,&x2,&y2);
				printf(".byte $%02X,",(type<<4)|6);
				printf("$%02X,",(color1<<4)|color2);
				printf("$%02X,",x1);
				printf("$%02X,",y1);
				printf("$%02X,",x2-x1);
				printf("$%02X\n",y2-y1);
				break;

			case 15: /* end */
				printf(".byte $FF\n");
				break;

			default:
				fprintf(stderr,"Unknown type %d\n",type);
				break;
		}

		line++;

	}

	printf("\n");
	return 0;
}
