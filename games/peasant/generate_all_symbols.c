#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>



static FILE *fff;


static void dump_addresses(int routine_offset) {

	unsigned int addr=0;
	char string[BUFSIZ],*result;
	char temp_name[BUFSIZ];

	while(1) {

		result=fgets(string,BUFSIZ,fff);
		if (result==NULL) {
			return;
		}

		sscanf(string,"%x%*c %*d %s",&addr,temp_name);

	//	fprintf(stderr,"%s %x\n",temp_name,addr);

		if (temp_name[strlen(temp_name)-1]==':') {
			temp_name[strlen(temp_name)-1]=0;
			printf("%s\t=$%04x\n",temp_name,addr+routine_offset);
		}
	}

}

int main(int argc, char **argv) {

	int c;
	char *filename;
	int routine_offset=0xd000;

	while ( (c=getopt(argc, argv, "a:s:") ) != -1) {

		switch(c) {

			case 'a':
				routine_offset=strtol(optarg, NULL, 0);
                                break;
			default:
				fprintf(stderr,"Unknown option %c\n",c);
				exit(-1);
                                break;
		}
	}

	filename=strdup(argv[optind]);

	fff=fopen(filename,"r");
	if (fff==NULL) {
		fprintf(stderr,"ERROR!  could not open %s\n",filename);
		return -1;
	}

	dump_addresses(routine_offset);

	fclose(fff);

	return 0;
}
