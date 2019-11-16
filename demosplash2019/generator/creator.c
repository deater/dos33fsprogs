#include <stdio.h>

int main(int argc, char **argv) {

	int i,j,page=0;

	for(i=0;i<192;i++) {
		printf("\n; Line %d\n",i);
		printf("\tbit\tPAGE%d\t;4\n",page);
		printf("\tlda\t#$0b\t; 2\n");
		for(j=0;j<14;j++) {
			printf("\tsta\t$200\t; 4\n");
		}
		printf("\tlda\tTEMP\t; 3\n");
		page=!page;
	}
	return 0;
}
