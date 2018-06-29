/* ---------------------------------------------------------------------
Bmp2DHR (C) Copyright Bill Buckels 2014.
All Rights Reserved.

Module Name - Description
-------------------------

b2d.h - header file for b2d.c (main program)

Licence Agreement
-----------------

You have a royalty-free right to use, modify, reproduce and
distribute this source code in any way you find useful, provided
that you agree that Bill Buckels has no warranty obligations or
liability resulting from said distribution in any way whatsoever. If
you don't agree, remove this source code and related files from your
computer now.

Written by: Bill Buckels
Email:      bbuckels@mts.net

Version 1.0
Developed between Aug 2014 and December 2014 with "standard parts".

Bmp2DHR reads a monochrome, 16 color, 256 color, or 24 bit BMP and writes
Apple II color or monochrome HGR or DHGR files.

*/

#ifndef BMP2SHR_H
#define BMP2SHR_H 1

/* ***************************************************************** */
/* ========================== includes ============================= */
/* ***************************************************************** */

#include "tomthumb.h"

/* ***************************************************************** */
/* ========================== defines ============================== */
/* ***************************************************************** */

/* file name length max */
#define MAXF 256

#define SUCCESS 0
#define INVALID -1
#define RETRY 911
#define BIN_OUTPUT 1
#define SPRITE_OUTPUT 2

/* constants for the biCompression field in a BMP header */
#define BI_RGB      0L
#define BI_RLE8     1L
#define BI_RLE4     2L

/* DHGR, DLGR, LGR colors - LGR color order */
#define LOBLACK   	0
#define LORED     	1
#define LODKBLUE 	2
#define LOPURPLE  	3
#define LODKGREEN	4
#define LOGRAY    	5
#define LOMEDBLUE	6
#define LOLTBLUE 	7
#define LOBROWN   	8
#define LOORANGE  	9
#define LOGREY    	10
#define LOPINK    	11
#define LOLTGREEN	12
#define LOYELLOW  	13
#define LOAQUA    	14
#define LOWHITE   	15

/* HGR color constants */
#define	HBLACK 	0
#define HGREEN 	1
#define HVIOLET 2
#define HORANGE 3
#define HBLUE	4
#define HWHITE	5

#define RED    0
#define GREEN  1
#define BLUE   2

#define FLOYDSTEINBERG 1
#define JARVIS 2
#define STUCKI 3
#define ATKINSON 4
#define BURKES 5
#define SIERRA 6
#define SIERRATWO 7
#define SIERRALITE 8
#define BUCKELS 9
#define CUSTOM 10

#define ASCIIZ	0
#define CRETURN 13
#define LFEED	10

#define PSEUDOMAX 100

/* ***************************************************************** */
/* ========================== typedefs ============================= */
/* ***************************************************************** */

/* Bitmap Header structures */
typedef struct __attribute__((__packed__)) tagBITMAPINFOHEADER {
    uint32_t   biSize;
    uint32_t   biWidth;
    uint32_t   biHeight;
    uint16_t  biPlanes;
    uint16_t  biBitCount;
    uint32_t   biCompression;
    uint32_t   biSizeImage;
    uint32_t   biXPelsPerMeter;
    uint32_t   biYPelsPerMeter;
    uint32_t   biClrUsed;
    uint32_t   biClrImportant;
} BITMAPINFOHEADER;

typedef struct __attribute__((__packed__)) tagBITMAPFILEHEADER

{
    uint8_t   bfType[2];
    uint32_t   bfSize;
    uint16_t  bfReserved1;
    uint16_t  bfReserved2;
    uint32_t   bfOffBits;
} BITMAPFILEHEADER;

typedef struct __attribute__((__packed__)) tagBMPHEADER {
	BITMAPFILEHEADER bfi;
	BITMAPINFOHEADER bmi;
} BMPHEADER;

typedef struct __attribute__((__packed__)) tagRGBQUAD {
    uint8_t    rgbBlue;
    uint8_t    rgbGreen;
    uint8_t    rgbRed;
    uint8_t    rgbReserved;
} RGBQUAD;


/* ***************************************************************** */
/* =================== prototypes as required  ===================== */
/* ***************************************************************** */

int16_t GetUserTextFile(void);
int dhrgetpixel(int x,int y);

