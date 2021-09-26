#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>



static FILE *fff;


static void find_address(char *symbol_name, int routine_offset) {

	unsigned int addr=0;
	char string[BUFSIZ],*result;
	char temp_name[BUFSIZ];

	strncpy(temp_name,symbol_name,BUFSIZ);
	strncat(temp_name,":",2);

	while(1) {

		result=fgets(string,BUFSIZ,fff);
		if (result==NULL) break;

		result=strstr(string,temp_name);
		if (result!=NULL) {
			string[6]=0;
			sscanf(string,"%x",&addr);
			break;
		}
	}


	printf("%s\t=$%04x\n",symbol_name,addr+routine_offset);
}

int main(int argc, char **argv) {

	int c;
	char *filename;
	char symbol[BUFSIZ];
	int routine_offset=0xd000;

	while ( (c=getopt(argc, argv, "a:s:") ) != -1) {

		switch(c) {

			case 'a':
				routine_offset=strtol(optarg, NULL, 0);
                                break;
			case 's':
				strncpy(symbol,optarg,BUFSIZ-1);
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

	find_address(symbol,routine_offset);

	fclose(fff);

	return 0;
}
