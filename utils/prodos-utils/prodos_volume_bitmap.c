#include <stdio.h>

#include "prodos.h"

extern int debug;

/* Note: PRODOS seems to label things this way */
/* block  0123 4567	*/
/* 0x0f = 0000 1111	*/

static int ones_lookup[16]={
	/* 0x0 = 0000 */ 0,
	/* 0x1 = 0001 */ 1,
	/* 0x2 = 0010 */ 1,
	/* 0x3 = 0011 */ 2,
	/* 0x4 = 0100 */ 1,
	/* 0x5 = 0101 */ 2,
	/* 0x6 = 0110 */ 2,
	/* 0x7 = 0111 */ 3,
	/* 0x8 = 1000 */ 1,
	/* 0x9 = 1001 */ 2,
	/* 0xA = 1010 */ 2,
	/* 0xB = 1011 */ 3,
	/* 0xC = 1100 */ 2,
	/* 0xD = 1101 */ 3,
	/* 0xE = 1110 */ 3,
	/* 0xF = 1111 */ 4,
};

	/* could be replaced by "find leading 1" instruction */
	/* Note we are reverse from usual, wanting MSB first */
	/* if available                                      */
static int find_first_one(unsigned char byte) {

	int i=0;

	if (byte==0) return -1;

	while((byte & (0x80>>i))==0) {
		i++;
	}
	return i;
}


/* Return how many bytes free in the filesystem */
/* by reading the VTOC_FREE_BITMAP */
int prodos_voldir_free_space(struct voldir_t *voldir) {

	int volblocks;
	unsigned char temp_block[PRODOS_BYTES_PER_BLOCK];
	int i,j,blocks_free=0;

	volblocks=1+voldir->total_blocks/(PRODOS_BYTES_PER_BLOCK*8);

	for(j=0;j<volblocks;j++) {
		prodos_read_block(voldir,temp_block,j+voldir->bit_map_pointer);

		for(i=0;i<PRODOS_BYTES_PER_BLOCK;i++) {
			blocks_free+=ones_lookup[temp_block[i]&0xf];
			blocks_free+=ones_lookup[(temp_block[i]>>4)&0xf];
		}
	}

	return blocks_free;
}

/* free a block from the block bitmap */
int prodos_voldir_free_block(struct voldir_t *voldir, int block) {

	/* each volblock holds 512*8=4k entries */
	/* block location = block%4096 */
	/* which byte=remainder/8 */

	int volblock;
	unsigned char temp_block[PRODOS_BYTES_PER_BLOCK];
	unsigned char bitmap;
	int which_bitmap;

	volblock=block/(PRODOS_BYTES_PER_BLOCK*8);

	prodos_read_block(voldir,temp_block,volblock+voldir->bit_map_pointer);

	which_bitmap=(block%(PRODOS_BYTES_PER_BLOCK*8))/8;

	bitmap=temp_block[which_bitmap];

	if (debug) {
		printf("Free: $%X Using volblock %d (%d), flip b[%d]#%d $%X ",
			block,volblock,volblock+voldir->bit_map_pointer,
			which_bitmap,block&7,bitmap);
	}

	/* set bit to 1 to mark free */
	bitmap|=(0x80>>(block&7));

	if (debug) {
		printf("-> $%X\n",bitmap);
	}

	temp_block[which_bitmap]=bitmap;

	prodos_write_block(voldir,temp_block,volblock+voldir->bit_map_pointer);

	return 0;
}

/* reserve a block in the block bitmap */
int prodos_voldir_reserve_block(struct voldir_t *voldir, int block) {

	/* each volblock holds 512*8=4k entries */
	/* block location = block%4096 */
	/* which byte=remainder/8 */

	int volblock;
	unsigned char temp_block[PRODOS_BYTES_PER_BLOCK];
	unsigned char bitmap;
	int which_bitmap;

	volblock=block/(PRODOS_BYTES_PER_BLOCK*8);

	prodos_read_block(voldir,temp_block,volblock+voldir->bit_map_pointer);

	which_bitmap=(block%(PRODOS_BYTES_PER_BLOCK*8))/8;

	bitmap=temp_block[which_bitmap];

	if (debug) {
		printf("Reserve: $%X Using volblock %d (%d), flip b[%d]#%d $%X ",
			block,volblock,volblock+voldir->bit_map_pointer,
			which_bitmap,block&7,bitmap);
	}

	/* clear bit to 0 to mark used */
	bitmap&=~(0x80>>(block&7));

	if (debug) {
		printf("-> $%X\n",bitmap);
	}

	temp_block[which_bitmap]=bitmap;

	prodos_write_block(voldir,temp_block,volblock+voldir->bit_map_pointer);

	return 0;
}


void prodos_voldir_dump_bitmap(struct voldir_t *voldir) {

	int volblocks;
	unsigned char temp_block[PRODOS_BYTES_PER_BLOCK];
	int i,j,k;

	volblocks=1+voldir->total_blocks/(PRODOS_BYTES_PER_BLOCK*8);

	for(k=0;k<volblocks;k++) {

		printf("\nFree block bitmap Block %d (block %d/%d):\n",
			k+voldir->bit_map_pointer,k+1,volblocks);
		printf("\tU=used, .=free\n");
		printf("\tBlock          01234567 89ABCDEF\n");

		prodos_read_block(voldir,temp_block,k+voldir->bit_map_pointer);

		for(i=0;i<(512/16);i++) {
			printf("\t $%03X: %02X %02X : ",i,
				temp_block[(i*2)],
				temp_block[(1+i*2)]);
			for(j=0;j<8;j++) {
				if ((temp_block[i*2]>>(7-j))&0x1) {
					printf(".");
				}
				else {
					printf("U");
				}
			}
			printf(" ");
			for(j=0;j<8;j++) {
				if ((temp_block[(1+i*2)]>>(7-j))&0x1) {
					printf(".");
				}
				else {
					printf("U");
				}
			}
			printf("\n");
		}
	}
}


/* find a free block in the block bitmap */
/* FIXME: for speed, remember last found block and start from there */
int prodos_voldir_find_free_block(struct voldir_t *voldir) {

	int volblocks;
	unsigned char temp_block[PRODOS_BYTES_PER_BLOCK];
	int i,k,result;

	volblocks=1+voldir->total_blocks/(PRODOS_BYTES_PER_BLOCK*8);

	for(k=0;k<volblocks;k++) {

		prodos_read_block(voldir,temp_block,k+voldir->bit_map_pointer);

		for(i=0;i<(512/16);i++) {
			result=find_first_one(temp_block[i*2]);
			if (result>=0) {
				return (k<<4)+result;
			}
			result=find_first_one(temp_block[(1+i*2)]);
			if (result>=0) {
				return (k<<4)+result+8;
			}
		}
	}

	/* no room */
        return -1;

}