/* ***************************************************************** */
/* ========================== globals ============================== */
/* ***************************************************************** */

/* output buffers */
uint8_t *dhrbuf;
uint8_t *hgrbuf;

/* static structures for processing */
BITMAPFILEHEADER bfi;
BITMAPINFOHEADER bmi;
BMPHEADER mybmp,maskbmp;
RGBQUAD   sbmp[256], maskpalette[256]; /* super vga - applewin */

/* overlay file for screen titling and framing and "cleansing" */
FILE *fpmask = NULL;
uint8_t remap[256];

char bmpfile[MAXF], dibfile[MAXF], scaledfile[MAXF], previewfile[MAXF], reformatfile[MAXF], maskfile[MAXF], fmask[MAXF];
char spritefile[MAXF], mainfile[MAXF],auxfile[MAXF],a2fcfile[MAXF],usertextfile[MAXF],vbmpfile[MAXF],fname[MAXF];

/* HGR file designations for systems with long file names */
/* these match the HGR output options selected */
char hgrcolor[MAXF],hgrmono[MAXF],hgrwork[MAXF];

int mono = 0, dosheader = 0, spritemask = 0, tags=0;
int backgroundcolor = 0, quietmode = 1, diffuse = 0, merge = 0, scale = 0, applesoft = 0, outputtype = BIN_OUTPUT;
int reformat = 0, debug = 0;
int preview = 0, vbmp = 0, hgroutput = 0;
int overlay = 0, maskpixel=0, overcolor=0, clearcolor=5;

/* 2 x 2 general purpose cross-hatching */
int xmatrix = 0, ymatrix = 0, threshold = 0;

uint16_t bmpwidth = 0, bmpheight = 0, spritewidth = 0;

/* classic size alternate windowed output */
/* applies to 320 x 200, 640 x 400, and 640 x 480 only */
/* for 320 x 200 the window is 280 x 192 */
/* for 640 x the window is 560 x 384 */
/* output is always 280 x 192 */
/* for 640 output is merged 2 x 2 */
int16_t justify = 0, jxoffset = -1, jyoffset = -1;

/* HGR setting - by default, double colors is off and pixels are set individually */
int doubleblack = 0, doublewhite = 0, doublecolors = 1, ditheroneline = 0;

/* error diffusion dithering settings */
int globalclip = 0;
int ditherstart = 0;
int bleed = 16;
int paletteclip = 0;

/* custom dither file support */
int16_t customdivisor;
int16_t customdither[3][11];

uint8_t msk[]={0x80,0x40,0x20,0x10,0x8,0x4,0x2,0x1};
int reverse = 0;

/* the line buffers in this program are designed to hold a 320 pixel scanline...
   for reusability in other modules and for other Apple II modes
   including SHR 320 */
/* for DHGR monochrome they must hold a scanline 560 pixels wide */
uint8_t bmpscanline[1920],
      bmpscanline2[1920],
      dibscanline1[1920],
      dibscanline2[1920],
      dibscanline3[1920],
      dibscanline4[1920],
      previewline[1920],
      maskline[560];

/* Floyd-Steinberg Etc. Dithering */
uint8_t dither = 0, errorsum = 0, serpentine = 0;
/* color channel buffers for Floyd-Steinberg Etc. Dithering */
/* note that these are arrays of short integers (2 bytes * 320) */
/* current line contains current scanline values
   + (plus) seed values (error values) from previous line

   these error values are the linear distance in a scale of 0-255
   between the real color and the nearest palette color.

   each of the r,g,b color channels is separate.

   a psychovisual palette match is done with the real color
   to get the near color from the palette

   the dither error is then applied to neighboring pixels
   using the dithering filter's distribution pattern

   later on when the color channels are finally reconstructed
   a psychovisual palette match is done again to get the dither
   color.

   if preview is turned-on the output can be viewed in
   a BMP viewer.

*/
int16_t redDither[640],greenDither[640],blueDither[640];
/* seed values from previous line */
int16_t redSeed[640],greenSeed[640],blueSeed[640];
int16_t redSeed2[640],greenSeed2[640],blueSeed2[640];
int16_t *colorptr, *seedptr, *seed2ptr, color_error;

