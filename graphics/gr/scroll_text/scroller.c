#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

static unsigned char font[256][9]={
	{0,0,0,0,0,0,0,0,0},	// 0
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},	// 8
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},	// 16
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},	// 24
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{4,0,0,0,0,0,0,0,0},	// 32 ' '
	{4,
		0x00,
		0xe0,		// ******
		0xe0,		// ******
		0x40,		//   **
		0x40,		//   **
		0x00,		//
		0x40,		//   **
		0x40,		//   **
	},
	{0,0,0,0,0,0,0,0,0},	// 34
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},	// 40
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},

	{2,
		0x00,
		0x00,	//
		0x00,	//
		0x00,	//
		0x00,	//
		0x00,	//
		0x80,	//  **
		0x80,	//  **
	},

	{0,0,0,0,0,0,0,0,0},
	{4,			// 48
		0x00,
		0x40,	//   **
		0xa0,	// **  **
		0xa0,	// **  **
		0xa0,	// **  **
		0xa0,	// **  **
		0xa0,	// **  **
		0x40,	//   **

	},
	{4,
		0x00,
		0x40,	//   **
		0xc0,	// ****
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0xe0,	// ******
	},
	{4,
		0x00,
		0x40,	//   **
		0xa0,	// **  **
		0x20,	//     **
		0x40,	//   **
		0x40,	//   **
		0x80,	// **
		0xe0,	// ******
	},
	{4,
		0x00,
		0xC0, // ****
		0x20, //     **
		0x20, //     **
		0x40, //   **
		0x20, //     **
		0x20, //     **
		0xC0, // ****
	},
/*
**  **  ******    ****  ******
**  **  **      **          **
**  **  **      **          **
******  ****    ****      **  
    **      **  **  **    **  
    **      **  **  **    **  
    **  ****      **      **  
*/


	{4,0,0,0,0,0,0,0,0},
	{4,0,0,0,0,0,0,0,0},
	{4,0,0,0,0,0,0,0,0},
	{4,0,0,0,0,0,0,0,0},
	{4,		// 56
		0x00,
		0x40,	//     **
		0xa0,	//   **  **
		0xa0,	//   **  **
		0x40,	//     **
		0xa0,	//   **  **
		0xa0,	//   **  **
		0x40,	//     **
	},
	{4,
		0x00,
		0x60,	//     ****
		0xc0,	//   **  **
		0xc0,	//   **  **
		0x60,	//     ****
		0x20,	//       **
		0x20,	//	 **
		0x20,	//       **
	},
	{3,
		0x00,
		0x00,	//
		0x80,	//     **
		0x80,	//     **
		0x00,	//
		0x80,	//     **
		0x80,	//     **
		0x00,	//
	},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},	//64
	{5,
		0x00,
		0x60,	//    ****
		0x90,	//  **    **
		0x90,	//  **    **
		0xf0,	//  ********
		0x90,	//  **    **
		0x90,	//  **    **
		0x90,	//  **    **
	},
	{5,
		0x00,
		0xe0,	// ******
		0x90,	// **    **
		0x90,	// **    **
		0xe0,	// ******
		0x90,	// **    **
		0x90,	// **    **
		0xe0,	// ******
	},
	{5,
		0x00,
		0x70,	//   ******
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0x70,   //   ******
	},
	{5,
		0x00,
		0xc0,	// ****
		0xa0,	// **  **
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0xa0,	// **  **
		0xc0,	// ****
	},
	{5,
		0x00,
		0xf0,	// ********
		0x80,	// **
		0x80,	// **
		0xe0,	// ******
		0x80,	// **
		0x80,	// **
		0xf0,	// ********
	},
	{5,
		0x00,
		0xf0,	// ********
		0x80,	// **
		0x80,	// **
		0xe0,	// ******
		0x80,	// **
		0x80,	// **
		0x80,	// **
	},

	{0,0,0,0,0,0,0,0,0},
/*
  ****    
**        
**        
**  ****  
**    **  
**    **  
  ****    
*/
	{5,
		0x00,
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0xf0,	// ********
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
	},

	{4,
		0x00,
		0xe0,	// ******
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0xe0,	// ******
	},

	{0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0},

/*
      ****  **    **  
        **  **    **  
        **  **  **    
        **  ****      
        **  **  **    
  **    **  **    **  
    ****    **    **  
*/

	{4,
		0x00,
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0xe0,	// ******
	},


	{6,
		0x00,
		0x88,	// **      **
		0xd8,	// ****  ****
		0xa8,	// **  **  **
		0x88,	// **      **
		0x88,	// **      **
		0x88,	// **      **
		0x88,	// **      **
	},
	{5,
		0x00,
		0x90,	// **    **
		0xd0,	// ****  **
		0xd0,	// ****  **
		0xb0,	// **  ****
		0xb0,	// **  ****
		0x90,	// **    **
		0x90,	// **    **
	},
	{5,
		0x00,
		0x60,	//   ****
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x60,	//   ****
	},
	{5,
		0x00,
		0xe0,	// ******
		0x90,	// **    **
		0x90,	// **    **
		0xe0,	// ******
		0x80,	// **
		0x80,	// **
		0x80,	// **
	},

	{0,0,0,0,0,0,0,0,0},

