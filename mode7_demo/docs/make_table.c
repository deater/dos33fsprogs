#include <stdio.h>

#define COLUMNS 40
#define ROWS 48

static short addresses[]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};


int main(int argc, char **argv) {

	int i,j;

//	printf("\\documentclass{article}\n");
//	printf("\\usepackage{graphicx}\n");
//	printf("\\usepackage{colortbl}\n");
//	printf("\\begin{document}\n");

	printf("\\tabcolsep=0.11cm\n");
	printf("\\renewcommand{\\arraystretch}{0.5}\n");
	printf("\\begin{tiny}\n");

	printf("\\begin{table*}\n");

	printf("\\caption{Sample lores map \\label{table:loresmap}}\n");
	printf("\\centering\n");
	printf("\\begin{tabular}{|l|l|");
	for(i=0;i<COLUMNS;i++) printf("c|");
	printf("}\n");

	for(j=0;j<ROWS;j++) {
		if (j%2==0) {
			printf("\\hline\n");
			printf("\\multirow{2}{*}{\\tt \\$%3X} &",
					addresses[j/2]);
		}
		else {
			printf("\\cline{2-42}\n");
			printf("&");
		}

		printf("%d &",j);

		for(i=0;i<COLUMNS;i++) {
			printf("\\cellcolor{red}");
			if (i<COLUMNS-1) printf("&");
			else printf("\\\\\n");
		}
	}
	printf("\\hline\n");
	printf("\\end{tabular}\n");
	printf("\\end{table*}\n");
	printf("\\end{tiny}\n");
//	printf("\\end{document}\n");

	return 0;

}