int colorbleed = 100;

/* color hgr dither routines */
/* these buffers correspond to redDither, blueDither, greenDither */
int16_t redSave[320], greenSave[320], blueSave[320];
int16_t OrangeBlueError[320], GreenVioletError[320];
uint8_t HgrPixelPalette[320];
uint8_t dither7 = 0, hgrdither = 0;

/* HGR output routines */
uint8_t palettebits[40], hgrpaltype = 255; /* Both palettes are active by default */
uint8_t hgrcolortype = 0;
uint8_t work280[280], buf280[560];

/* built-in palette options */
/* based on DHGR, DLGR, LGR colors */
/* LGR color order */
uint8_t kegs32colors[16][3] = {
	{0,0,0},		 /* black    */
	{221,0,51},	 /* red      */
	{0,0,153},	 /* dk blue  */
	{221,0,221},	 /* purple   */
	{0,119,0},	 /* dk green */
	{85,85,85},	 /* gray     */
	{34,34,255},	 /* med blue */
	{102,170,255}, /* lt blue  */
	{136,85,34},	 /* brown    */
	{255,102,0},	 /* orange   */
	{170,170,170}, /* grey     */
	{255,153,136}, /* pink     */
	{0,221,0},	 /* lt green */
	{255,255,0},	 /* yellow   */
	{0,255,153},	 /* aqua     */
	{255,255,255}/* white    */
};
uint8_t ciderpresscolors[16][3] = {
	{0,0,0},		 /* black    */
	{221,0,51},	 /* red      */
	{0,0,153},	 /* dk blue  */
	{221,34,221},	 /* purple   */
	{0,119,34},	 /* dk green */
	{85,85,85},	 /* gray     */
	{34,34,255},	 /* med blue */
	{102,170,255}, /* lt blue  */
	{136,85,0},	 /* brown    */
	{255,102,0},	 /* orange   */
	{170,170,170}, /* grey     */
	{255,153,136}, /* pink     */
	{17,221,0},	 /* lt green */
	{255,255,0},	 /* yellow   */
	{68,255,153},	 /* aqua     */
	{255,255,255}/* white    */
};

uint8_t awinoldcolors[16][3] = {
	{0,0,0},	/* black    */
	{208,0,48},	/* red      */
	{0,0,128},	/* dk blue  */
	{255,0,255},	/* purple   */
	{0,128,0},	/* dk green */
	{128,128,128},	/* gray     */
	{0,0,255},	/* med blue */
	{96,160,255},	/* lt blue  */
	{128,80,0},	/* brown    */
	{255,128,0},	/* orange   */
	{192,192,192},	/* grey     */
	{255,144,128},	/* pink     */
	{0,255,0},	/* lt green */
	{255,255,0},	/* yellow   */
	{64,255,144},	/* aqua     */
	{255,255,255}	/* white    */
};

uint8_t awinnewcolors[16][3] = {
	{0,0,0},	/* black    */
	{157,9,102},	/* red      */
	{42,42,229},	/* dk blue  */
	{199,52,255},	/* purple   */
	{0,118,26},	/* dk green */
	{128,128,128},	/* gray     */
	{13,161,255},	/* med blue */
	{170,170,255},	/* lt blue  */
	{85,85,0},	/* brown    */
	{242,94,0},	/* orange   */
	{192,192,192},	/* grey     */
	{255,137,229},	/* pink     */
	{56,203,0},	/* lt green */
	{213,213,26},	/* yellow   */
	{98,246,153},	/* aqua     */
	{255,255,255}	/* white    */
};

/* http://en.wikipedia.org/wiki/List_of_8-bit_computer_hardware_palettes */
uint8_t wikipedia[16][3] = {
	{0,0,0},	/* black */
	{114,38,64},	/* red */
	{64,51,127},	/* dk blue */
	{228,52,254},	/* purple */
	{14,89,64},	/* dk green */
	{128,128,128},	/* gray */
	{27,154,254},	/* med blue */
	{191,179,255},	/* lt blue */
	{64,76,0},	/* brown */
	{228,101,1},	/* orange */
	{128,128,128},	/* grey */
	{241,166,191},	/* pink */
	{27,203,1},	/* lt green */
	{191,204,128},	/* yellow */
	{141,217,191},	/* aqua */
	{255,255,255}	/* white */
};

