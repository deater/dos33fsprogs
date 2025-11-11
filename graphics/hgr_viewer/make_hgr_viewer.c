/* TODO: bail if will over-write files */


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX_FILES	1024

static char *png_filenames[MAX_FILES];
static char *zx02_filenames[MAX_FILES];
static char *labels[MAX_FILES];
static char *author_names[MAX_FILES];


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
	char temp_author[BUFSIZ];
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
		strcpy(filename_base,"hires_plain");
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

		count=sscanf(string,"%s %s %s %s",temp_label,temp_zx02,temp_png,temp_author);
		if ((count!=3) && (count!=4)) {
			fprintf(stderr,"WARNING! weird input line %d (%d)\n",line,count);
			fprintf(stderr,"\t%s",string);
		}
		else {
			labels[num_files]=strdup(temp_label);
			png_filenames[num_files]=strdup(temp_png);
			zx02_filenames[num_files]=strdup(temp_zx02);

			if (count==4) {
				if (temp_author[0]!='\'') {
					fprintf(stderr,"ERROR! Weird author name line %d!\n",line);
				}
				author_names[num_files]=strdup(temp_author+1);
			}
			else {
				author_names[num_files]=strdup(" ");
			}
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
	fprintf(sss,".include \"../hires_main.s\"\n\n");
	fprintf(sss,"MAX_FILES = %d\n\n",num_files);

	/* filename pointers */

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


	/* author pointers */

	fprintf(sss,"authors_low:\n");
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t.byte <%s_author\n",labels[i]);
	}
	fprintf(sss,"\n");

	fprintf(sss,"authors_high:\n");
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t.byte >%s_author\n",labels[i]);
	}
	fprintf(sss,"\n");

	/* filename data */

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


	/* author data */

	fprintf(sss,"; author is up to 20-character Apple text:\n");

	for(i=0;i<num_files;i++) {
		fprintf(sss,"%s_author:\t; %s\n",labels[i],author_names[i]);
		fprintf(sss,"\t.byte ");

		if (strlen(author_names[i])==0) {
			fprintf(sss,"\'%c\'|$80",' ');
		}
		else for(j=0;j<strlen(author_names[i]);j++) {
			if (j!=0) fprintf(sss,",");
			fprintf(sss,"\'%c\'|$80",author_names[i][j]);
		}
		fprintf(sss,",$00\n\n");
	}


	/* close it up */


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
	fprintf(sss,"PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr\n");
	fprintf(sss,"LINKER_SCRIPTS = ../../../linker_scripts\n");
	fprintf(sss,"DOS33 = ../../../utils/dos33fs-utils/dos33\n");
	fprintf(sss,"EMPTY_DISK = ../../../empty_disk/empty.dsk\n");
	fprintf(sss,"TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft\n");

	fprintf(sss,"\n");

	fprintf(sss,"all:\t%s.dsk\n\n",filename_base);

	fprintf(sss,"####\n\n");

	fprintf(sss,"HIRES:\t%s.o\n",filename_base);
	fprintf(sss,"\tld65 -o HIRES %s.o -C $(LINKER_SCRIPTS)/apple2_6000.inc\n\n",filename_base);

	fprintf(sss,"%s.o:\t%s.s ../hires_main.s ../zx02_optim.s \\\n",filename_base,filename_base);
	fprintf(sss,"\t\t../zp.inc ../hardware.inc\n");
	fprintf(sss,"\tca65 -o %s.o %s.s -l %s.lst\n",filename_base,filename_base,filename_base);

	fprintf(sss,"####\n\n");

	fprintf(sss,"HELLO:\t../hello.bas\n");
	fprintf(sss,"\t$(TOKENIZE) < ../hello.bas > HELLO\n\n");

	fprintf(sss,"####\n\n");

	fprintf(sss,"%s.dsk:\tHELLO HIRES\\\n",filename_base);
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t\t%s.hgr.zx02",png_filenames[i]);
		if (i!=(num_files-1)) {
			fprintf(sss,"\\");
		}
		fprintf(sss,"\n");
	}
	fprintf(sss,"\tcp $(EMPTY_DISK) %s.dsk\n",filename_base);
	fprintf(sss,"\t$(DOS33) -y %s.dsk SAVE A HELLO\n",filename_base);
	fprintf(sss,"\t$(DOS33) -y %s.dsk BSAVE -a 0x6000 HIRES\n",filename_base);
	for(i=0;i<num_files;i++) {
		fprintf(sss,"\t$(DOS33) -y %s.dsk BSAVE -a 0xa000 %s.hgr.zx02 %s\n",
			filename_base,
			png_filenames[i],zx02_filenames[i]);
	}

