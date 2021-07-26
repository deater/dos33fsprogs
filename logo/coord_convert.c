#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;
	int x,y;

	while(1) {
		result=fgets(string,BUFSIZ,stdin);
		if (result==NULL) break;

		if (result[0]==';') continue;

		if (strstr(result,"SETPOS")) {
			sscanf(result,"%*s %d %d",&x,&y);
			printf("SETPOS [%d %d]\n",x-140,96-y);	// 140,96 => 0,0
		}
		else if (strstr(result,"FILL")) {
			sscanf(result,"%*s %d %d",&x,&y);
			printf("FILL [%d %d]\n",x-140,96-y);	// 140,96 => 0,0
		}
		else {
			printf("%s",result);
		}
	}

	return 0;
}