/*
  ****    
**    **  
**    **  
**    **  
**    **  
**  ****  
  **  **  
*/

	{5,
		0x00,
		0xe0,	// ******
		0x90,	// **    **
		0x90,	// **    **
		0xe0,	// ******
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
	},

	{5,
		0x00,
		0x70,	//   ******
		0x80,	// **
		0x80,	// **
		0x60,	//   ****
		0x10,	//       **
		0x10,	//       **
		0xe0,	// ******
	},
	{4,
		0x00,
		0xe0,	// ******
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
	},

	{5,
		0x00,
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x60,	//   ****
	},

	{5,
		0x00,
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x90,	// **    **
		0x50,	//   **  **
		0x50,	//   **  **
		0x20,	//     **
	},

	{6,
		0x00,
		0x88,	// **      **
		0x88,	// **      **
		0x88,	// **      **
		0x88,	// **      **
		0xa8,	// **  **  **
		0xd8,	// ****  ****
		0x88,	// **      **
	},
	{4,
		0x00,
		0xa0,	// **  **
		0xa0,	// **  **
		0xa0,	// **  **
		0x40,	//   **
		0xa0,	// **  **
		0xa0,	// **  **
		0xa0,	// **  **
	},
	{4,
		0x00,
		0xa0,	// **  **
		0xa0,	// **  **
		0xa0,	// **  **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
	},
	{0,0,0,0,0,0,0,0,0},
/*
  **********
          **
        **
      **
    **
  **
  **********
*/
	{3,
		0x00,
		0xc0,	// ****
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0x80,	// **
		0xc0,	// ****
	},

	{0,0,0,0,0,0,0,0,0},

	{3,
		0x00,
		0xc0,	// ****
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0x40,	//   **
		0xc0,	// ****
	},


};


static int color_map[4][8]={
	{0x2,0x2,0x6,0xe,0xf,0xe,0x6,0x2},	// Blue
	{0x4,0x4,0xc,0xd,0xf,0xd,0xc,0x4},	// Green
	{0x1,0x1,0x3,0xb,0xf,0xb,0x3,0x1},	// Red
	{0x5,0x5,0x7,0xf,0xf,0xf,0x7,0x5},	// Grey
};


static int runlen[4]={0,0,0,0},last_color[4]={0,0,0,0};
static int new_size=0;

static unsigned char row[4][256];

static int rle_compress(int color, int j) {

	int need_comma=0;

	if (color==last_color[j]) {
		runlen[j]++;
	}
	else {
//		printf("Run of color %d length %d\n",
//			last_color[j],runlen[j]);
		if (runlen[j]==0) ; // first color, skip
		if (runlen[j]==1) {
			printf("$%02X",last_color[j]);
			new_size++;
		}
		if (runlen[j]==2) {
			printf("$%02X,$%02X",last_color[j],last_color[j]);
			new_size+=2;
		}

		if ((runlen[j]>2) && (runlen[j]<16)) {
			printf("$%02X,$%02X",0xa0 | (runlen[j]),
				last_color[j]);
			new_size+=2;
		}
		/* We could in theory compress up to 272 */
		/* but we leave it at 256 to make the decode easier */
		if ((runlen[j]>15) && (runlen[j]<256)) {
			new_size+=3;
			printf("$%02X,$%02X,$%02X",0xa0,
				runlen[j],last_color[j]);
		}
		if (runlen[j]>256) {
			printf("Too big!\n");
			exit(1);
		}

		runlen[j]=1;
		need_comma=1;
	}
	return need_comma;
}

static int vmw_logo[4][18]={
	{0x10,0x10,0x10,0x10,0x10,0x40, 0x20,0x20,0x20,0x20,0x20,0x40, 0x20,0x20,0x20,0x20,0x20,0x00},
	{0x11,0x11,0x11,0x11,0x11,0x44, 0x22,0x22,0x22,0x22,0x22,0x44, 0x22,0x22,0x22,0x22,0x22,0x00},
	{0x00,0x11,0x11,0x11,0x44,0x44, 0x44,0x22,0x22,0x22,0x44,0x44, 0x44,0x22,0x22,0x22,0x00,0x00},
	{0x00,0x00,0x11,0x44,0x44,0x44, 0x44,0x44,0x22,0x44,0x44,0x44, 0x44,0x44,0x22,0x00,0x00,0x00},
};

static int rainbow_logo[4][6]={
	{0x00,0x00,0x00,0xc0,0x0c,0x00 },
	{0xd0,0xdc,0xdc,0xdc,0x0c,0x00 },
	{0x19,0x19,0x19,0x19,0x10,0x00 },
	{0x02,0x62,0x62,0x62,0x02,0x00 },
};

