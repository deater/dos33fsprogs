/* TODO: bail if will over-write files */


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX_FILES	1024

static char *png_filenames[MAX_FILES];
static char *zx02_filenames[MAX_FILES];
static char *labels[MAX_FILES];

/* Format:

file_label FILE.ZX02 file.png

*/

int main(int argc, char **argv) {

	char *result;
	char string[BUFSIZ];
	int num_files=0;
	int i,j,count,line=0;
	char temp_png[BUFSIZ];
	char temp_zx02[BUFSIZ];
	char temp_label[BUFSIZ];
	char s_filename[BUFSIZ];
	char filename_base[BUFSIZ];

	FILE *sss;

	/******************************************/
	/* parse command line                     */
	/******************************************/

	if (argc>1) {
		strcpy(filename_base,argv[1]);
	}
	else {
		strcpy(filename_base,"lores_plain");
	}
	sprintf(s_filename,"%s.s",filename_base);

	/******************************************/
	/* scan in data                           */
	/******************************************/

	while(1) {
		line++;
		result=fgets(string,BUFSIZ,stdin);
		if (result==NULL) {
			break;
		}
		if (result[0]=='#') continue;

		count=sscanf(string,"%s %s %s",temp_label,temp_zx02,temp_png);
		if (count!=3) {
			fprintf(stderr,"WARNING! weird input line %d (%d)\n",line,count);
			fprintf(stderr,"\t%s",string);
		}
		else {
			labels[num_files]=strdup(temp_label);
			png_filenames[num_files]=strdup(temp_png);
			zx02_filenames[num_files]=strdup(temp_zx02);

			num_files++;
			if (num_files>=MAX_FILES) {
				fprintf(stderr,"ERROR!  Too many files!\n");
				exit(-1);
			}
		}
	}

	if (num_files==0) {
		fprintf(stderr,"ERROR!  No files found!\n");
		exit(-1);
	}

	/******************************************/
	/* generate S file                        */
	/******************************************/

	sss=fopen(s_filename,"w");
	if (sss==NULL) {
		fprintf(stderr,"ERRROR opening %s\n",s_filename);
		exit(-1);
	}


	fprintf(sss,"; Some nice hires images\n\n");
	fprintf(sss,".include \"../lores_main.s\"\n\n");
	fprintf(sss,"MAX_FILES = %d\n\n",num_files);

	fprintf(sss,"filenames_low:\n");
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t.byte <%s_filename\n",labels[i]);
	}
	fprintf(sss,"\n");

	fprintf(sss,"filenames_high:\n");
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t.byte >%s_filename\n",labels[i]);
	}
	fprintf(sss,"\n");

	fprintf(sss,"; filename to open is 30-character Apple text:\n");

	for(i=0;i<num_files;i++) {
		fprintf(sss,"%s_filename:\t; %s\n",labels[i],zx02_filenames[i]);
		fprintf(sss,"\t.byte ");
		for(j=0;j<strlen(zx02_filenames[i]);j++) {
			if (j!=0) fprintf(sss,",");
			fprintf(sss,"\'%c\'|$80",zx02_filenames[i][j]);
		}
		fprintf(sss,",$00\n\n");
	}
	fclose(sss);


	/******************************************/
	/* generate Makefile                      */
	/******************************************/

	/* don't over-write as a precaution */
	if (access("Makefile", F_OK) == 0) {
		fprintf(stderr,"Makefile already exists!  Out of caution giving up.\n");
		exit(-1);
	}

	sss=fopen("Makefile","w");
	if (sss==NULL) {
		fprintf(stderr,"ERRROR opening Makefile\n");
		exit(-1);
	}

	fprintf(sss,"include ../../../Makefile.inc\n\n");
	fprintf(sss,"ZX02 = ~/research/6502_compression/zx02.git/build/zx02\n");
	fprintf(sss,"PNG_TO_GR = ../../../utils/gr-utils/png2gr\n");
	fprintf(sss,"LINKER_SCRIPTS = ../../../linker_scripts\n");
	fprintf(sss,"DOS33 = ../../../utils/dos33fs-utils/dos33\n");
	fprintf(sss,"EMPTY_DISK = ../../../empty_disk/empty.dsk\n");
	fprintf(sss,"TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft\n");

	fprintf(sss,"\n");

	fprintf(sss,"all:\t%s.dsk\n\n",filename_base);

	fprintf(sss,"####\n\n");

	fprintf(sss,"LORES:\t%s.o\n",filename_base);
	fprintf(sss,"\tld65 -o LORES %s.o -C $(LINKER_SCRIPTS)/apple2_1000.inc\n\n",filename_base);

	fprintf(sss,"%s.o:\t%s.s ../lores_main.s ../zx02_optim.s \\\n",filename_base,filename_base);
	fprintf(sss,"\t\t../zp.inc ../hardware.inc\n");
	fprintf(sss,"\tca65 -o %s.o %s.s -l %s.lst\n",filename_base,filename_base,filename_base);

	fprintf(sss,"####\n\n");

	fprintf(sss,"HELLO:\t../hello.bas\n");
	fprintf(sss,"\t$(TOKENIZE) < ../hello.bas > HELLO\n\n");

	fprintf(sss,"####\n\n");

	fprintf(sss,"%s.dsk:\tHELLO LORES\\\n",filename_base);
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t\t%s.gr.zx02",png_filenames[i]);
		if (i!=(num_files-1)) {
			fprintf(sss,"\\");
		}
		fprintf(sss,"\n");
	}
	fprintf(sss,"\tcp $(EMPTY_DISK) %s.dsk\n",filename_base);
	fprintf(sss,"\t$(DOS33) -y %s.dsk SAVE A HELLO\n",filename_base);
	fprintf(sss,"\t$(DOS33) -y %s.dsk BSAVE -a 0x1000 LORES\n",filename_base);
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t$(DOS33) -y %s.dsk BSAVE -a 0xa000 %s.gr.zx02 %s\n",
			filename_base,
			png_filenames[i],zx02_filenames[i]);
	}

	fprintf(sss,"####\n\n");
	fprintf(sss,"clean:\n");
	fprintf(sss,"\trm -f *~ *.o *.lst\n\n");
	fclose(sss);


	/******************************************/
	/* generate Makefile.graphics             */
	/******************************************/

	sss=fopen("Makefile.graphics","w");
	if (sss==NULL) {
		fprintf(stderr,"ERRROR opening Makefile\n");
		exit(-1);
	}

	fprintf(sss,"include ../../../Makefile.inc\n\n");
	fprintf(sss,"ZX02 = ~/research/6502_compression/zx02.git/build/zx02\n");
	fprintf(sss,"PNG_TO_GR = ../../../utils/gr-utils/png2gr\n");
	fprintf(sss,"LINKER_SCRIPTS = ../../../linker_scripts\n");
	fprintf(sss,"DOS33 = ../../../utils/dos33fs-utils/dos33\n");
	fprintf(sss,"EMPTY_DISK = ../../../empty_disk/empty.dsk\n");
	fprintf(sss,"TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft\n");

	fprintf(sss,"\n");

	fprintf(sss,"all:\\\n");
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t\t%s.gr.zx02",png_filenames[i]);
		if (i!=(num_files-1)) {
			fprintf(sss,"\\");
		}
		fprintf(sss,"\n");
	}