/* http://wsxyz.net/tohgr.html */
/* Sheldon Simm's palette from todhr */
/*

Sheldon is clipping the black and white ranges.

The usual reason for doing this is for dirty images (caused by poor digitizing or
sampling or re-sampling color depth loss due to scaling). By using a clipping threshold
at either end of the rgb range, blacks that are not quite black don't match to some other
dark color and whites that are not quite white don't match to some other light color.

I too put this in place as a clipping option when I wrote Bmp2SHR about a year ago in my
Brooks output routines but it worked a little differently. I didn't build it into a
palette for one thing.

Sheldon's weighting favours clipping blue gun values at both ends of the range.

Red is clipped more than green in the high range, and green is clipped more than
red in the low range.

 static Pixel pal[] = {
    {   1,   4,   8}, // 0 black
    {  32,  54, 212}, // 1 dk blue
    {  51, 111,   0}, // 2 dk green
    {   7, 168, 225}, // 3 med blue
    {  99,  77,   0}, // 4 brown
    { 126, 126, 126}, // 5 gray
    {  67, 200,   0}, // 6 lt green
    {  93, 248, 133}, // 7 aqua
    { 148,  12, 125}, // 8 red
    { 188,  55, 255}, // 9 purple
    { 126, 126, 126}, // A grey
    { 158, 172, 255}, // B lt blue
    { 249,  86,  29}, // C orange
    { 255, 129, 236}, // D pink
    { 221, 206,  23}, // E yellow
    { 248, 250, 244}  // F white

    Also note that I use the array name grpal. This was used as a palette in
    one of Sheldon's previous versions. Since I have propagated this array name
    to my code and my code is working fine with it, I have no plans to change it
    to maintain currency with Sheldon's code.

*/
uint8_t grpal[16][3] = {
	{0,0,0},	/* black */
	{148,12,125},	/* red - hgr 0*/
	{32,54,212},	/* dk blue - hgr 0 */
	{188,55,255},	/* purple - default HGR overlay color */
	{51,111,0},	/* dk green - hgr 0 */
	{126,126,126},	/* gray - hgr 0 */
	{7,168,225},	/* med blue - alternate HGR overlay color */
	{158,172,255},	/* lt blue - hgr 0 */
	{99,77,0},	/* brown - hgr 0 */
	{249,86,29},	/* orange */
	{126,126,126},	/* grey - hgr 0 */
	{255,129,236},	/* pink - hgr 0 */
	{67,200,0},	/* lt green */
	{221,206,23},	/* yellow - hgr 0 */
	{93,248,133},	/* aqua - hgr 0 */
	{255,255,255}	/* white */
};

/* Sheldon still uses the RGB values from his old palette for HGR conversion */
uint8_t hgrpal[16][3] = {
	{0x00,0x00,0x00},	/* black */
	{0xad,0x18,0x28},	/* red */
	{0x55,0x1b,0xe1},	/* dk blue */
	{0xe8,0x2c,0xf8},	/* purple 232,44,248 - default hgr overlay color */
	{0x01,0x73,0x63},	/* dk green */
	{0x7e,0x82,0x7f},	/* gray */
	{0x34,0x85,0xfc},	/* med blue - 52,133,252 - alternate HGR overlay color */
	{0xd1,0x95,0xff},	/* lt blue */
	{0x33,0x6f,0x00},	/* brown */
	{0xd0,0x81,0x01},	/* orange */
	{0x7f,0x7e,0x77},	/* grey */
	{0xfe,0x93,0xa3},	/* pink */
	{0x1d,0xd6,0x09},	/* lt green */
	{0xae,0xea,0x22},	/* yellow */
	{0x5b,0xeb,0xd9},	/* aqua */
	{0xff,0xff,0xff}	/* white */
};

