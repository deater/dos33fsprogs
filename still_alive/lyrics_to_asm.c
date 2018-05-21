#include <stdio.h>

int main(int argc, char **argv) {

	char string[256],*result;
	int frame,i;

	while(1) {
		result=fgets(string,256,stdin);
		if (result==NULL) break;

		printf("; %s",string);
		sscanf(string,"%d",&frame);
		printf(".byte\t$%02X",frame&0xff);

		i=0;
		/* get to first quote */
		while(string[i]!='\"') i++;
		i++;

		/* stop at second quote */
		while(string[i]!='\"') {
			if (string[i]=='\\') {
				i++;
				/* Ignore if we have LED panel */
				if (string[i]=='i') {
					//printf(",$%02X",10);
				}
				/* form feed */
				else if (string[i]=='f') {
					printf(",$%02X",12);
				}
				/* Vertical tab */
				else if (string[i]=='v') {
					printf(",$%02X",11);
				}
				else if (string[i]=='n') {
					printf(",$%02X",13|0x80);
				}
				else if ((string[i]>='0') &&
					(string[i]<=':')) {
					printf(",$%02X",string[i]-'0');
				}
				else {
					printf("UNKNOWN ESCAPE\n");
				}
				i++;
				continue;
			}
			printf(",$%02X",string[i]|0x80);
			i++;
		}

		printf(",$00\n");
	}

	return 0;
}
