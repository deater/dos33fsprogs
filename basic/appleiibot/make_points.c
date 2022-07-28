#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	char buffer[1024];
	char *ptr;
	int a1,a2,a3,a4,a5;
	char output[1024];
	int out_ptr=0;
	int add=33;

	if (argc>1) {
		add=atoi(argv[1]);
	}

	while(1) {

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;
		if (buffer[0]=='#') continue;
		sscanf(buffer,"%d %d %d %d %d",
			&a1,&a2,&a3,&a4,&a5);
		printf("%d %d %d %d %d\n",a1,a2,a3,a4,a5);
		if (a1==279) {
			output[out_ptr]=(a1/3)+add;
			output[out_ptr+1]=(a2/3)+add;
			output[out_ptr+2]=(a3/3)+add;
			output[out_ptr+3]=(a4/3)+add;
			output[out_ptr+4]=(a5/3)+add;
			out_ptr+=5;
		}
		else if (a1==0) {
			output[out_ptr]=(a1/3)+add;
			out_ptr+=1;
			break;
		}
		else {
			output[out_ptr]=(a1/3)+add;
			output[out_ptr+1]=(a2/3)+add;
			out_ptr+=2;
		}
	}
	output[out_ptr]=0;
	printf("%s\n",output);

	return 0;
}