/* Kegs32 uses Super Convert's colors */
uint8_t SuperConvert[16][3] = {
	0,0,0,		 /* black */
	221,0,51,    /* red - hgr 0*/
	0,0,153,     /* dk blue - hgr 0 */
	221,0,221,   /* purple */
	0,119,0,     /* dk green - hgr 0 */
	85,85,85,    /* gray - hgr 0 */
	34,34,255,   /* med blue */
	102,170,255, /* lt blue - hgr 0 */
	136,85,34,   /* brown - hgr 0 */
	255,102,0,   /* orange */
	170,170,170, /* grey - hgr 0 */
	255,153,136, /* pink - hgr 0 */
	0,221,0,     /* lt green */
	255,255,0,   /* yellow - hgr 0 */
	0,255,153,   /* aqua - hgr 0 */
	255,255,255};/* white */

uint8_t Jace[16][3] = {
	0,0,0,		  /* black */
	177,0,93,	  /* red */
	32,41,255,	  /* dk blue */
	210,41,255,	  /* purple */
	0,127,34,	  /* dk green */
	127,127,127,  /* gray */
	0,168,255,	  /* med blue */
	160,168,255,  /* lt blue */
	94,86,0,	  /* brown */
	255,86,0,	  /* orange */
	127,127,127,  /* grey */
	255,127,220,  /* pink */
	44,213,0,	  /* lt green */
	222,213,0,	  /* yellow */
	77,255,161,	  /* aqua */
	255,255,255}; /* white */

/* https://github.com/cybernesto/VBMP/wiki/Converting-a-picture-into-a-DHGR-color-image-using-the-GIMP */
/* Robert Munafo - http://mrob.com/pub/xapple2/colors.html */
uint8_t Cybernesto[16][3] = {
	  0,  0,  0,	/* 0  Black       */
	227, 30, 96,	/* 1  Magenta     */
	 96, 78,189,	/* 8  Dark Blue   */
	255, 68,253,	/* 9  Violet  	  */
	  0,163, 96,	/* 4  Dark Green  */
	156,156,156,	/* 5  Grey1    	  */
	 20,207,253,	/* 12 Medium Blue */
	208,195,255,	/* 13 Light Blue  */
	 96,114,  3,	/* 2  Brown       */
	255,106, 60,	/* 3  Orange      */
	156,156,156,	/* 10 Grey2       */
	255,160,208,	/* 11 Pink        */
	 20,245, 60,	/* 6  Green       */
	208,221,141,	/* 7  Yellow      */
	114,255,208,	/* 14 Aqua        */
	255,255,255};	/* 15 White       */

/* pseudopalette support */
int16_t pseudocount = 0;
int16_t pseudolist[PSEUDOMAX];
uint16_t pseudowork[16][3];

/* "merged" pseudo palette average RGB values*/
/* initial values are the average values of p5 NTSC and p12 RGB */
uint8_t PseudoPalette[16][3] = {
	0,0,0,
	184,6,88,
	16,27,182,
	204,27,238,
	25,115,0,
	105,105,105,
	20,101,240,
	130,171,255,
	117,81,17,
	252,94,14,
	148,148,148,
	255,141,186,
	33,210,0,
	238,230,11,
	46,251,143,
	255,255,255};


/* ------------------------------------------------------------------------------ */
/* skip this if you think that this program has been clean up to now.             */
/* this is more like an egg I laid than an easter egg.                            */
/* some legacy stuff - unhacked skeletons in my closet                            */
/* from the AppleX Aztec C65 distribution - not everything always goes as planned */
/* ------------------------------------------------------------------------------ */

/* "designer" palettes - VGA style mapping colors from BMPA2FC */
/* these are in the lo-res color order, same as above */
/* in BMPA2FC these were in IBM-PC default BIOS order */

/* Serious doubt! */
/* at this point, I wonder how well BMPA2FC mapped colors from BMP's */
/* not very well I think - but it's an old MS-DOS utility and no point
   in worrying about it now - new users who find this can play with it */

/* this first array was my first attempt at establishing something that looked like
   24 bit Lo-Res Colors - I am not even sure where I got the colors
   they looked like what I wanted at the time before I knew a little more

   the rest of the palettes in here were just pasted forward from ClipShop
   but with a couple of minor changes to accomodate the move to Windows Paint for Xp
   and the 16 color BMP's which have been stable ever since.

   why the default palette changed between XP and Windows 3.1 I have no clue.

   */

/* If someone happens to use my canvas scheme from
   my old utilities or whatever, having these here will at least save them
   from ending-up with work that needs to be redone if they expected remapping */