//	fprintf(sss,"\tcp $(EMPTY_DISK) %s.dsk\n",filename_base);
//	fprintf(sss,"\t$(DOS33) -y %s.dsk SAVE A HELLO\n",filename_base);
//	fprintf(sss,"\t$(DOS33) -y %s.dsk BSAVE -a 0x0c00 LORES\n",filename_base);
//	for(i=0;i<num_files;i++) {
//		fprintf(sss,"\t$(DOS33) -y %s.dsk BSAVE -a 0xa000 %s.gr.zx02 %s\n",
//			filename_base,
//			png_filenames[i],zx02_filenames[i]);
//	}


	for(i=0;i<num_files;i++) {

		fprintf(sss,"\n####\n\n");
		fprintf(sss,"%s.gr.zx02:\t%s.gr\n",png_filenames[i],png_filenames[i]);
		fprintf(sss,"\t$(ZX02) %s.gr %s.gr.zx02\n",png_filenames[i],png_filenames[i]);
		fprintf(sss,"\n");
		fprintf(sss,"%s.gr:\t%s.png\n",png_filenames[i],png_filenames[i]);
		fprintf(sss,"\t$(PNG_TO_GR) %s.png %s.gr\n",png_filenames[i],png_filenames[i]);
		fprintf(sss,"\n");
	}

	fprintf(sss,"####\n\n");
	fprintf(sss,"clean:\n");
	fprintf(sss,"\trm -f *~ *.o *.lst\n\n");

	fclose(sss);

	return 0;
}