static int xmas_tree[4][5]={
	{0x00,0x00,0x4d,0x00,0x00 },
	{0x00,0x44,0xd4,0x4d,0x00 },
	{0x40,0x4d,0x44,0x44,0x40 },
	{0x00,0x10,0x18,0x10,0x00 },
};

static int holly[4][9]={
	{0x00,0x00,0x00,0x10,0x11,0x10,0x00,0x00,0x00 },
	{0x00,0xc0,0x4c,0xc1,0x11,0xc1,0x4c,0xc0,0x00 },
	{0xc0,0x4c,0xc4,0xcc,0x00,0xcc,0xc4,0x4c,0xc0 },
	{0xcc,0xc4,0x0c,0x00,0x00,0x00,0x0c,0xc4,0xcc },
};


int main(int argc, char **argv) {

	//char string[]="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//	char string[]="         \001DEATER \002WAS \003HERE!!!         ";
//	char string[]="         \001BY DEATER... \002A \010 PRODUCTION         ";
//	char string[]="           \003\011APPLE ][ FOREVER\011           ";
//	char string[]="           \012 \001MERRY XMAS 2018 \003FROM DEATER \013           ";
//	char string[]="           \012 \001MERRY XMAS 2023 \003FROM \004DESIRE \013           ";
	char string[]="           \013 \001CODE: DEATER  \002MUSIC: MA2E \012           ";
	int length=0,width=0,x,y,i,j;
	int color,color1,color2;
	int which_color=0;
	int need_comma;

	for(i=0;i<strlen(string);i++) {
		if (string[i]<5) { which_color=string[i]-1; continue;}

		/* VMW logo */
		if (string[i]==8) {
			width=18;
			// **********  **********  **********
			// **********  **********  **********
			// **********  **********  **********
			//   ******      ******      ******
			//   ******      ******      ******
			//     **          **          **
			//     **          **          **
			for(x=0;x<width;x++) {
				for(j=0;j<4;j++) {
					row[j][length]=vmw_logo[j][x];
				}
				length++;
			}

			continue;
		}

		/* rainbow apple logo */
		if (string[i]==9) {
			width=6;
			for(x=0;x<width;x++) {
				for(j=0;j<4;j++) {
					row[j][length]=rainbow_logo[j][x];
				}
				length++;
			}

			continue;
		}

		/* christmas tree */
		if (string[i]==10) {
			width=5;
			for(x=0;x<width;x++) {
				for(j=0;j<4;j++) {
					row[j][length]=xmas_tree[j][x];
				}
				length++;
			}

			continue;
		}

		/* holly */
		if (string[i]==11) {
			width=9;
			for(x=0;x<width;x++) {
				for(j=0;j<4;j++) {
					row[j][length]=holly[j][x];
				}
				length++;
			}

			continue;
		}



		width=font[(int)string[i]][0];
		for(x=0;x<width;x++) {
			for(j=0;j<4;j++) {
				color=!!(font[(int)string[i]][1+j*2]&(0x80>>x));
				color1=color?color_map[which_color][0+j*2]:0;
				color=!!(font[(int)string[i]][2+j*2]&(0x80>>x));
				color2=color?(color_map[which_color][1+j*2])<<4:0;
				color=color1|color2;
				row[j][length]=color;

				if (color1==0xa) {
					printf("Error!  Can't use grey2!\n");
					exit(0);
				}

			}

			length++;
		}
	}

	printf("; Original size = %d bytes\n",length*4);

#if 0
	printf("scroll_length: .byte %d\n",length);
	for(y=0;y<4;y++) {
		printf("scroll_row%d:\n",y+1);
		printf("\t.byte ");
		for(x=0;x<length;x++) {
			printf("$%02X",row[y][x]);
			if (x!=length-1) printf(",");
		}
		printf("\n");
	}
#endif
	printf("a2_scroll:\n");
	printf("; scroll_length:\n.byte %d\n",length);
	for(y=0;y<4;y++) {
		//printf("scroll_row%d:\n",y+1);
		printf("\t.byte ");
		for(x=0;x<256;x++) {
			need_comma=rle_compress(row[y][x],y);
			if ((need_comma) && (x!=length-1)) printf(",");
			last_color[y]=row[y][x];
		}
		rle_compress(-1,y);
		printf("\n");
	}
	printf("\t.byte $A1\n");
	new_size++;
	printf("; Compressed size = %d bytes\n",new_size);


	int fd;

	fd=open("scroll.raw",O_CREAT|O_WRONLY,0666);
	if (fd<0) {
		fprintf(stderr,"Error opening\n");
		exit(1);
	}
	for(y=0;y<4;y++) {
		write(fd,&row[y],256);
	}
	close(fd);

	return 0;
}
