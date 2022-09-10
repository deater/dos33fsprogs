#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	char buffer[1024];
	char *ptr;
	int color,x1,x2,y1,y2;
	char output[1024];
	int out_ptr=0;
	int add=' ';

	if (argc>1) {
		add=atoi(argv[1]);
	}

	while(1) {

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;

		if (buffer[0]==';') continue;

		if (sscanf(buffer,"%d %d %d %d %d",
			&color,&x1,&x2,&y1,&y2)!=5) continue;

		output[out_ptr]=color+add;
		output[out_ptr+1]=x1+add;
		output[out_ptr+2]=x2+add;
		output[out_ptr+3]=y1+add;
		output[out_ptr+4]=y2+add;
		out_ptr+=5;
	}
	output[out_ptr]=0;
	printf("%s\n",output);

	return 0;
}
