#include <stdio.h>
#include <string.h>

#if 0
	/* old, loader.s */
	static char filename[]="loader.lst";
	static int routine_offset=0x1000;
#else
	/* new, qload */
	static char filename[]="qload.lst";
	static int routine_offset=0x1200;
#endif


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

	printf("; linking_noise.s\n");
	find_address("play_link_noise");
	printf("\n");

	printf("; decompress_fast_v2.s\n");
	find_address("decompress_lzsa2_fast");
	find_address("getsrc_smc");
	printf("\n");

	printf("; draw_pointer.s\n");
	find_address("draw_pointer");
	printf("\n");

	printf("; end_level.s\n");
	find_address("end_level");
	printf("\n");

	printf("; gr_copy.s\n");
	find_address("gr_copy_to_current");
	printf("\n");

	printf("; gr_fast_clear.s\n");
	find_address("clear_bottom");
	find_address("clear_all");
	find_address("clear_all_color");
	printf("\n");

	printf("; gr_offsets.s\n");
	find_address("gr_offsets");
	printf("\n");

	printf("; gr_page_flip.s\n");
	find_address("page_flip");
	printf("\n");

	printf("; gr_putsprite_crop.s\n");
	find_address("put_sprite_crop");
	find_address("psc_smc1");
	find_address("psc_smc2");
	printf("\n");

	printf("; keyboard.s\n");
	find_address("handle_keypress");
	find_address("change_direction");
	find_address("change_location");
	printf("\n");

	printf("; text_print.s\n");
	find_address("move_and_print");
	find_address("ps_smc1");
	printf("\n");

	printf("; page_sprites.inc\n");
	find_address("blue_page_sprite");
	find_address("red_page_sprite");
	find_address("white_page_sprite");
	find_address("blue_page_small_sprite");
	find_address("red_page_small_sprite");
	printf("\n");

//	printf("; audio files\n");
//	printf("linking_noise	= $9000\n");
//	printf("LINKING_NOISE_LENGTH = 43\n");

	fclose(fff);

	return 0;
}
