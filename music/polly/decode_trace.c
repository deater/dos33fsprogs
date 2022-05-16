#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 16384

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;
	long long cycles,oldcycles=0;
	int speaker_access;
	int count=0,which=0;
	int diffs[MAX];
	int first=1;

	while(1) {
		result=fgets(string,BUFSIZ,stdin);
		if (result==NULL) break;

		speaker_access=0;
		sscanf(result,"%llx",&cycles);
		if (strstr(result,"$C030")) speaker_access=1;

		if (speaker_access) {
			diffs[count]=cycles-oldcycles;
			if (first) {
				/* skip first */
				first=0;
			}
			else {
				count++;
			}
			oldcycles=cycles;
		}

		if (count>=MAX-1) {
			fprintf(stderr,"Error! Too big!\n");
			exit(1);
		}
	}

	/* now print high */

	printf("extra_high_values:\n");
	for(which=0;which<count;which++) {
		if ((which%16)==0) {
			printf(".byte\t");
		}
		else {
			printf(",");
		}
		printf("$%02X",(diffs[which]>>16));
		if ((which%16)!=15) {
		}
		else {
			printf("\n");
		}
	}
	printf("\n.byte\t$FF\n");


	/* now print high */

	printf("high_values:\n");
	for(which=0;which<count;which++) {
		if ((which%16)==0) {
			printf(".byte\t");
		}
		else {
			printf(",");
		}
		printf("$%02X",(diffs[which]>>8)&0xff);
		if ((which%16)!=15) {
		}
		else {
			printf("\n");
		}
	}
	printf("\n.byte\t$FF\n");


	/* now print low */

	printf("low_values:\n");
	for(which=0;which<count;which++) {
		if ((which%16)==0) {
			printf(".byte\t");
		}
		else {
			printf(",");
		}
		printf("$%02X",diffs[which]&0xff);
		if ((which%16)!=15) {
		}
		else {
			printf("\n");
		}
	}
	printf("\n.byte\t$FF\n");

	return 0;
}

