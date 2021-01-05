#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

#define COLUMNS 40
#define ROWS 48

static short addresses[]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};

static unsigned char image[1024];

static int color(int i,int j) {

	int x,y,c;

	y=addresses[j/2]-0x400;
	x=i;

	if (j%2==0) {
		c=image[y+x]&0xf;
	}
	else {
		c=((image[y+x])>>4)&0xf;
	}

	return c;
}

int main(int argc, char **argv) {

	int i,j,fd,addr=0,max;
	char *filename;

	if (argc<2) {
		filename=strdup("chiptune.gr");
	}
	else {
		filename=strdup(argv[1]);
	}

	fd=open(filename,O_RDONLY);
	if (fd<0) {
		printf("Error operning %s\n",filename);
		return -1;
	}
	read(fd,&image,1024);
	close(fd);

//	printf("\\documentclass{article}\n");
//	printf("\\usepackage{graphicx}\n");
//	printf("\\usepackage{colortbl}\n");
//	printf("\\begin{document}\n");

	/* First plot, interleaved */

	printf("\\tabcolsep=0.11cm\n");
	printf("\\renewcommand{\\arraystretch}{0.5}\n");

	printf("\\begin{tiny}\n");
	printf("\\begin{table*}\n");

	printf("\\caption{Apple II lores display, 40x48.  "
		"Note the interleaving of the row addresses.  "
		"Rows 40-47 are ASCII text being interpreted as graphic blocks.\\label{table:loresmap}}\n");
	printf("\\centering\n");
	printf("\\begin{tabular}{|l|l|");
	for(i=0;i<COLUMNS;i++) printf("c|");
	printf("}\n");

	printf("\\hline\n");

	printf("& &");
	for(i=0;i<COLUMNS;i++) {
		printf("\\rot{\\tt \\$%02X} ",i);
		if (i<COLUMNS-1) printf("&");
	}
	printf("\\\\\n");
	printf("\\hline\n");

	printf("& &");
	for(i=0;i<COLUMNS;i++) {
		printf("\\rot{%d} ",i);
		if (i<COLUMNS-1) printf("&");
	}
	printf("\\\\\n");



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
			printf("\\cellcolor{color%d}",
				color(i,j));
			if (i<COLUMNS-1) printf("&");
			else printf("\\\\\n");
		}
	}
	printf("\\hline\n");
	printf("\\end{tabular}\n");
	printf("\\end{table*}\n");
	printf("\\end{tiny}\n");


	/* Second plot, this one showing non-interleaved */

	printf("\\begin{tiny}\n");
	printf("\\begin{table*}\n");

	printf("\\caption{Apple II lores raw memory if viewed linearly. "
		"Note the screen ``holes'' which pad every third line to a 128 "
		"byte boundary.  This unused memory can be used by I/O cards. "
		"\\label{table:linear}}\n");
	printf("\\centering\n");
	printf("\\begin{tabular}{|l|l|");
	for(i=0;i<COLUMNS+8;i++) printf("c|");
	printf("}\n");

//	printf("\\hline\n");

	addr=0x400;

	for(j=0;j<ROWS;j++) {
		if (j%2==0) {
			printf("\\hline\n");
			printf("\\multirow{2}{*}{\\tt \\$%3X} &",
					addr);
		}
		else {
			printf("\\cline{2-42}\n");
			printf("&");
		}

		printf("%d &",j);

		if ((j/2)%3==2) {
			max=COLUMNS+8;
		}
		else {
			max=COLUMNS;
		}

		for(i=0;i<max;i++) {
			if (j%2==0) {
				printf("\\cellcolor{color%d}",
					image[(addr-0x400)+i]&0xf);
			}
			else {
				printf("\\cellcolor{color%d}",
					(image[(addr-0x400)+i]>>4)&0xf);

			}
			if (i<max-1) printf("&");
			else printf("\\\\\n");
		}

		if ((j%6)==1) {
			addr+=40;
		}
		else if ((j%6)==3) {
			addr+=40;
		}
		else if ((j%6)==5) {
			addr+=40+8;
		}

	}
	printf("\\hline\n");
	printf("\\end{tabular}\n");
	printf("\\end{table*}\n");
	printf("\\end{tiny}\n");


//	printf("\\end{document}\n");

	return 0;

}
