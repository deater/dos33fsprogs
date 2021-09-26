#include <stdio.h>
#include <string.h>

/* music */
static char filename[]="music.lst";
static int routine_offset=0xD000;


static FILE *fff;


static void find_address(char *symbol_name) {

	unsigned int addr=0;
	char string[BUFSIZ],*result;
	char temp_name[BUFSIZ];

	sprintf(temp_name,"%s:",symbol_name);

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

	fff=fopen(filename,"r");
	if (fff==NULL) {
		fprintf(stderr,"ERROR!  could not open %s\n",filename);
		return -1;
	}

	printf(";=============================\n");
	printf("; external routines\n");
	printf("\n");

//	printf("; loader.s\n");
//	find_address("opendir_filename");
//	printf("\n");

//	printf("; audio.s\n");
//	find_address("play_audio");
//	printf("\n");

	printf(";\n");
	find_address("pt3_init_song");
	printf("\n");

	printf(";\n");
	find_address("mockingboard_init");
	printf("\n");

	printf(";\n");
	find_address("reset_ay_both");
	printf("\n");

	printf(";\n");
	find_address("clear_ay_both");
	printf("\n");

	printf(";\n");
	find_address("mockingboard_setup_interrupt");
	printf("\n");

	printf(";\n");
	find_address("mockingboard_disable_interrupt");
	printf("\n");

	printf(";\n");
	find_address("done_pt3_irq_handler");
	printf("\n");

	printf(";\n");
	find_address("PT3_LOC");
	printf("\n");

	fclose(fff);

	return 0;
}