/* goes with the canvas bmp that I put out there with AppleX */
uint8_t rgbCanvasArray[16][3] = {
0  , 0  , 0  ,
208, 0  , 48 ,
0  , 0  , 128,
255, 0  , 255,
0  , 128, 0  ,
128, 128, 128,
0  , 0  , 255,
96 , 160, 255,
128, 80 , 0  ,
255, 128, 0  ,
192, 192, 192,
255, 144, 128,
0  , 255, 0  ,
255, 255, 0  ,
64 , 255, 144,
255, 255, 255};

/* this might work with old Win16 16 color BMP's */
uint8_t rgbBmpArray[16][3] = {
0  ,0  , 0  ,
191,0  , 0  ,
0  ,0  , 191,
191,0  , 191,
0  ,191, 0  ,
128,128, 128,
0  ,191, 191,
0  ,0  , 255,
191,191, 0  ,
255,0  , 0  ,
192,192, 192,
255,0  , 255,
0  ,255, 0  ,
255,255, 0  ,
0  ,255, 255,
255,255, 255};

/* this might work with new Win32 16 color BMP's */
uint8_t rgbXmpArray[16][3] = {
0  , 0  , 0  ,
128, 0  , 0  ,
0  , 0  , 128,
128, 0  , 128,
0  , 128, 0  ,
128, 128, 128,
0  , 128, 128,
0  , 0  , 255,
128, 128, 0  ,
255, 0  , 0  ,
192, 192, 192,
255, 0  , 255,
0  , 255, 0  ,
255, 255, 0  ,
0  , 255, 255,
255, 255, 255};

/* from the bios in some PC I had */
uint8_t rgbVgaArray[16][3] = {
0  , 0  , 0  ,
255, 0  , 0  ,
0  , 0  , 255,
255, 0  , 255,
0  , 255, 0  ,
85 , 85 , 85 ,
0  , 255, 255,
85 , 85 , 255,
255, 255, 0  ,
255, 85 , 85 ,
192, 192, 192,
255, 85 , 255,
85 , 255, 85 ,
255, 255, 85 ,
85 , 255, 255,
255, 255, 255};

/* some old ZSoft VGA Pcx Colors */
uint8_t rgbPcxArray[16][3] = {
0  , 0  , 0  ,
170, 0  , 0  ,
0  , 0  , 170,
170, 0  , 170,
0  , 170, 0  ,
85 , 85 , 85 ,
0  , 170, 170,
85 , 85 , 255,
170, 170, 0  ,
255, 85 , 85 ,
170, 170, 170,
255, 85 , 255,
85 , 255, 85 ,
255, 255, 85 ,
85 , 255, 255,
255, 255, 255};

/* ------------------------------------------------------------------- */
/* end of legacy unhacked hack, and back to something that makes sense */
/* ------------------------------------------------------------------- */

/* palette work arrays */
uint8_t rgbArray[16][3], rgbAppleArray[16][3], rgbPreview[16][3], rgbUser[16][3];
double rgbLuma[16], rgbDouble[16][3];
double rgbOrangeDouble[3][3], rgbGreenDouble[3][3];
double rgbOrangeLuma[3], rgbGreenLuma[3];

double rgbLumaBrighten[16], rgbDoubleBrighten[16][3];
double rgbLumaDarken[16], rgbDoubleDarken[16][3];