//	fprintf(sss,"####\n\n");
//	fprintf(sss,"clean:\n");
//	fprintf(sss,"\trm -f *~ *.o *.lst *.hgr *.zx02\n\n");


//	fclose(sss);


	/******************************************/
	/* generate Makefile.graphics             */
	/******************************************/

//	sss=fopen("Makefile.graphics","w");
//	if (sss==NULL) {
//		fprintf(stderr,"ERRROR opening Makefile\n");
//		exit(-1);
//	}

//	fprintf(sss,"include ../../../Makefile.inc\n\n");
//	fprintf(sss,"ZX02 = ~/research/6502_compression/zx02.git/build/zx02\n");
//	fprintf(sss,"PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr\n");
//	fprintf(sss,"LINKER_SCRIPTS = ../../../linker_scripts\n");
//	fprintf(sss,"DOS33 = ../../../utils/dos33fs-utils/dos33\n");
//	fprintf(sss,"EMPTY_DISK = ../../../empty_disk/empty.dsk\n");
//	fprintf(sss,"TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft\n");

//	fprintf(sss,"\n");

//	fprintf(sss,"all:\\\n");
//	for(i=0;i<num_files;i++) {
//		fprintf(sss,"\t\t%s.hgr.zx02",png_filenames[i]);
//		if (i!=(num_files-1)) {
//			fprintf(sss,"\\");
//		}
//		fprintf(sss,"\n");
//	}
//	fprintf(sss,"\tcp $(EMPTY_DISK) %s.dsk\n",filename_base);
//	fprintf(sss,"\t$(DOS33) -y %s.dsk SAVE A HELLO\n",filename_base);
//	fprintf(sss,"\t$(DOS33) -y %s.dsk BSAVE -a 0x0c00 HIRES\n",filename_base);
//	for(i=0;i<num_files;i++) {
//		fprintf(sss,"\t$(DOS33) -y %s.dsk BSAVE -a 0xa000 %s.hgr.zx02 %s\n",
//			filename_base,
//			png_filenames[i],zx02_filenames[i]);
//	}


	for(i=0;i<num_files;i++) {

		fprintf(sss,"\n####\n\n");
		fprintf(sss,"%s.hgr.zx02:\t%s.hgr\n",png_filenames[i],png_filenames[i]);
		fprintf(sss,"\t$(ZX02) %s.hgr %s.hgr.zx02\n",png_filenames[i],png_filenames[i]);
		fprintf(sss,"\n");
		fprintf(sss,"%s.hgr:\t%s.png\n",png_filenames[i],png_filenames[i]);
		fprintf(sss,"\t$(PNG_TO_HGR) %s.png > %s.hgr\n",png_filenames[i],png_filenames[i]);
		fprintf(sss,"\n");
	}

	fprintf(sss,"####\n\n");
	fprintf(sss,"clean:\n");
	fprintf(sss,"\trm -f *~ *.o *.lst *.hgr *.zx02 HELLO HIRES %s.dsk\n\n",
		filename_base);


//	fprintf(sss,"####\n\n");
//	fprintf(sss,"clean:\n");
//	fprintf(sss,"\trm -f *~ *.o *.lst *.hgr *.zx02\n\n");

	fclose(sss);

	return 0;
}