/* provides base address for page1 hires scanlines  */
unsigned HB[]={
0x2000, 0x2400, 0x2800, 0x2C00, 0x3000, 0x3400, 0x3800, 0x3C00,
0x2080, 0x2480, 0x2880, 0x2C80, 0x3080, 0x3480, 0x3880, 0x3C80,
0x2100, 0x2500, 0x2900, 0x2D00, 0x3100, 0x3500, 0x3900, 0x3D00,
0x2180, 0x2580, 0x2980, 0x2D80, 0x3180, 0x3580, 0x3980, 0x3D80,
0x2200, 0x2600, 0x2A00, 0x2E00, 0x3200, 0x3600, 0x3A00, 0x3E00,
0x2280, 0x2680, 0x2A80, 0x2E80, 0x3280, 0x3680, 0x3A80, 0x3E80,
0x2300, 0x2700, 0x2B00, 0x2F00, 0x3300, 0x3700, 0x3B00, 0x3F00,
0x2380, 0x2780, 0x2B80, 0x2F80, 0x3380, 0x3780, 0x3B80, 0x3F80,
0x2028, 0x2428, 0x2828, 0x2C28, 0x3028, 0x3428, 0x3828, 0x3C28,
0x20A8, 0x24A8, 0x28A8, 0x2CA8, 0x30A8, 0x34A8, 0x38A8, 0x3CA8,
0x2128, 0x2528, 0x2928, 0x2D28, 0x3128, 0x3528, 0x3928, 0x3D28,
0x21A8, 0x25A8, 0x29A8, 0x2DA8, 0x31A8, 0x35A8, 0x39A8, 0x3DA8,
0x2228, 0x2628, 0x2A28, 0x2E28, 0x3228, 0x3628, 0x3A28, 0x3E28,
0x22A8, 0x26A8, 0x2AA8, 0x2EA8, 0x32A8, 0x36A8, 0x3AA8, 0x3EA8,
0x2328, 0x2728, 0x2B28, 0x2F28, 0x3328, 0x3728, 0x3B28, 0x3F28,
0x23A8, 0x27A8, 0x2BA8, 0x2FA8, 0x33A8, 0x37A8, 0x3BA8, 0x3FA8,
0x2050, 0x2450, 0x2850, 0x2C50, 0x3050, 0x3450, 0x3850, 0x3C50,
0x20D0, 0x24D0, 0x28D0, 0x2CD0, 0x30D0, 0x34D0, 0x38D0, 0x3CD0,
0x2150, 0x2550, 0x2950, 0x2D50, 0x3150, 0x3550, 0x3950, 0x3D50,
0x21D0, 0x25D0, 0x29D0, 0x2DD0, 0x31D0, 0x35D0, 0x39D0, 0x3DD0,
0x2250, 0x2650, 0x2A50, 0x2E50, 0x3250, 0x3650, 0x3A50, 0x3E50,
0x22D0, 0x26D0, 0x2AD0, 0x2ED0, 0x32D0, 0x36D0, 0x3AD0, 0x3ED0,
0x2350, 0x2750, 0x2B50, 0x2F50, 0x3350, 0x3750, 0x3B50, 0x3F50,
0x23D0, 0x27D0, 0x2BD0, 0x2FD0, 0x33D0, 0x37D0, 0x3BD0, 0x3FD0};

/*

The following is logically reordered to match the lores
color order...

                                                Repeated
                                                Binary
          Color         aux1  main1 aux2  main2 Pattern
          Black          00    00    00    00    0000
          Magenta        08    11    22    44    0001
		  Dark Blue      11    22    44    08    1000
          Violet         19    33    66    4C    1001
          Dark Green     22    44    08    11    0100
          Grey1          2A    55    2A    55    0101
          Medium Blue    33    66    4C    19    1100
          Light Blue     3B    77    6E    5D    1101
          Brown          44    08    11    22    0010
          Orange         4C    19    33    66    0011
          Grey2          55    2A    55    2A    1010
          Pink           5D    3B    77    6E    1011
          Green          66    4C    19    33    0110
          Yellow         6E    5D    3B    77    0111
          Aqua           77    6E    5D    3B    1110
          White          7F    7F    7F    7F    1111

*/

/* the following array is based on the above */
uint8_t dhrbytes[16][4] = {
	0x00,0x00,0x00,0x00,
	0x08,0x11,0x22,0x44,
	0x11,0x22,0x44,0x08,
	0x19,0x33,0x66,0x4C,
	0x22,0x44,0x08,0x11,
	0x2A,0x55,0x2A,0x55,
	0x33,0x66,0x4C,0x19,
	0x3B,0x77,0x6E,0x5D,
	0x44,0x08,0x11,0x22,
	0x4C,0x19,0x33,0x66,
	0x55,0x2A,0x55,0x2A,
	0x5D,0x3B,0x77,0x6E,
	0x66,0x4C,0x19,0x33,
	0x6E,0x5D,0x3B,0x77,
	0x77,0x6E,0x5D,0x3B,
	0x7F,0x7F,0x7F,0x7F};

int16_t lores = 0, loresoutput = 0, appletop = 0;

/* base addresses for Apple II primary text page */
/* also the base addresses for the 48 scanline pairs */
/* for Apple II lores graphics mode 40 x 48 x 16 colors */
unsigned textbase[24]={
    0x0400,
    0x0480,
    0x0500,
    0x0580,
    0x0600,
    0x0680,
    0x0700,
    0x0780,
    0x0428,
    0x04A8,
    0x0528,
    0x05A8,
    0x0628,
    0x06A8,
    0x0728,
    0x07A8,
    0x0450,
    0x04D0,
    0x0550,
    0x05D0,
    0x0650,
    0x06D0,
    0x0750,
    0x07D0};

/* the following is used to remap
   double lo res 4 bit colors
   from bank 0 to bank 1 */
uint8_t dloauxcolor[16] = {
	0,8,1,9,2,10,3,11,4,12,5,13,6,14,7,15};

/* the following is used to remap
   double lo res 4 bit colors
   from bank 1 to bank 0 */

/*
uint8_t dlomaincolor[16] = {
	0,2,4,6,8,10,12,14,1,3,5,7,9,11,13,15};

*/

/* resizing tables */

/* use as-is to use for 320 x 200 */
/* merge 4 pixels into one to use for 640 x 400 */
uint8_t mix25to24[24][2] = {
24,1,
23,2,
22,3,
21,4,
20,5,
19,6,
18,7,
17,8,
16,9,
15,10,
14,11,
13,12,
12,13,
11,14,
10,15,
9,16,
8,17,
7,18,
6,19,
5,20,
4,21,
3,22,
2,23,
1,24};

/*

To scale from 320 to 280, a 7 part mix is used from each pixel
in the following pattern with a ratio of 8:7

00000001 11111122 22222333 33334444 44455555 55666666 67777777
00000000 11111111 22222222 33333333 44444444 55555555 66666666

*/

uint8_t pixel320to280[7][4] = {
7,1,0,1,
6,2,1,2,
5,3,2,3,
4,4,3,4,
3,5,4,5,
2,6,5,6,
1,7,6,7};


/* http://en.wikipedia.org/wiki/List_of_8-bit_computer_hardware_palettes */
uint8_t rgbVBMP[16][3] = {
	0,0,0,		 /* black */
	114,38,64,   /* red */
	64,51,127,   /* dk blue */
	228,52,254,  /* purple */
	14,89,64,    /* dk green */
	128,128,128, /* gray */
	27,154,254,  /* med blue */
	191,179,255, /* lt blue */
	64,76,0,     /* brown */
	228,101,1,   /* orange */
	128,128,128, /* grey */
	241,166,191, /* pink */
	27,203,1,    /* lt green */
	191,204,128, /* yellow */
	141,217,191, /* aqua */
	255,255,255};/* white */

uint8_t RemapLoToHi[16] = {
	LOBLACK,
	LORED,
	LOBROWN,
	LOORANGE,
	LODKGREEN,
	LOGRAY,
	LOLTGREEN,
	LOYELLOW,
	LODKBLUE,
	LOPURPLE,
	LOGREY,
	LOPINK,
	LOMEDBLUE,
	LOLTBLUE,
	LOAQUA,
	LOWHITE};

/* 560 x 192 - verbatim DHGR mono output format */
uint8_t mono192[62] ={
0x42, 0x4D, 0x3E, 0x36, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x3E, 0x00, 0x00, 0x00, 0x28, 0x00,
0x00, 0x00, 0x30, 0x02, 0x00, 0x00, 0xC0, 0x00,
0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x36, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x00};

/* 280 x 192 - verbatim HGR output format */
uint8_t mono280[62] ={
0x42, 0x4D, 0x3E, 0x1B, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x3E, 0x00, 0x00, 0x00, 0x28, 0x00,
0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0xC0, 0x00,
0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x1B, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x00};

uint8_t dhgr2hgr[16] = {
	HBLACK,
	HBLACK,
	HBLACK,
	HVIOLET,
	HBLACK,
	HBLACK,
	HBLUE,
	HBLACK,
	HBLACK,
	HORANGE,
	HBLACK,
	HBLACK,
	HGREEN,
	HBLACK,
	HBLACK,
	HWHITE};

#endif
