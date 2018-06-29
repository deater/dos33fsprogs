/* ---------------------------------------------------------------------
Bmp2DHR (C) Copyright Bill Buckels 2014.
All Rights Reserved.

Module Name - Description
-------------------------

b2d.c - main program

Licence Agreement
-----------------

You have a royalty-free right to use, modify, reproduce and distribute this
source code in any way you find useful, provided that you agree that Bill
Buckels has no warranty obligations or liability resulting from said
distribution in any way whatsoever. If you don't agree, remove this source code
and related files from your computer now.

Written by: Bill Buckels
Email:      bbuckels@mts.net

Version 1.0
Developed between Aug 2014 and December 2014 with "standard parts".

Bmp2DHR reads a monochrome, 16 color, 256 color, or 24 bit BMP and writes Apple
II color or monochrome HGR or DHGR files.

Functional Summary of Bmp2DHR Version 1.0
-----------------------------------------

Input File Size
---------------

Full Screen Color Output - DHGR (default) and HGR (option "hgr")

Size, Nominal Resolution Etc

140 x 192 - verbatim
280 x 192 - lossy or merged
320 x 200 - 280 x 192
560 x 384 - lossy or merged
640 x 400 - 560 x 384
640 x 480 - 560 x 384

Full Screen HGR Monochrome Output - Option "mono"

280 x 192

Full Screen DHGR Monochrome Output - Option "mono"

560 x 192 Monochrome Only - verbatim conversion
560 x 384 Color Only - dithered output


Full Screen and Mixed Screen LGR (option "L") and DLGR (option "DL") Output

40 x 48 and 40 x 40 - LGR verbatim
80 x 48 and 80 x 40 - DLGR verbatim and LGR 2:1 merged scaling
160 x 96 and 160 x 80 - DLGR 2:2 and LGR 4:2 merged scaling
88 x 52 and 176 x 104 - Windowboxed Mini-Pix BMPs - Nominal Output Sizes same as above
320 x 192, 320 x 160, and 320 x 200 - DLGR 4:4 and LGR 8:4 merged scaling
560 x 384 and 560 x 320 - DLGR 7:8 and LGR 14:8 merged scaling
640 x 480 and 640 x 400 - DLGR 8:10 and LGR 16:10 merged scaling


Image Fragment DHGR Color "Sprite" Output - Option "F"

1 x 1 to 140 x 192 - verbatim - results in double-wide output appearance
1 x 1 to 280 x 192 - scaled - results in proportional output appearance

When scale is not set the maximum BMP input resolution for "Sprites" is 140 x
192, and when scale is set the maximum is 280 x 192.

Overlay File Size - 256 color BMP - verbatim sizes

HGR and DHGR Color Output - 140 x 192
HGR Mono Output - 280 x 192
DHGR Mono Output - 560 x 192

Additional Input Files - Text Format
------------------------------------

- Palette Files (various formats)
- User Definable Dither Files (see documentation and read source below)
- Overlay Titling Text (uses built-in TomThumb font)

Note: The Overlay Option for either a BMP or Text overlay does not apply to
image fragment output.

Output Summary
--------------

Bmp2DHR provides 4 primary types of Apple II output:

Default Color and Option "mono" - Full-Screen DHGR files - A2FC and A2FM single-file format.
Option "F"- Image Fragments in color DHGR Format - DHR scanline oriented single file format.
Option "hgr" - Full-Screen HGR files - single file BIN format.
Option "L" and "DL" - Full Screen and Mixed Screen Lo-Res and Double Lo-Res scanline oriented single file

DHGR Optional Alternate Output - Option "A" - AUX,BIN File Pairs instead of A2FC or A2FM files.
LGR and DLGR Optional Alternate Output - Option "A" - SL2 or DL1,DL2 File Pairs instead of SLO or DLO single files

AUX,BIN File Pairs, SL2 files and DL1,DL2 File Pairs are for AppleSoft BASIC programs.

Additional Optional Output includes:

Option "v" - Preview Output in BMP format.
Option "debug" - "debug" output of work files if any in BMP format.
Option "vbmp" - VBMP compatible BMP output (not available as LGR and DLGR output).

Additional Notes
----------------

For primary input Bmp2DHR accepts BMP files in Version 3 format only in a
specific range of input sizes and formats. The size and format of the input
file depends on the type of desired primary output and the rendering options
that have been selected.

Rendering options fall into several categories and where considered practically
possible and where it makes sense given the constraints and scope of Bmp2DHR,
all rendering options are available for all output.

Specific rendering options for specific output are also available.

Constraints are also also enforced by both BMP sizes and formats, and whether
output is color or monochrome, and also if external rendering is being used
like dithering in editors like The GIMP.

In the case of externally rendered input files, Bmp2DHR is only used as a
direct pixel converter to "pass-through" the BMP input file "verbatim". In this
case, the color palette needs to exactly match Bmp2DHR's color palette, and the
resolution needs to exactly match the Apple II output resolution.

560 x 384 and 560 x 192 BMPs are used as input files for DHGR monochrome output, and
280 x 192 BMPs are used as input files for HGR monochrome output.

Monochrome BMP files of 280 x 192 or 560 x 192 are required for verbatim
"pass-through" and output to Apple II HGR or DHGR files respectively. Palette
matched 140 x 192 color BMP files are required to pass-through properly to
color HGR or DHGR output. Color palettes that are used in external editors to
prepare pass-through input must either be imported into Bmp2DHR, or Bmp2DHR's
palettes must be imported into external editors.

Preview Output from Bmp2DHR can also generally be re-edited (carefully) and
reprocessed using direct pixel "passthrough" which is essentially the same
process as using an external editor to render and dither.

Secondary Input Files
---------------------

Bmp2DHR also accepts several secondary input files.

- Text Files for titling using a built-in font (HGR and DHGR full-screen conversion only)
- Palette Files in several text-based formats
- External Error Diffusion user-defined Dither Patterns in text format
- 256 color BMP files for overlaying the input image with verbatim text and simple pixel graphics
(HGR and DHGR full-screen conversion only)

For DHGR sprite output external Palette files and Dither Pattern files can be
used, but titling and overlaying is targeted at full-screen output.

Apple II Output Format Specification Summary
--------------------------------------------

DHGR output (default)

For DHGR default output, the A2FM and A2FC file extensions are just a naming
convention so the user can tell the difference between a monochrome and color
Apple II file; they are both binary DHGR files with a raw Auxiliary DHGR Memory
"DUMP" of 8192 bytes, followed by a raw Main DHGR Memory "DUMP" of 8192 bytes,
totalling 16384 bytes. These are stored in ProDOS as Binary FileType $06 with
an Auxiliary Type of either $2000 or $4000, which is the load address of the
DHGR screen.

Alternate Default Output (option "A")

Alternate output of a split version of the A2FC format is optionally available
using option "A". Sometimes called AUX,BIN file pairs, these are easier to load
in an AppleSoft BASIC program. They are also stored in ProDOS as Binary
FileType $06 with an Auxiliary Type of either $2000 or $4000 and are 8192 bytes
each.

For LGR and DLGR conversion the equivalent Alternate Output is also in "BSAVED" file
format. LGR and DLGR Apple II files are stored in  ProDOS as Binary FileType $06 with
an Auxiliary Type of $0400.

HGR output (option "hgr")

For HGR output, the "BIN" file extension is used. These are indistinguishable
from DHGR BIN files in an AUX,BIN file pair which are also the same ProDOS file
type $06 and length of 8192 bytes, so a loader must be aware of the specific
files to load these properly.

Image Fragment ("Sprite") output (option "F")

Sprite (image fragment) format Output is an option. Sprite Output and normal
HGR and DHGR full-screen output are mutually exclusive (to some degree). If you
provide Bmp2DHR with a BMP image fragment but you don't specify Option "F" a
full-screen Apple II A2FC File will be produced with the Sprite in the top left
corner. This is so you can conveniently look at the sprite on an Apple II
display. The latest version of my cc65 dhishow slideshow also loads Sprites so
you can use that for the same purpose too.

About Sprites

The Sprites produced by this utility are in XPACK's DHR format, but XPACK only
produces Full Screen DHGR images so this is something new.

The DHR (Double Hi-Res Raster) Image Format

The image fragments produced by Bmp2DHR have an extension of DHR. Like A2FC and
AUX,BIN file pairs, they are stored on an Apple II Disk as ProDOS FileType $06
with an Auxiliary Type of $2000 or $4000 by default. On a DOS 3.3 disk they are
stored with header information required by DOS 3.3.

The Header of a DHR is in two parts;

3 bytes of ID data with the letters 'D', 'H', 'R' in upper-case
1 byte - width in bytes (multiples of 4 bytes - 7 pixels)
1 byte - height in rasters

The DHR is a raster based image with scanlines of raw DHGR data alternating
between auxiliary and main memory. Therefore a simple BASIC program cannot
easily load these since the DHGR screen is interleaved the same way that the
HGR screen is interleaved and not linear. Bank switching between auxiliary and
main memory banks 0 (main board) and 1 (language card) is also not easy in a
BASIC program.

For a full-screen DHR, there are 192 pairs of rasters, each of 40 bytes of
auxiliary memory data followed by 40 bytes of main memory data. This keeps bank
switching to a minimum and allows for linear reading from disk or buffer.

The full screen DHR loads raster by raster and displays as quickly as a
buffered read can display on the Apple II. At 15365 bytes per screen this
format provides a modest disk space saving over the 16384 bytes of the A2FC or
AUX,BIN equivalent.

A caveat for any file in DHR raster format is the 4 byte / 7 pixel pattern of
the DHGR display. The width descriptor in the header is given in byte width
rather than pixel width. Image fragments in DHGR must necessarily be aligned on
4 byte boundaries to display properly. This utility pads DHR formats as
required in an optional background color if desired.

By comparison, HGR image fragments (not produced by Bmp2DHR) are aligned on 2
byte boundaries for proper display but they are still somewhat recognizable if
not aligned properly.If DHGR image fragments are not aligned on 4 byte
boundaries they are a mess.

If a programmer wanted to load these according to a specific position on the
DHGR it would be possible to give the starting scanline and starting byte to
the desired position on the screen, and store that as the Auxiliary Type
instead:

1. The program would read the header and perform a file integrity check to
ensure that the file size was as expected.

2. Part of the verification would also be to determine if the Auxiliary Type
fell within the DHGR visible screen boundaries and if the file itself would
fit.

3. Having satisfied this requirement the image fragment could be positioned at
that point by the program.

Doing so would save disk-space and load time when constructing a pre-planned
screen in a DHGR program, since full-screens are generally larger by comparison
to creating full-screens from fragments.

Additional Remarks
------------------

This program has many more options. The source code comments and the
documentation can be reviewed for additional information.

------------------------------------------------------------------------ */

/* ***************************************************************** */
/* ========================== includes ============================= */
/* ***************************************************************** */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <math.h>
#include <ctype.h>

#include "b2d.h"

/* ***************************************************************** */
/* ======================= string data ============================= */
/* ***************************************************************** */

char *title = "Bmp2DHR Version 1.1 (c) Copyright Bill Buckels 2015.\nAll Rights Reserved.";

char *usage[] = {
"Usage: \"b2d input.bmp options\"",
"Input format: mono, 16 color, 256 color, or 24-bit Version 3 uncompressed BMP",
"Default DHGR Colored Output: Full Screen Apple II A2FC file",
"Optional Usage: \"b2d input.bmp hgr options\"",
"  For HGR Colored Output: Full Screen Apple II BIN file",
"Optional Usage: \"b2d input.bmp mono options\"",
"  For Mono Output: Full Screen Apple II DHGR A2FM or HGR BIN file",
"Free Scaled Input Sizes: Full Screen (default) or DHGR Sprite (option F) output",
"  Full Scale: from 1 x 1 to 140 x 192 (default) - HGR and DHGR",
"  Half Scale: from 1 x 1 to 280 x 192 (scaling option S2) - HGR and DHGR",
"HGR and DHGR Fixed Scaled Input Sizes: Full Screen Output (default)",
"  140 x 192 - Full Scale (for LGR use 40 x 48, for DLGR use 80 x 48)",
"  280 x 192 - Double Width Scale (for LGR and DLGR use 160 x 96)",
"  320 x 200 - Classic Size (also used for LGR and DLGR windowboxed output)",
"  560 x 384 - Quadruple Width, Double Height Scale (also for LGR and DLGR)",
"  640 x 400 - Classic Size (also used for LGR and DLGR mixed screen output)",
"  640 x 480 - Classic Size (also used for LGR and DLGR full screen output)",
"Full Screen Dithered Output (optional): Option D (D1 to D9)",
"Optional Usage: \"b2d input.bmp L (or DL) options\"",
"  For Color LGR or DLGR Full Screen or Mixed Screen (option \"TOP\") Output",
"See documentation for more information including additional input size info",
NULL};

char *dithertext[] = {
	"Floyd-Steinberg",
	"Jarvis",
	"Stucki",
	"Atkinson",
	"Burkes",
	"Sierra",
	"Sierra Two",
	"Sierra Lite",
	"Buckels",
	"Custom"};

char *palname[] = {
	"Kegs32 RGB",
	"CiderPress RGB",
	"Old AppleWin NTSC",
	"New AppleWin NTSC",
	"Wikipedia NTSC",
	"tohgr NTSC DHGR",
	"Imported",
	"Legacy Canvas",
	"Legacy Win16",
	"Legacy Win32",
	"Legacy VGA BIOS",
	"Legacy VGA PCX",
	"Super Convert RGB",
	"Jace NTSC",
	"Cybernesto-Munafo NTSC",
	"Pseudo Palette",
	"tohgr NTSC HGR"};

/* ***************************************************************** */
/* ========================== code ================================= */
/* ***************************************************************** */

int cmpstr(char *str, char *cmp)
{
	int i;

	if (strlen(cmp) != strlen(str)) return INVALID;
	for (i=0;str[i] != 0;i++) {
		if (toupper(cmp[i]) != toupper(str[i])) return INVALID;
	}
	return SUCCESS;
}

/* returns 255 if color number or color name are invalid */
uint8_t PaintByNumbers(char *str)
{
	int idx;
	uint8_t c = toupper(str[0]);

	if (str[1] == (char) 0) {
		/* alpha mnemonic */
		if (c > 64 && c < 81) return (uint8_t) (c - 65);
	}

	/* non numeric argument so check for color names */
	/* add additional color names here if required */
	if (c > 57) {
		c = 255;
		if (cmpstr("black", str) == SUCCESS)c = 0;
		else if (cmpstr("red", str) == SUCCESS)c = 1;
		else if (cmpstr("dblue", str) == SUCCESS)c = 2;
		else if (cmpstr("purple", str) == SUCCESS)c = 3;
		else if (cmpstr("dgreen", str) == SUCCESS)c = 4;
		else if (cmpstr("dgray", str) == SUCCESS)c = 5;
		else if (cmpstr("dgrey", str) == SUCCESS)c = 5;
		else if (cmpstr("mblue", str) == SUCCESS)c = 6;
		else if (cmpstr("lblue", str) == SUCCESS)c = 7;
		else if (cmpstr("brown", str) == SUCCESS)c = 8;
		else if (cmpstr("orange", str) == SUCCESS)c = 9;
		else if (cmpstr("lgray", str) == SUCCESS)c = 10;
		else if (cmpstr("lgrey", str) == SUCCESS)c = 10;
		else if (cmpstr("pink", str) == SUCCESS)c = 11;
		else if (cmpstr("lgreen", str) == SUCCESS)c = 12;
		else if (cmpstr("yellow", str) == SUCCESS)c = 13;
		else if (cmpstr("aqua", str) == SUCCESS)c = 14;
		else if (cmpstr("white", str) == SUCCESS)c = 15;
	}
	else {
		if (c == '0' && str[1] == (char)0) {
			c = 0;
		}
		else {
			c = 255;
			idx = atoi(str);
			if (idx > -1 && idx < 16) c = (uint8_t) idx;
		}
	}

return c;
}


uint16_t Motorola16(uint16_t val)
{
	uint8_t buf[2];
	uint16_t *ptr;

	/* msb in smallest address */
	buf[0] = (uint8_t) (val % 256); val = val/256;
	buf[1] = (uint8_t) (val % 256);

    ptr = (uint16_t *)&buf[0];
    val = ptr[0];

    return val;
}

void WriteDosHeader(FILE *fp, uint16_t fl, uint16_t fa)
{

    /* if CiderPress tags are turned-on I assume that the header is not required
       since presumably the tags will be used to place the file properly and ciderpress
       will create the DOS 3.3 header based on the file attribute preservation tag.
    */
	if (dosheader == 1 && tags == 0) {

    	fa = Motorola16(fa);/* file bload address - not including this header */
    	fl = Motorola16(fl);/* file length - not including this header */

    	fwrite((char *)&fa,sizeof(uint16_t),1,fp);
    	fwrite((char *)&fl,sizeof(uint16_t),1,fp);
	}
}


/*

Photoshop Luminosity Average

Formula for the Luminosity Average:

  AvgLuma = 0.299·AvgRed + 0.587·AvgGreen + 0.114·AvgBlue


*/


/* set luma to different values for closest color */
int lumaREQ = 601, lumaRED = 299, lumaGREEN = 587, lumaBLUE = 114;
double dlumaRED, dlumaGREEN, dlumaBLUE;

void setluma()
{
	switch(lumaREQ)
	{
        case 240: /* SMPTE 240M transitional coefficients */
		          lumaRED = 212;	 lumaGREEN = 701;	 lumaBLUE = 87;
		          dlumaRED = 0.212;  dlumaGREEN = 0.701; dlumaBLUE = 0.087;
		          break;

        case 911: /* Sheldon Simms - tohgr */
       		      lumaRED = 77;	   lumaGREEN = 151;	   lumaBLUE = 28;
		          dlumaRED = 0.077;dlumaGREEN = 0.151; dlumaBLUE = 0.028;
		          break;

		case 411: /* The GIMP color managed */
		          lumaRED = 223;	 lumaGREEN = 717;	   lumaBLUE = 61;
		          dlumaRED = 0.2225; dlumaGREEN = 0.7169;  dlumaBLUE = 0.0606;
		          break;

		case 709: /* CCIR 709 - modern */
		          /* ImageMagick non-color managed */
		          lumaRED = 213;	  lumaGREEN = 715;	     lumaBLUE = 72;
		          dlumaRED = 0.212656;dlumaGREEN = 0.715158; dlumaBLUE = 0.072186;
		          break;

		case 601: /* CCIR 601 - most digital standard definition formats */
		default:  lumaRED = 299;	 lumaGREEN = 587;	   lumaBLUE = 114;
		          dlumaRED = 0.299;  dlumaGREEN = 0.587;   dlumaBLUE = 0.114;
		          break;


	}
}


/* intialize the values for the current palette */
void InitDoubleArrays()
{
	int i;
	double dr, dg, db, dthreshold;
	unsigned r, g, b;

    /* array for matching closest color in palette */
	for (i=0;i<16;i++) {
		rgbDouble[i][0] = dr = (double) rgbArray[i][0];
		rgbDouble[i][1] = dg = (double) rgbArray[i][1];
		rgbDouble[i][2] = db = (double) rgbArray[i][2];
		rgbLuma[i] = (dr*lumaRED + dg*lumaGREEN + db*lumaBLUE) / (255.0*1000);
	}

    /* array for matching closest color in palette
       threshold reduced by 25% */

    if (threshold == 0) {
		dthreshold = 0.75;
	}
	else {
		dthreshold = (double) threshold;
		if (xmatrix != 2) dthreshold *= 0.5;
	    dthreshold = (double) (100.0 - dthreshold) / 100;

	}

	for (i=0;i<16;i++) {
		dr = (double) rgbArray[i][0];
		dg = (double) rgbArray[i][1];
		db = (double) rgbArray[i][2];

		dr *= dthreshold;
		dg *= dthreshold;
		db *= dthreshold;

		rgbDoubleBrighten[i][0] = dr;
		rgbDoubleBrighten[i][1] = dg;
		rgbDoubleBrighten[i][2] = db;
		rgbLumaBrighten[i] = (dr*lumaRED + dg*lumaGREEN + db*lumaBLUE) / (255.0*1000);
	}

    if (threshold == 0) {
		dthreshold = 1.25;
	}
	else {
		dthreshold = (double) threshold;
		if (xmatrix != 2) dthreshold *= 0.5;
	    dthreshold = (double) (100.0 + dthreshold) / 100;
	}

	for (i=0;i<16;i++) {
		dr = (double) rgbArray[i][0];
		dg = (double) rgbArray[i][1];
		db = (double) rgbArray[i][2];

		dr *= dthreshold;
		if (dr > 255.0) dr = 255.0;
		dg *= dthreshold;
		if (dg > 255.0) dg = 255.0;
		db *= dthreshold;
		if (db > 255.0) db = 255.0;

		rgbDoubleDarken[i][0] = dr;
		rgbDoubleDarken[i][1] = dg;
		rgbDoubleDarken[i][2] = db;
		rgbLumaDarken[i] = (dr*lumaRED + dg*lumaGREEN + db*lumaBLUE) / (255.0*1000);
	}
}


/* select current palette */
void GetBuiltinPalette(int16_t palidx, int16_t previewidx, int16_t pseudo)
{
	int16_t i,j;
	uint8_t r,g,b;

    /* set conversion colors */
	switch(palidx) {
		case 16:/* optional NTSC palette from tohgr - used for HGR conversion */
		        for (i=0;i<16;i++) {
					rgbArray[i][0] = hgrpal[i][0];
					rgbArray[i][1] = hgrpal[i][1];
					rgbArray[i][2] = hgrpal[i][2];
				}
				break;
		case 15:
		        /* the infamous pseudo palette */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = PseudoPalette[i][0];
					rgbArray[i][1] = PseudoPalette[i][1];
					rgbArray[i][2] = PseudoPalette[i][2];
				}
				break;
		case 14: /* Robert Munafo - http://mrob.com/pub/xapple2/colors.html */
				 /* NTSC Palette used by Cybernesto in VBMP GIMP tutorial */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = Cybernesto[i][0];
					rgbArray[i][1] = Cybernesto[i][1];
					rgbArray[i][2] = Cybernesto[i][2];
				}
				break;
		case 13: /* Jace emulator NTSC palette */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = Jace[i][0];
					rgbArray[i][1] = Jace[i][1];
					rgbArray[i][2] = Jace[i][2];
				}
				break;
		case 12: /* Super Convert HGR and DHGR conversion colors */
				 /* same as kegs32 colors */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = SuperConvert[i][0];
					rgbArray[i][1] = SuperConvert[i][1];
					rgbArray[i][2] = SuperConvert[i][2];
				}
				break;
		/* 5 IBM-PC legacy palettes from BMPA2FC */
		/* used for color substitution - not Apple II colors */
		case 11: for (i=0;i<16;i++) {
					/* default colors from some old ZSoft 16 color PCX */
					rgbArray[i][0] = rgbPcxArray[i][0];
					rgbArray[i][1] = rgbPcxArray[i][1];
					rgbArray[i][2] = rgbPcxArray[i][2];
				}
				break;
		case 10: for (i=0;i<16;i++) {
					/* colors from VGA bios */
					rgbArray[i][0] = rgbVgaArray[i][0];
					rgbArray[i][1] = rgbVgaArray[i][1];
					rgbArray[i][2] = rgbVgaArray[i][2];
				}
				break;
		case 9: for (i=0;i<16;i++) {
					/* colors from Windows Paint XP - 16 color BMP */
					rgbArray[i][0] = rgbXmpArray[i][0];
					rgbArray[i][1] = rgbXmpArray[i][1];
					rgbArray[i][2] = rgbXmpArray[i][2];
				}
				break;
		case 8: for (i=0;i<16;i++) {
					/* colors from MSPaint Windows 3.1 - 16 color BMP */
					rgbArray[i][0] = rgbBmpArray[i][0];
					rgbArray[i][1] = rgbBmpArray[i][1];
					rgbArray[i][2] = rgbBmpArray[i][2];
				}
				break;
		case 7: for (i=0;i<16;i++) {
					/* "canvas" colors from BmpA2FC */
					rgbArray[i][0] = rgbCanvasArray[i][0];
					rgbArray[i][1] = rgbCanvasArray[i][1];
					rgbArray[i][2] = rgbCanvasArray[i][2];
				}
				break;
		case 6: /* user definable imported palette file */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = rgbUser[i][0];
					rgbArray[i][1] = rgbUser[i][1];
					rgbArray[i][2] = rgbUser[i][2];
				}
				break;
		case 4: /* wikipedia Apple II NTSC colors */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = wikipedia[i][0];
					rgbArray[i][1] = wikipedia[i][1];
					rgbArray[i][2] = wikipedia[i][2];
				}
				break;
		case 3: /* Current AppleWin Version's sort-of NTSC colors */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = awinnewcolors[i][0];
					rgbArray[i][1] = awinnewcolors[i][1];
					rgbArray[i][2] = awinnewcolors[i][2];
				}
				break;
		case 2: /* Previous AppleWin Version's sort-of NTSC colors */
			 	for (i=0;i<16;i++) {
					rgbArray[i][0] = awinoldcolors[i][0];
					rgbArray[i][1] = awinoldcolors[i][1];
					rgbArray[i][2] = awinoldcolors[i][2];
				}
				break;
		case 1:	/* CiderPress RGB File Viewer colors */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = ciderpresscolors[i][0];
					rgbArray[i][1] = ciderpresscolors[i][1];
					rgbArray[i][2] = ciderpresscolors[i][2];
				}
				break;
		case 0: /* kegs32 RGB colors - same as Super Convert */
				for (i=0;i<16;i++) {
					rgbArray[i][0] = kegs32colors[i][0];
					rgbArray[i][1] = kegs32colors[i][1];
					rgbArray[i][2] = kegs32colors[i][2];
				}
				break;
	    case 5:  /* NTSC palette from tohgr - used for default HGR and DHGR conversion */
		default:
				for (i=0;i<16;i++) {
					rgbArray[i][0] = grpal[i][0];
					rgbArray[i][1] = grpal[i][1];
					rgbArray[i][2] = grpal[i][2];
				}
				palidx = 5;
				break;
		}

    /* set preview colors */
	switch(previewidx) {
		case 16:/* HGR conversion - optional palette from tohgr */
		        for (i=0;i<16;i++) {
					rgbPreview[i][0] = hgrpal[i][0];
					rgbPreview[i][1] = hgrpal[i][1];
					rgbPreview[i][2] = hgrpal[i][2];
				}
				break;
		case 15: /* the infamous pseudo palette */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = PseudoPalette[i][0];
					rgbPreview[i][1] = PseudoPalette[i][1];
					rgbPreview[i][2] = PseudoPalette[i][2];
				}
				break;
		case 14: /* Robert Munafo - http://mrob.com/pub/xapple2/colors.html */
				 /* NTSC Palette used by Cybernesto in VBMP GIMP tutorial */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = Cybernesto[i][0];
					rgbPreview[i][1] = Cybernesto[i][1];
					rgbPreview[i][2] = Cybernesto[i][2];
				}
				break;
		case 13: /* Jace emulator NTSC palette */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = Jace[i][0];
					rgbPreview[i][1] = Jace[i][1];
					rgbPreview[i][2] = Jace[i][2];
				}
				break;
		case 12: /* Super Convert HGR and DHGR conversion colors */
				 /* same as kegs32 colors */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = SuperConvert[i][0];
					rgbPreview[i][1] = SuperConvert[i][1];
					rgbPreview[i][2] = SuperConvert[i][2];
				}
				break;
		/* 5 IBM-PC VGA legacy palettes from BMPA2FC */
		/* used for color substitution - not Apple II colors */
		case 11: for (i=0;i<16;i++) {
					/* default colors from some old ZSoft 16 color PCX */
					rgbPreview[i][0] = rgbPcxArray[i][0];
					rgbPreview[i][1] = rgbPcxArray[i][1];
					rgbPreview[i][2] = rgbPcxArray[i][2];
				}
				break;
		case 10: for (i=0;i<16;i++) {
					/* colors from VGA bios */
					rgbPreview[i][0] = rgbVgaArray[i][0];
					rgbPreview[i][1] = rgbVgaArray[i][1];
					rgbPreview[i][2] = rgbVgaArray[i][2];
				}
				break;
		case 9: for (i=0;i<16;i++) {
					/* colors from Windows Paint XP - 16 color BMP */
					rgbPreview[i][0] = rgbXmpArray[i][0];
					rgbPreview[i][1] = rgbXmpArray[i][1];
					rgbPreview[i][2] = rgbXmpArray[i][2];
				}
				break;
		case 8: for (i=0;i<16;i++) {
			        /* colors from MSPaint Windows 3.1 - 16 color BMP */
					rgbPreview[i][0] = rgbBmpArray[i][0];
					rgbPreview[i][1] = rgbBmpArray[i][1];
					rgbPreview[i][2] = rgbBmpArray[i][2];
				}
				break;
		case 7: for (i=0;i<16;i++) {
					/* "canvas" colors from BmpA2FC */
					rgbPreview[i][0] = rgbCanvasArray[i][0];
					rgbPreview[i][1] = rgbCanvasArray[i][1];
					rgbPreview[i][2] = rgbCanvasArray[i][2];
				}
				break;
		case 6: /* user definable imported palette file */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = rgbUser[i][0];
					rgbPreview[i][1] = rgbUser[i][1];
					rgbPreview[i][2] = rgbUser[i][2];
				}
				break;
		case 4: /* wikipedia Apple II NTSC colors */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = wikipedia[i][0];
					rgbPreview[i][1] = wikipedia[i][1];
					rgbPreview[i][2] = wikipedia[i][2];
				}
				break;
		case 3: /* Current AppleWin Version's sort-of NTSC colors */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = awinnewcolors[i][0];
					rgbPreview[i][1] = awinnewcolors[i][1];
					rgbPreview[i][2] = awinnewcolors[i][2];
				}
				break;
		case 2: /* Previous AppleWin Version's sort-of NTSC colors */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = awinoldcolors[i][0];
					rgbPreview[i][1] = awinoldcolors[i][1];
					rgbPreview[i][2] = awinoldcolors[i][2];
				}
				break;
		case 1:	/* CiderPress RGB File Viewer colors */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = ciderpresscolors[i][0];
					rgbPreview[i][1] = ciderpresscolors[i][1];
					rgbPreview[i][2] = ciderpresscolors[i][2];
				}
				break;
		case 0: /* kegs32 RGB colors - same as Super Convert */
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = kegs32colors[i][0];
					rgbPreview[i][1] = kegs32colors[i][1];
					rgbPreview[i][2] = kegs32colors[i][2];
				}
				break;
	    case 5:  /* NTSC palette from tohgr - used for default HGR and DHGR conversion */
		default:
				for (i=0;i<16;i++) {
					rgbPreview[i][0] = grpal[i][0];
					rgbPreview[i][1] = grpal[i][1];
					rgbPreview[i][2] = grpal[i][2];
				}
				previewidx = 5;
				break;
		}

        /* set-up the HGR conversion palette based-on the colors that were removed from palette 5 */
        /* 3 options are available - 6 colors, 4 color Orange-Blue, or 4 color Green-Violet */
		if (hgroutput == 1) {
			for (i=0;i<16;i++) {
				if (grpal[i][0] == 0 && grpal[i][1] == 0 && grpal[i][2] == 0) {
					rgbPreview[i][0] = rgbArray[i][0] = 0;
					rgbPreview[i][1] = rgbArray[i][1] =	0;
					rgbPreview[i][2] = rgbArray[i][2] =	0;
				}
			}
		}

		for (i=0;i<16;i++) {
			/* verbatim match - 4-bits deep not 8 */
			rgbAppleArray[i][0] = rgbArray[i][0] >> 4;
			rgbAppleArray[i][1] = rgbArray[i][1] >> 4;
			rgbAppleArray[i][2] = rgbArray[i][2] >> 4;
			/* match VBMP color palette to the current conversion palette */
			rgbVBMP[i][0] = rgbArray[i][0];
			rgbVBMP[i][1] = rgbArray[i][1];
			rgbVBMP[i][2] = rgbArray[i][2];
		}

        /* no need to clip mono - the mono palette has only 2 colors */
		if (paletteclip == 1 && mono == 0) {
			/* command options "CV" or "CP" (clip view or clip palette) */
			/* not implemented for preview or for verbatim match */
			/* note that verbatim match is only 4-bits deep so already clips */

			/* clipping filter for dirty blacks and whites */
			/* borrowed from Sheldon Simms */
			/* but this may have other adverse effects so it is optional */
        	rgbArray[0][RED]   = 1;
			rgbArray[0][GREEN] = 4;
			rgbArray[0][BLUE]  = 8;

        	rgbArray[15][RED]   = 248;
			rgbArray[15][GREEN] = 250;
			rgbArray[15][BLUE]  = 244;
		}

    if(pseudo != 1) {
    	if (quietmode == 1) {
			if (mono == 1) puts("Black and White Monochrome Palette");
			else printf("Palette %d: %s Colors\nPreview Palette %d: %s Colors\n",palidx,palname[palidx],previewidx,palname[previewidx]);

		}
	}

}

/* build pseudo-palettes by using the average rgb values of two or more palettes into one */
/* called from main() before setting the palettes
   and after an external user definable palette has been set (if any) */
void BuildPseudoPalette(int16_t palidx)
{

	int16_t i,j,k,idx;
	uint16_t gun;

	/* a pseudopalette cannot be used if palette 15 is selected as a conversion palette */
	if ((palidx < 0 || palidx > 16) || palidx == 15) return;


	/* get the initial values */
    /* call the palette routine before it is actually used to select the
       conversion and preview palette to avoid doing so much duplicate code */
	GetBuiltinPalette(palidx,palidx,1);
	for (i=0;i<16;i++) {
		for (j=0;j<3;j++) {
			pseudowork[i][j] = (uint16_t)rgbArray[i][j];
		}
	}

    /* merge the values from the work buffers into the pseudo-palette */
    /* accumulate the additional values */
	for (k = 0; k < pseudocount;k++) {
		idx = pseudolist[k];
		GetBuiltinPalette(idx,idx,1);
    	for (i=0;i<16;i++) {
			for (j=0;j<3;j++) {
				pseudowork[i][j] += rgbArray[i][j];
			}
		}
	}

	pseudocount++;
	for (i=0;i<16;i++) {
		for (j=0;j<3;j++) {
			/* basic linear color distance */
			/* use the average rgb values */
			/* no attempt to avoid rounding */
			gun = pseudowork[i][j]/pseudocount;
			PseudoPalette[i][j] = (uint8_t)gun;
		}
	}
	pseudocount--;

	/* if quiet mode is set print the final values */
	if (outputtype != SPRITE_OUTPUT) {
		if (quietmode == 0){
			/* rgb values can be redirected to a text file and used as an external palette
			   for subsequnet conversions and/or whatever else this is useful for */
			for (i=0;i<16;i++)
				printf("%d,%d,%d\n",PseudoPalette[i][0],PseudoPalette[i][1],PseudoPalette[i][2]);
		}
	}

	/* for normal output print the palette list */
	if (quietmode == 1) {
		printf("Pseudo Palette: %d (%s)",palidx,palname[palidx]);
		for (k = 0; k < pseudocount;k++) {
			idx = pseudolist[k];
		    printf(" + %d (%s)",idx,palname[idx]);
		}
		printf("\n");
	}
}

/* use CCIR 601 luminosity to get closest color in current palette */
/* based on palette that has been selected for conversion */
uint8_t GetMedColor(uint8_t r, uint8_t g, uint8_t b, double *paldistance)
{
	uint8_t drawcolor;
	double dr, dg, db, diffR, diffG, diffB, luma, lumadiff, distance, prevdistance;
	int i;

    dr = (double)r;
    dg = (double)g;
    db = (double)b;
    luma = (dr*lumaRED + dg*lumaGREEN + db*lumaBLUE) / (255.0*1000);
    lumadiff = rgbLuma[0]-luma;

	/* Compare the difference of RGB values, weigh by CCIR 601 luminosity */
    /* set palette index to color with shortest distance */

    /* get color distance to first palette color */
	diffR = (rgbDouble[0][0]-dr)/255.0;
	diffG = (rgbDouble[0][1]-dg)/255.0;
	diffB = (rgbDouble[0][2]-db)/255.0;

    prevdistance = (diffR*diffR*dlumaRED + diffG*diffG*dlumaGREEN + diffB*diffB*dlumaGREEN)*0.75
         + lumadiff*lumadiff;
    /* set palette index to first color */
    drawcolor = 0;
    paldistance[0] = prevdistance;

    /* get color distance to rest of palette colors */
    for (i=1;i<16;i++) {

        /* error test for doing dithered HGR */
        /* test with a 4 color palette */
        if (dither7 != (uint8_t) 0) {
			/* dither7 is set in FloydSteinberg() function */
        	if (dither7 == 'O') {
				/* 'O' - orange-blue palette */
				if (i != LOMEDBLUE && i!= LOORANGE && i!= LOWHITE) continue;
			}
			else {
				/* 'G' - green-violet palette */
        		if (i != LOPURPLE && i!= LOLTGREEN && i!= LOWHITE) continue;
			}
		}

        /* get color distance of this index */
		lumadiff = rgbLuma[i]-luma;
		diffR = (rgbDouble[i][0]-dr)/255.0;
		diffG = (rgbDouble[i][1]-dg)/255.0;
		diffB = (rgbDouble[i][2]-db)/255.0;
    	distance = (diffR*diffR*dlumaRED + diffG*diffG*dlumaGREEN + diffB*diffB*dlumaGREEN)*0.75
         	+ lumadiff*lumadiff;

        /* if distance is smaller use this index */
	    if (distance < prevdistance) {
		   prevdistance = distance;
		   paldistance[0] = prevdistance;
		   drawcolor = (uint8_t)i;
		}

	}
	return drawcolor;
}


/* use CCIR 601 luminosity to get closest color in current palette */
/* match values have been decreased by user-defined threshold */
/* brightens darker colors by promoting them */
uint8_t GetHighColor(uint8_t r, uint8_t g, uint8_t b, double *paldistance)
{
	uint8_t drawcolor;
	double dr, dg, db, diffR, diffG, diffB, luma, lumadiff, distance, prevdistance;
	int i;

    dr = (double)r;
    dg = (double)g;
    db = (double)b;
    luma = (dr*lumaRED + dg*lumaGREEN + db*lumaBLUE) / (255.0*1000);
    lumadiff = rgbLumaBrighten[0]-luma;

	/* Compare the difference of RGB values, weigh by CCIR 601 luminosity */
    /* set palette index to color with shortest distance */

    /* get color distance to first palette color */
	diffR = (rgbDoubleBrighten[0][0]-dr)/255.0;
	diffG = (rgbDoubleBrighten[0][1]-dg)/255.0;
	diffB = (rgbDoubleBrighten[0][2]-db)/255.0;

    prevdistance = (diffR*diffR*dlumaRED + diffG*diffG*dlumaGREEN + diffB*diffB*dlumaGREEN)*0.75
         + lumadiff*lumadiff;
    /* set palette index to first color */
    drawcolor = 0;
    paldistance[0] = prevdistance;

    /* get color distance to rest of palette colors */
    for (i=1;i<16;i++) {

        /* error test for doing dithered HGR */
        /* test with a 4 color palette */
        if (dither7 != (uint8_t) 0) {
			/* dither7 is set in FloydSteinberg() function */
        	if (dither7 == 'O') {
				/* 'O' - orange-blue palette */
				if (i != LOMEDBLUE && i!= LOORANGE && i!= LOWHITE) continue;
			}
			else {
				/* 'G' - green-violet palette */
        		if (i != LOPURPLE && i!= LOLTGREEN && i!= LOWHITE) continue;
			}
		}

        /* get color distance of to this index */
		lumadiff = rgbLumaBrighten[i]-luma;
		diffR = (rgbDoubleBrighten[i][0]-dr)/255.0;
		diffG = (rgbDoubleBrighten[i][1]-dg)/255.0;
		diffB = (rgbDoubleBrighten[i][2]-db)/255.0;
    	distance = (diffR*diffR*dlumaRED + diffG*diffG*dlumaGREEN + diffB*diffB*dlumaGREEN)*0.75
         	+ lumadiff*lumadiff;

        /* if distance is smaller use this index */
	    if (distance < prevdistance) {
		   prevdistance = distance;
		   paldistance[0] = prevdistance;
		   drawcolor = (uint8_t)i;
		}

	}
	return drawcolor;
}

/* use CCIR 601 luminosity to get closest color in current palette */
/* match values have been increased by user-defined threshold */
/* darkens lighter colors by demoting them */
uint8_t GetLowColor(uint8_t r, uint8_t g, uint8_t b, double *paldistance)
{
	uint8_t drawcolor;
	double dr, dg, db, diffR, diffG, diffB, luma, lumadiff, distance, prevdistance;
	int i;

    dr = (double)r;
    dg = (double)g;
    db = (double)b;
    luma = (dr*lumaRED + dg*lumaGREEN + db*lumaBLUE) / (255.0*1000);
    lumadiff = rgbLumaDarken[0]-luma;

	/* Compare the difference of RGB values, weigh by CCIR 601 luminosity */
    /* set palette index to color with shortest distance */

    /* get color distance to first palette color */
	diffR = (rgbDoubleDarken[0][0]-dr)/255.0;
	diffG = (rgbDoubleDarken[0][1]-dg)/255.0;
	diffB = (rgbDoubleDarken[0][2]-db)/255.0;

    prevdistance = (diffR*diffR*dlumaRED + diffG*diffG*dlumaGREEN + diffB*diffB*dlumaGREEN)*0.75
         + lumadiff*lumadiff;
    /* set palette index to first color */
    drawcolor = 0;
    paldistance[0] = prevdistance;

    /* get color distance to rest of palette colors */
    for (i=1;i<16;i++) {

        /* error test for doing dithered HGR */
        /* test with a 4 color palette */
        if (dither7 != (uint8_t) 0) {
			/* dither7 is set in FloydSteinberg() function */
        	if (dither7 == 'O') {
				/* 'O' - orange-blue palette */
				if (i != LOMEDBLUE && i!= LOORANGE && i!= LOWHITE) continue;
			}
			else {
				/* 'G' - green-violet palette */
        		if (i != LOPURPLE && i!= LOLTGREEN && i!= LOWHITE) continue;
			}
		}

        /* get color distance of to this index */
		lumadiff = rgbLumaDarken[i]-luma;
		diffR = (rgbDoubleDarken[i][0]-dr)/255.0;
		diffG = (rgbDoubleDarken[i][1]-dg)/255.0;
		diffB = (rgbDoubleDarken[i][2]-db)/255.0;
    	distance = (diffR*diffR*dlumaRED + diffG*diffG*dlumaGREEN + diffB*diffB*dlumaGREEN)*0.75
         	+ lumadiff*lumadiff;

        /* if distance is smaller use this index */
	    if (distance < prevdistance) {
		   prevdistance = distance;
		   paldistance[0] = prevdistance;
		   drawcolor = (uint8_t)i;
		}

	}
	return drawcolor;
}

/* switchboard function to handle cross-hatched and non-cross-hatched output */
/* keeps the conditionals out of the main loop */
uint8_t GetDrawColor(uint8_t r, uint8_t g, uint8_t b, int x, int y)
{

    /* additional vars for future */
    double distance, lowdistance, highdistance;
    uint8_t drawcolor, lowcolor, highcolor;
    uint8_t red 	= (uint8_t)(r >> 4),
		  green = (uint8_t)(g >> 4),
		  blue 	= (uint8_t)(b >> 4);
    int i;

	/* quick check for verbatim match */
	for (i = 0; i < 16; i++) {

        /* error test for doing dithered HGR */
        /* test with a 4 color palette */
        if (i!= 0 && dither7 != (uint8_t) 0) {
			/* dither7 is set in FloydSteinberg() function */
        	if (dither7 == 'O') {
				/* 'O' - orange-blue palette */
				if (i != LOMEDBLUE && i!= LOORANGE && i!= LOWHITE) continue;
			}
			else {
				/* 'G' - green-violet palette */
        		if (i != LOPURPLE && i!= LOLTGREEN && i!= LOWHITE) continue;
			}
		}

		if (rgbAppleArray[i][0] == red &&
			rgbAppleArray[i][1] == green &&
			rgbAppleArray[i][2] == blue) return (uint8_t)i;

	}

    /* non-cross-hatched output */
    if (threshold == 0 && ymatrix == 0) return GetMedColor(r,g,b,&distance);

    if (ymatrix != 0) {
        switch(ymatrix) {
        	case 1: return GetLowColor(r,g,b,&lowdistance);
        	case 3: return GetHighColor(r,g,b,&highdistance);
        	case 2:
        	default:return GetMedColor(r,g,b,&distance);
		}
	}

	/* patterned cross-hatching */
	/* the thresholds are percentage based */
	/* with a user definable threshold */

    switch(xmatrix)
    {
		/* patterns 1, 2, 3 - 2 x 2 patterned cross-hatching */
		case 1:
			/* low, med
			   med, low
			*/
			if (y % 2 == 0) {
				if (x%2 == 1) return GetMedColor(r,g,b,&distance);
				return GetLowColor(r,g,b,&lowdistance);
			}
			if (x%2 == 0) return GetMedColor(r,g,b,&distance);
			return GetLowColor(r,g,b,&lowdistance);

		case 3:
			/* high, med
			   med, high
			*/
			if (y % 2 == 0) {
				if (x%2 == 1) return GetMedColor(r,g,b,&distance);
				return GetHighColor(r,g,b,&highdistance);
			}
			if (x%2 == 0) return GetMedColor(r,g,b,&distance);
			return GetHighColor(r,g,b,&highdistance);

		case 2:
		default:
			/* high, low
			   low, high
			*/
			if (y % 2 == 0) {
				if (x%2 == 1) return GetLowColor(r,g,b,&lowdistance);
				return GetHighColor(r,g,b,&highdistance);
			}
			if (x%2 == 0) return GetLowColor(r,g,b,&lowdistance);
			return GetHighColor(r,g,b,&highdistance);

	}

#ifndef TURBOC
    /* never gets to here */
	return GetMedColor(r,g,b,&distance);
#endif

}

/* routines to save to Apple 2 Double Hires Format */
/* a double hi-res pixel can occur at any one of 7 positions */
/* in a 4 byte block which spans aux and main screen memory */
/* the horizontal resolution is 140 pixels */
void dhrplot(int x,int y,uint8_t drawcolor)
{
    int xoff, pattern;
    uint8_t *ptraux, *ptrmain;

    pattern = (x%7);
	xoff = HB[y] + ((x/7) * 2);
    ptraux  = (uint8_t *) &dhrbuf[xoff-0x2000];
    ptrmain = (uint8_t *) &dhrbuf[xoff];


	switch(pattern)
	{
		/* left this here for reference

		uint8_t dhrpattern[7][4] = {
		0,0,0,0,
		0,0,0,1,
		1,1,1,1,
		1,1,2,2,
		2,2,2,2,
		2,3,3,3,
        3,3,3,3};
        */

		case 0: ptraux[0] &= 0x70;
		        ptraux[0] |= dhrbytes[drawcolor][0] &0x0f;
		        break;
		case 1: ptraux[0] &= 0x0f;
		        ptraux[0] |= dhrbytes[drawcolor][0] & 0x70;
		        ptrmain[0] &= 0x7e;
		        ptrmain[0] |= dhrbytes[drawcolor][1] & 0x01;
		        break;
		case 2: ptrmain[0] &= 0x61;
		        ptrmain[0] |= dhrbytes[drawcolor][1] & 0x1e;
		        break;
		case 3: ptrmain[0] &= 0x1f;
		        ptrmain[0] |= dhrbytes[drawcolor][1] & 0x60;
		        ptraux[1] &= 0x7c;
		        ptraux[1] |= dhrbytes[drawcolor][2] & 0x03;
                break;
		case 4: ptraux[1] &= 0x43;
		        ptraux[1] |= dhrbytes[drawcolor][2] & 0x3c;
		        break;
		case 5: ptraux[1] &= 0x3f;
		        ptraux[1] |= dhrbytes[drawcolor][2] & 0x40;
 		        ptrmain[1] &= 0x78;
 		        ptrmain[1] |= dhrbytes[drawcolor][3] & 0x07;
 		        break;
		case 6: ptrmain[1] &= 0x07;
		        ptrmain[1] |= dhrbytes[drawcolor][3] & 0x78;
 		        break;
	}

}


/* monochrome DHGR - 560 x 192 */
unsigned char dhbmono[] = {0x7e,0x7d,0x7b,0x77,0x6f,0x5f,0x3f};
unsigned char dhwmono[] = {0x1,0x2,0x4,0x8,0x10,0x20,0x40};

void dhrmonoplot(int x, int y, uint8_t drawcolor)
{

    int xoff, pixel;
    uint8_t *ptr;

	if (x > 559) return;

    xoff = HB[y] + (x/14);
    pixel = (x%14);
    if (pixel > 6) {
		/* main memory */
		pixel -= 7;
		ptr = (uint8_t *) &dhrbuf[xoff];
	}
	else {
		/* auxiliary memory */
		ptr  = (uint8_t *) &dhrbuf[xoff-0x2000];
	}

	if (drawcolor != 0) {
		/* white */
		ptr[0] |= dhwmono[pixel]; /* inclusive OR */
	}
	else {
		/* black */
		ptr[0] &= dhbmono[pixel]; /* bitwise AND */
	}

}

/* monochrome HGR 280 x 192 */
void hrmonoplot(int x, int y, uint8_t drawcolor)
{

    int xoff, pixel;
    uint8_t *ptr;

    if (x > 279) return;

    xoff = HB[y] + (x/7);
    pixel = (x%7);
	/* main memory */
	ptr  = (uint8_t *) &dhrbuf[xoff-0x2000];

	if (drawcolor != 0) {
		/* white */
		ptr[0] |= dhwmono[pixel]; /* inclusive OR */
	}
	else {
		/* black */
		ptr[0] &= dhbmono[pixel]; /* bitwise AND */
	}

}

void dhrfill(int y,uint8_t drawcolor)
{
    int xoff, x;
    uint8_t *ptraux, *ptrmain;

	xoff = HB[y];

    ptraux  = (uint8_t *) &dhrbuf[xoff-0x2000];
    ptrmain = (uint8_t *) &dhrbuf[xoff];

    for (x = 0,xoff=0; x < 20; x++) {
		ptraux[xoff]  = dhrbytes[drawcolor][0];
		ptrmain[xoff] = dhrbytes[drawcolor][1]; xoff++;
		ptraux[xoff]  = dhrbytes[drawcolor][2];
		ptrmain[xoff] = dhrbytes[drawcolor][3]; xoff++;
	}
}


/* initialize the scanlines in the write buffer
   to the background color

   this doesn't matter for a full-screen image

*/
void dhrclear()
{
	int y;
	uint8_t drawcolor;
	memset(dhrbuf,0,16384);
	if (backgroundcolor == LOBLACK) return;
	drawcolor = (uint8_t)backgroundcolor;
	for (y=0;y<192;y++) dhrfill(y,drawcolor);
}

/* mono-spaced "tom thumb" 4 x 6 font */
/* using a byte map to gain a little speed at the expense of memory */
/* a bitmap could have been encoded into nibbles of 3 bytes per character
   rather than the 18 bytes per character that I am using
   but the trade-off in the speed in unmasking would have slowed this down */
void plotthumbDHGR(unsigned char ch, unsigned x, unsigned y,
               unsigned char fg, unsigned char bg)
{
	unsigned offset, x1, x2=x+3, y2=y+6, xmono;
	unsigned char byte;

	if (ch < 33 || ch > 127) ch = 0;
	else ch -=32;

	if (ch == 0 && bg > 15) return;

    /* each of the 96 characters is encoded into 18 bytes */
	offset = (18 * ch);

    while (y < y2) {
		xmono = x * 2;
		for (x1 = x; x1 < x2; x1++,xmono+=2) {
		   if (x1 > 139) {
			   offset++;
			   continue;
		   }

		   byte = tomthumb[offset++];

		   if (byte == 0) {
			   if (bg > 15) continue;
			   if (hgroutput == 1 && mono == 1) {
			      hrmonoplot(xmono,y,bg);
			      hrmonoplot(xmono+1,y,bg);
			   }
			   else {
			   	  dhrplot(x1,y,bg);
			   }
		   }
		   else {
			   if (fg > 15) continue;
			   if (hgroutput == 1 && mono == 1) {
			      hrmonoplot(xmono,y,fg);
			      hrmonoplot(xmono+1,y,fg);
			   }
			   else {
			   	  dhrplot(x1,y,fg);
			   }
	   	   }
		}
		/* if background color is being used then a trailing pixel is required
		   between characters */
		if (bg < 16 && x2 < 140) {
			if (hgroutput == 1 && mono == 1) {
				hrmonoplot(xmono,y,bg);
			    hrmonoplot(xmono+1,y,bg);
			}
			else {
				dhrplot(x2,y,bg);
			}
		}

		if (y++ > 191) break;
	}

}

/* normally spaced 4 x 6 font */
/* using character plotting function plotthumb() (above) */
void thumbDHGR(char *str,unsigned x, unsigned y,
              unsigned char fg,unsigned char bg, unsigned char justify)
{
  int target;
  unsigned char ch;

  if (justify == 'M' || justify == 'm') {
	 target = strlen(str);
	 x-= ((target * 4) /2);
  }

  while ((ch = *str++) != 0) {
	 plotthumbDHGR(ch,x,y,fg,bg);
	 x+=4;
  }
}


/* VBMP output routines */
/* VBMP requires a palette in the DHGR color order

   My Apple II routines whether in cc65, Aztec C65, or in my converters
   always use the LORES color order. LORES, Double LORES, and DHGR all use
   the same colors so it seems rather silly to use a different index value
   for DHGR in re-usable program code.

   However, since VBMP doesn't really care about the color palette in a BMP
   and just the order of the palette, we need to remap the palette and the
   scanline palette indices to DHGR color order.


*/

uint16_t WriteVbmpHeader(FILE *fp)
{
    uint16_t outpacket;
    int c, i, j;

    /* BMP scanlines are padded to a multiple of 4 bytes (DWORD) */
    outpacket = (uint16_t)72;

    if (mono != 0 || hgroutput == 1) {
		if (hgroutput == 1) {
			outpacket = 36;
			c = fwrite(mono280,1,sizeof(mono192),fp);
		}
		else {
			c = fwrite(mono192,1,sizeof(mono192),fp);
		}
		if (c!= sizeof(mono192))return 0;
        return outpacket;
	}

    memset((char *)&mybmp.bfi.bfType[0],0,sizeof(BMPHEADER));

    /* create the info header */
    mybmp.bmi.biSize = (uint32_t)40;
    mybmp.bmi.biWidth  = (uint32_t)140;
    mybmp.bmi.biHeight = (uint32_t)192;
    mybmp.bmi.biPlanes = 1;
    mybmp.bmi.biBitCount = 4;
    mybmp.bmi.biCompression = (uint32_t) BI_RGB;

    mybmp.bmi.biSizeImage = (uint32_t)outpacket;
	mybmp.bmi.biSizeImage *= mybmp.bmi.biHeight;

    /* create the file header */
    mybmp.bfi.bfType[0] = 'B';
    mybmp.bfi.bfType[1] = 'M';
    mybmp.bfi.bfOffBits = (uint32_t) sizeof(BMPHEADER) + sizeof(RGBQUAD) * 16;
    mybmp.bfi.bfSize = mybmp.bmi.biSizeImage + mybmp.bfi.bfOffBits;

 	/* write the header for the output BMP */
    c = fwrite((char *)&mybmp.bfi.bfType[0],sizeof(BMPHEADER),1,fp);

    if (c!= 1)return 0;

    /* use the current conversion palette for the VBMP palette */
    /* rather than the preview palette */
    for (i=0;i<16;i++) {
		j = RemapLoToHi[i];
		sbmp[i].rgbRed   = rgbVBMP[j][RED];
		sbmp[i].rgbGreen = rgbVBMP[j][GREEN];
    	sbmp[i].rgbBlue  = rgbVBMP[j][BLUE];

	}

	/* write the palette for the output bmp */
	c = fwrite((char *)&sbmp[0].rgbBlue, sizeof(RGBQUAD)*16,1,fp);
	if (c!= 1)return 0;

return outpacket;
}

/* decodes scanlines from hgr or dhgr monochrome buffer */
void applemonobites(int y, int doubleres)
{
	    int xoff,idx;
	    unsigned char *ptraux, *ptrmain, ch;

	    xoff = HB[y];
	    ptraux  = (unsigned char *) &dhrbuf[xoff-0x2000];
	    ptrmain = (unsigned char *) &dhrbuf[xoff];

        xoff = 0;
        for (idx = 0; idx < 40; idx++) {

            ch = ptraux[idx];

            buf280[xoff] = ((ch) &1); xoff++;
            buf280[xoff] = ((ch >> 1) &1); xoff++;
            buf280[xoff] = ((ch >> 2) &1); xoff++;
            buf280[xoff] = ((ch >> 3) &1); xoff++;
            buf280[xoff] = ((ch >> 4) &1); xoff++;
            buf280[xoff] = ((ch >> 5) &1); xoff++;
            buf280[xoff] = ((ch >> 6) &1); xoff++;

            if (doubleres == 0) continue;

            ch = ptrmain[idx];

            buf280[xoff] = ((ch) &1); xoff++;
            buf280[xoff] = ((ch >> 1) &1); xoff++;
            buf280[xoff] = ((ch >> 2) &1); xoff++;
            buf280[xoff] = ((ch >> 3) &1); xoff++;
            buf280[xoff] = ((ch >> 4) &1); xoff++;
            buf280[xoff] = ((ch >> 5) &1); xoff++;
            buf280[xoff] = ((ch >> 6) &1); xoff++;

 		}
}

/* encodes monochrome bmp scanline */
void ibmmonobites()
{
     int i,j,k;
     unsigned char bits[8];

     j=0;
     for(i=0;i<35;i++)
     {
        for(k=0;k<8;k++)
        {
		  bits[k] = buf280[j]; j++;
		}
		bmpscanline[i] = (bits[0]<<7|bits[1]<<6|bits[2]<<5|bits[3]<<4|
                          bits[4]<<3|bits[5]<<2|bits[6]<<1|bits[7]);
     }
}


/* writes VBMP compatible 140 x 192 x 16 color bmp or VBMP monochrome bmp in 2 sizes */
int WriteVBMPFile()
{

    FILE *fp;
    uint8_t ch;
	int x,x1,y,y2,idx,j,packet=72;

	if (hgroutput == 1) packet = 36;

	fp = fopen(vbmpfile,"wb");

	if (fp == NULL) {
		printf("Error opening %s for writing!\n",vbmpfile);
		return INVALID;
	}

	if (WriteVbmpHeader(fp) == 0) {
		fclose(fp);
		remove(vbmpfile);
		printf("Error writing header to %s!\n",vbmpfile);
		return INVALID;
	}
	memset(&bmpscanline[0],0,packet);

    /* write 4 bit packed scanlines */
    /* remap from LORES color order to DHGR color order */
    /* VBMP does not use the colors in the palette, just the color order */

    y2 = 191;
   	for (y = 0; y< 192; y++) {
	   if (hgroutput == 1) {
		   applemonobites(y2,0);
		   ibmmonobites();
	   }
	   else {
		   for (x = 0, x1=0; x < 140; x++) {
			  if (x%2 == 0) {
				idx = dhrgetpixel(x,y2);
				/* range check */
				if (idx < 0 || idx > 15)idx = 0; /* default black */
				j = RemapLoToHi[idx];
				ch = (uint8_t)j << 4;
			  }
			  else {
				idx = dhrgetpixel(x,y2);
				/* range check */
				if (idx < 0 || idx > 15)idx = 0; /* default black */
				j = RemapLoToHi[idx];
				bmpscanline[x1] = ch | (uint8_t)j; x1++;
			  }
		   }
   	   }

	   fwrite((char *)&bmpscanline[0],1,packet,fp);
	   y2 -= 1;
    }

    fclose(fp);
    if (quietmode == 1)printf("%s created!\n",vbmpfile);
    return SUCCESS;

}


/* plain old HGR transformation routines for DHGR 6-color HGR pseudo-output */
/* encodes apple II hgr scanline into buffer */
void hgrbits(int y)
{
	    int xoff,idx,jdx;
	    unsigned char *ptr, bits[7], x1, palettebit;

	    xoff = HB[y]-0x2000;
	    ptr  = (unsigned char *) &hgrbuf[xoff];

        xoff = 0;
        for (idx = 0; idx < 40; idx++) {

            for (jdx = 0; jdx < 7; jdx++) {
				bits[jdx] = buf280[xoff]; xoff++;
			}
			palettebit = palettebits[idx];

			x1 = (palettebit | bits[6]<<6|bits[5]<<5|bits[4]<<4|
                        bits[3]<<3|bits[2]<<2|bits[1]<<1|bits[0]);

            ptr[idx] = x1;
		}
}

void buildhgr()
{
	 int i, j;

     /* create bit pattern from pixelized values */
     /* i is even and j is odd */
	 for (i= 0, j = 1; i < 280; i+=2, j+=2) {
		buf280[i] = 0; /* assume everything is black */
		buf280[j] = 0;

        /* add the white bits - this also accounts for the half shift of
           the color pixels which applewin renders as white to represent
           aliasing of the color anomalies */

        if (doublewhite == 1) {
			/* if double white is on, set the white pixels in pairs */
			if (work280[i] == HWHITE || work280[j] == HWHITE) {
				buf280[i] = buf280[j] = 1;
			}
		}
		else {
			/* otherwise set white pixels individually */
			if (work280[i] == HWHITE) buf280[i] = 1;
			if (work280[j] == HWHITE) buf280[j] = 1;
		}

        /* if double colors is on, set the color pixels in pairs */
        if (doublecolors == 1) {
			/* add the violet or blue bits - the 2-bit value will be 2 */
			if (work280[i] == HBLUE || work280[i] == HVIOLET ||
			    work280[j] == HBLUE || work280[j] == HVIOLET ) {
					buf280[i] = 1;
					buf280[j] = 0;
			}

			/* add the green or orange bits - the 2-bit value will be 1 */
			if (work280[i] == HORANGE || work280[i] == HGREEN ||
			    work280[j] == HORANGE || work280[j] == HGREEN ) {
					buf280[i] = 0;
					buf280[j] = 1;
			}

		}
		else {
			/* otherwise set the colors individually if double colors is off */
			/* add the violet or blue bits - the 2-bit value will be 2 */
			if (work280[i] == HBLUE || work280[i] == HVIOLET )buf280[i] = 1;
			if (work280[j] == HBLUE || work280[j] == HVIOLET )buf280[j] = 0;

			/* add the green or orange bits - the 2-bit value will be 1 */
			if (work280[i] == HORANGE || work280[i] == HGREEN )buf280[i] = 0;
			if (work280[j] == HORANGE || work280[j] == HGREEN )buf280[j] = 1;
		}

        if (doubleblack == 1) {
		  /* be careful here - this can foul the colors */
		  if (work280[i] == HBLACK || work280[j]==HBLACK) {
		  		buf280[i] = 0;
		  		buf280[j] = 0;
		  }
		}

	 }

}

void hgrline(int y)
{
     int x,i,j,k,l, green, orange;
     unsigned char c, p;

     /* read the 6-color DHGR buffer and translate to HGR */
     /* since DHGR is 140 pixels in width and HGR is 280, double each pixel */
     /* HGR is only 140 color pixels in width so effective color resolution is identical */
     /* this is a really slack method of converting to HGR because it ignores the half-pixel shift for black and white
        pixels so technically half the available detail is lost on images with large areas of black and white but
        generally on complex images with lots of colors artifacting is minimized by doubling-up

        some of my other converters like Bmp2RAG offer more options but they don't provided dithering.

        */

    /* double colors */
	for (x=0,i=0,j=1;x<140;x++,i+=2,j+=2) {
		/* get the DHGR color */
		k = dhrgetpixel(x,y);
		/* remap to the HGR color indices */
		work280[i] = work280[j] = dhgr2hgr[k];
	}

    /* single colors - shift image right by one nominal pixel */
    /* otherwise this setting will have no effect */
 	if (doublecolors == 0) {
	   for (x = 279;x > 0;x--) {
		   work280[x] = work280[x-1];
	   }
    }

	buildhgr();

     /* set the HGR palette based on groups of seven HGR pixels */
	if (hgrpaltype == 0 || hgrpaltype == 0x80) {
		/* single palette over-ride... 4 color output. all non-black and
		   non-white pixels will be converted to either Green-Violet or
		   Orange-Blue */
		for (i = 0; i < 40; i++) palettebits[i] = hgrpaltype;
	}
	else {
		 /* seed palette hi-bit with some value */
		 if (hgrcolortype == 'G' || hgrcolortype == 'V') p = 0;
		 else p = 0x80;

		 /* go through the 280 pixel scanline and determine precedence of colors
		    for the palette bit settings based on the command option selected. */

		 for (i = 0, k=0; i < 40; i++ ) {
			 orange = 0;
			 green = 0;
			 for (j = 0; j < 7; j++) {
				 /* count in groups of 7 pixels (really 3.5 color pixels) */
				 if (work280[k] == HORANGE ||  work280[k] == HBLUE) orange++;
				 if (work280[k] == HGREEN ||  work280[k] == HVIOLET) green++;
				 k++;
			 }

			 if (hgrcolortype == 'O') {
				 /* big orange - one orange pixel sets the palette */
				 /* orange blue */
				 if (orange > 0) p = 0x80;
				 else {
					if (green > 0) p = 0;
				 }
			 }
			 else if (hgrcolortype == 'G') {
				 /* big green - one green pixel sets the palette */
				 /* green violet */
				 if (green > 0) p = 0;
				 else {
					if (orange > 0) p = 0x80;
				 }
			 }
			 else {
				/* normal precedence - the dominant color group sets the palette */
			 	if (green > orange) p = 0;
			 	else if (orange > green) p = 0x80;
			 	else {
					/* but if both groups are equal then 3 - options for behaviour */
					/* little green - equal green and orange sets the palette to green */
					if (hgrcolortype == 'V' && green == orange) p = 0;
					/* little orange - equal green and orange sets the palette to orange */
					else if (hgrcolortype == 'B' && orange == green) p = 0x80;
					else if (orange > 0) {
						 /* it was either do this or carry the previous palette bit setting forward */
						 if (hgrcolortype == 'G' || hgrcolortype == 'V') p = 0;
		 				 else p = 0x80;
					}
				}
			 }
			 palettebits[i] = p;
		 }
	 }
}



/* routines to save to Apple 2 Lores Format */

#define LORAGWIDTH  80
#define LORAGHEIGHT 48
#define LORAGSIZE   1920
#define LOTOPSIZE   1600
#define LOBINSIZE   1016


/* Lo-Res and Double Lo-Res Routines */

/* The Lo-Res Display has a resolution of 40 x 48 x 16 colors.

   The Double Lo-Res display has a resolution of 80 x 48 x 16 colors.

   In either case, these are the same 16 colors used by the DHGR display.

   The nominal resolution for a Double Lo-Res Screen is 320 x 192

/* routines to save to Apple 2 Lores Format */

/* sets the pixels in the lores buffer (hgrbuf) */
void setlopixel(unsigned char color,int x, int y,int ragflag)
{
     unsigned char *crt, c1, c2;
     int y1, offset;

     y1 = y / 2;

     c2 = (unsigned char ) (color & 15);

     if (y%2 == 0) {
		 /* even rows in low nibble */
		 /* mask value to preserve high nibble */
		 c1 = 240;
	 }
	 else {
		 /* odd rows in high nibble */
		 /* mask value to preserve low nibble */
		 c1 = 15;
		 c2 = c2 * 16;
	 }

     if (ragflag)
		 offset = (y1 * 80) + x;
     else
		 offset = (textbase[y1]-1024)+x;

	 crt = (unsigned char *)&hgrbuf[offset];
     crt[0] &= c1;
     crt[0] |= c2;
}


/* save LGR or DLGR output files in either raster-oriented or BSAVE format */
/* only full-screen (48 line) or mixed-screen (40 line) files are supported for raster-oriented files */
/* only full-sceen format is supported for BSAVE files */
/* image fragments are not supported */
int savelofragment()
{

	FILE *fp;
	unsigned char outfile[MAXF], temp, remap;
	int x,y,x2,y2, offset;
	uint16_t fl = 1016; /* default LGR or DLGR file size in bytes - BSAVE format */

   /* raster files - single file output */
   if (applesoft == 0) {
	   /* save single lo-res and double lo-res */
	   /* save raster images of 48 or 40 scanlines
		  (full graphics or mixed text and graphics) */

		if (lores == 1) {
			if (appletop == 1) {
				fl = 802;
				sprintf(outfile,"%s.STO",hgrwork);
			}
			else {
				fl = 962;
				sprintf(outfile,"%s.SLO",hgrwork);
			}
		}
		else {
			if (appletop == 1) {
				fl = 1602;
				sprintf(outfile,"%s.DTO",hgrwork);
			}
			else {
				fl = 1922;
				sprintf(outfile,"%s.DLO",hgrwork);
			}
		}
        if (tags == 1) {
			strcat(outfile,"#060400");
		}
		fp = fopen(outfile,"wb");
		if (NULL == fp)return INVALID;
		WriteDosHeader(fp,fl,1024);

		/* On the double lo res display each byte in
		high memory is interleaved with a byte in low memory
		in the interests of efficiency I am saving and loading
		the interleaf on a scanline by scanline basis.
		*/
		memset(hgrbuf,0,LORAGSIZE);
		for (y = 0; y< 48; y++) {
			if (appletop == 1 && y > 39)break;
			y2 = y;
			/* first 40 bytes goes to auxiliary memory (even pixels) */
			for (x = 0; x < 40; x++) {
				x2 = (x*2);
				remap = dhrgetpixel(x2,y2);
				temp = dloauxcolor[remap];
				setlopixel(temp,x,y,1);
			}
			/* followed by the interleaf (odd pixels)
			   next 40 bytes goes to main memory */
			for (x = 0; x < 40; x++) {
				x2 = (x*2) + 1;
				temp = dhrgetpixel(x2,y2);
				setlopixel(temp,x+40,y,1);
			}
		}
		if (lores == 1) {
			fputc(40,fp); /* bytes */
			if (appletop == 1) fputc(20,fp);
			else fputc(24,fp);

			for (y = 0; y < 24; y++) {
				if (appletop == 1 && y > 19)break;
				offset = (y * 80)+40;
				fwrite((unsigned char *)&hgrbuf[offset],1,40,fp);
			}
		}
		else {
			fputc(80,fp); /* bytes */
			if (appletop == 1) {
				fputc(20,fp); /* bytes (rasters / 2) */
				fwrite(hgrbuf,1,LOTOPSIZE,fp);
			}
			else {
				fputc(24,fp); /* bytes (rasters / 2) */
				fwrite(hgrbuf,1,LORAGSIZE,fp);
			}
		}
		fclose(fp);
		printf("%s Saved!",outfile);
	}
	else {

		/* bsaved images */
		/* 2 files for double lo-res */
		/* one file for lo-res */

		/* these cannot be loaded in a ProDOS BASIC program and should
		   probably not be loaded in a C program */
		/* they are arguably unsafe to load even in DOS 3.3
		   since they clobber the text screen holes */

		/* for double lo-res the bsaved images are split into two files
		   the first file is loaded into aux mem
		 */
		if (lores == 0) {
			sprintf(outfile,"%s.DL1",hgrwork);
			if (tags == 1) {
				strcat(outfile,"#060400");
			}
			fp = fopen(outfile,"wb");
			if (NULL == fp)return INVALID;
			WriteDosHeader(fp,fl,1024);

			memset(hgrbuf,0,LOBINSIZE);
			for (y = 0; y< 48; y++) {
				y2 = y;
				for (x = 0; x < 40; x++) {
					x2 = (x*2);
					remap = dhrgetpixel(x2,y2);
					temp = dloauxcolor[remap];
					setlopixel(temp,x,y,0);
				}
			}
			fwrite(hgrbuf,1,LOBINSIZE,fp);
			fclose(fp);
			printf("%s Saved!",outfile);
		}

		/*
		for single lo res only 1 file is needed
		for double lo res the second file is loaded into main mem
		*/
		if (lores == 1)
			sprintf(outfile,"%s.SL2",hgrwork);
		else
			sprintf(outfile,"%s.DL2",hgrwork);
		if (tags == 1) {
			strcat(outfile,"#060400");
		}
		fp = fopen(outfile,"wb");
		if (NULL == fp)return INVALID;
		WriteDosHeader(fp,fl,1024);
		memset(hgrbuf,0,LOBINSIZE);
		for (y = 0; y< 48; y++) {
			y2 = y;
			for (x = 0; x < 40; x++) {
				x2 = (x*2) + 1;
				temp = dhrgetpixel(x2,y2);
				setlopixel(temp,x,y,0);
			}
		}
		fwrite(hgrbuf,1,LOBINSIZE,fp);
		fclose(fp);
		printf("%s Saved!",outfile);
	}

	return SUCCESS;
}



/* save both raw output file formats */
int savedhr()
{

	FILE *fp;
	int c,y;

    if (outputtype != BIN_OUTPUT) return SUCCESS;

    if (loresoutput == 1) {
		savelofragment();
		return SUCCESS;
	}

    /* titling from text files if found */
    GetUserTextFile();


    if (hgroutput == 1) {
		/* just using the BIN file extension as always */
		if (mono == 0) {
			strcpy(mainfile,hgrcolor);
        	memset(hgrbuf,0,8192);
			for (y = 0; y < 192; y++) {
     			hgrline(y); /* translate from DHGR and format the HGR line */
				hgrbits(y); /* put the HGR line into the HGR file buffer */
			}
		}
		else {
			strcpy(mainfile,hgrmono);
		}
		fp = fopen(mainfile,"wb");
		if (NULL == fp) {
			if (quietmode == 1)printf("Error Opening %s for writing!\n",mainfile);
			return INVALID;
		}

		WriteDosHeader(fp,8192,8192);

		if (mono == 1) c = fwrite(dhrbuf,1,8192,fp);
		else c = fwrite(&hgrbuf[0],1,8192,fp);
		fclose(fp);
		if (c != 8192) {
			remove(mainfile);
			if (quietmode == 1)printf("Error Writing %s!\n",mainfile);
			return INVALID;
		}

		if (quietmode == 1) printf("%s created!\n",mainfile);
		if (vbmp != 0) {
			/* additional BMP file for Cybernesto's VBMP */
			if (mono == 0) memcpy(&dhrbuf[0],&hgrbuf[0],8192);
			WriteVBMPFile();
		}
		return SUCCESS;
	}

    if (applesoft == 0) {

		fp = fopen(a2fcfile,"wb");
		if (NULL == fp) {
	    	if (quietmode == 1)printf("Error Opening %s for writing!\n",a2fcfile);
			return INVALID;
		}

		WriteDosHeader(fp,16384,8192);

		c = fwrite(dhrbuf,1,16384,fp);
		fclose(fp);

		if (c != 16384) {
			remove(a2fcfile);
			if (quietmode == 1)printf("Error Writing %s!\n",a2fcfile);
			return INVALID;
		}
		if (quietmode == 1)printf("%s created!\n",a2fcfile);
		if (vbmp != 0) {
			/* additional BMP file for Cybernesto's VBMP */
			WriteVBMPFile();
		}
		return SUCCESS;
	}


    /* the bsaved images are split into two files
       the first file is loaded into aux mem */
   	fp = fopen(auxfile,"wb");
	if (NULL == fp) {
	    if (quietmode == 1)printf("Error Opening %s for writing!\n",auxfile);
		return INVALID;
	}
	WriteDosHeader(fp,8192,8192);
	c = fwrite(dhrbuf,1,8192,fp);
	fclose(fp);
	if (c != 8192) {
		remove(auxfile);
		if (quietmode == 1)printf("Error Writing %s!\n",auxfile);
		return INVALID;
	}

    /* the second file is loaded into main mem */
	fp = fopen(mainfile,"wb");
	if (NULL == fp) {
		remove(auxfile);
		if (quietmode == 1)printf("Error Opening %s for writing!\n",mainfile);
		return INVALID;
	}
	WriteDosHeader(fp,8192,8192);
	c = fwrite(&dhrbuf[8192],1,8192,fp);
	fclose(fp);
	if (c != 8192) {
		/* remove both files */
		remove(auxfile);
		remove(mainfile);
		if (quietmode == 1)printf("Error Writing %s!\n",mainfile);
		return INVALID;
	}

	if (quietmode == 1) {
		printf("%s created!\n",auxfile);
		printf("%s created!\n",mainfile);
	}

	if (vbmp != 0) {
		/* additional BMP file for Cybernesto's VBMP */
		WriteVBMPFile();
	}

	return SUCCESS;
}


int saverag()
{
	FILE *fp;
	/* make an Rasterized Apple II Graphic (RAG) */
    int c, x, y, xoff, width;
    unsigned char *ptr;

    if (scale == 1) spritewidth = bmpwidth;
    else spritewidth = bmpwidth * 2;

    if (spritewidth < 1) {
	   printf("Width is too small for %s!\n",spritefile);
	   return INVALID;
    }

    memset(hgrbuf,0,8192);
	for (y = 0; y < 192; y++) {
     	hgrline(y); /* translate from DHGR and format the HGR line */
		hgrbits(y); /* put the HGR line into the HGR file buffer */
	}

    width = spritewidth;
    while (width%7 != 0)width++; /* multiples of 7 pixels */
    /* if we have an orphan pixel hanging at the edge of an even byte
       increase the width to the next 7 pixels */
    if (width == spritewidth && (width % 14) != 0) width += 7;
	width /= 7;
	if (width > 40)width = 40; /* likely not necessary */

    /* over-ride for default .RAG file extension */
    /* use .BOT extension for full-screen */
    /* use .TOP extension for mixed-screen */
    if (width == 40 && (bmpheight == 160 || bmpheight == 192)) {
		x = 999;
		for (y=0;spritefile[y] != (char)0;y++) {
			if (spritefile[y] == '.') x = y;
		}
		if (x != 999) {
			spritefile[x+2] = 'O';
			if (bmpheight == 160) {
				spritefile[x+1] = 'T'; spritefile[x+3] = 'P';
			}
			else {
			    spritefile[x+1] = 'B'; spritefile[x+3] = 'T';
			}
		}
	}

	fp = fopen(spritefile,"wb");
	if (NULL == fp) {
		printf("Error Opening %s for writing!\n",spritefile);
		return INVALID;
	}

	/* write 2 byte header */
	fputc((uint8_t)width,fp);          /* width in bytes */
	fputc((uint8_t)bmpheight,fp);      /* height in scanlines */

    for (y = 0; y < bmpheight; y++) {
	    xoff = HB[y] - 0x2000;
    	ptr  = (unsigned char *) &hgrbuf[xoff];
		c = fwrite(ptr,1,width,fp);
		if (c!=width) break;

	}
	fclose(fp);

	if (c!=width) {
		remove(spritefile);
	    printf("Error Writing %s!\n",spritefile);
	    return INVALID;
	}

	printf("%s created!\n",spritefile);
    return SUCCESS;
}

/* save raster oriented DHGR image fragment

   file format is 5 byte header

   3 - upper case ID bytes 'D' 'H' 'R' for a sprite
   3 - upper case ID bytes 'D' 'H' 'M' for a sprite-mask

   1 byte - width in bytes (multiples of 4 bytes - 7 pixels)
   1 byte - height in rasters

   followed by interleaved raster data

   aux raster, main raster = (width in bytes)
   aux raster, main raster = (width in bytes)
   aux raster, main raster = (width in bytes)
   etc...

*/
int savesprite()
{

	FILE *fp;
	int i, c, width, packet, x, y, xoff, cnt;
	uint16_t fl;
	uint8_t *ptraux, *ptrmain, ch;

    if (outputtype != SPRITE_OUTPUT) return SUCCESS;

	if (hgroutput == 1) return saverag();

    /* if scaling is turned-on the sprite matrix is 280 x 192 so for every 2-pixels
       in the BMP only 1-pixel will be in the sprite. BMPs over 140 x 192 implictly
       and automatically turn-on scaling whether sprite mode is selected (option "F")
       or not.
       */
    if (scale == 1) spritewidth = bmpwidth / 2;
    else spritewidth = bmpwidth;

    if (spritewidth < 1) {
	   if (quietmode == 1)printf("Width is too small for %s!\n",spritefile);
	   return INVALID;
    }
    while (spritewidth%7 != 0) spritewidth++;

    width = (int)((spritewidth / 7) * 4); /* 4 bytes = 7 pixels */
    packet = (int)width / 2;

    /* prepare either an image fragment or a mask for the image fragment */
    /* the idea for a mask is to provide a background mixing map for the image fragment */
    if (spritemask != 1) {
		fp = fopen(spritefile,"wb");
		if (NULL == fp) {
	    	if (quietmode == 1)printf("Error Opening %s for writing!\n",spritefile);
			return INVALID;
		}
	}
	else {
		fp = fopen(fmask,"wb");
		if (NULL == fp) {
			if (quietmode == 1)printf("Error Opening %s for writing!\n",fmask);
			return INVALID;
		}
		/* transform the buffer to a black and white mask for the sprite */
		/* the background is black and the foreground is white */
		/* this allows a rendered sprite to be prepared independently of the mask */
		/* and to contain the background color in any rendering or dithering that goes-on */
		for (y = 0; y < bmpheight; y ++) {
			for (x = 0; x < spritewidth; x++) {
        		if (dhrgetpixel(x,y) == backgroundcolor) ch = 0;
		 		else ch = 15;
		 		dhrplot(x,y,ch);
			}
		}
		/* now that we have transformed the image into a mask for mixing the sprite
		   with a background image we save it in the same format as the sprite
		   but as a DHM file rather than a DHR file */

		/* append M for mask to the array basename */
		if (quietmode == 0) strcat(fname,"M");

	}

	if (dosheader == 1) {
		fl = (uint16_t) width;
		fl *=bmpheight;
		fl += 5;
		WriteDosHeader(fp,fl,8192);
	}

	/* 5 byte header */
	/* some kind of identifier */
	fputc('D',fp);
    fputc('H',fp);
    if (spritemask != 1) fputc('R',fp);
    else fputc('M',fp);

	fputc((uint8_t)width,fp);          /* width in bytes */
	fputc((uint8_t)bmpheight,fp);      /* height in scanlines */

     /* write header values to stdout */
	if (quietmode == 0) {
		printf("#define %sWIDTH  %d\n",fname,width);
		printf("#define %sHEIGHT %d\n",fname,bmpheight);
		printf("#define %sSIZE   %d\n\n",fname,width * bmpheight);

		/* if we are writing a mask, background color is irrelevant */
		/* the whole idea behind background color is the same as a mask */

		if (spritemask != 1) printf("uint8_t %sBackgroundColor = %d;\n\n",fname,backgroundcolor);

		printf("/* Embedded DHGR Image Fragment created from %s */\n\n",bmpfile);
        printf("uint8_t %sPixelData[] = {\n",fname);
	}

	for (y = 0, cnt = 0; y < bmpheight; y++) {
		xoff = HB[y];
		ptraux  = (uint8_t *) &dhrbuf[xoff-0x2000];
		ptrmain = (uint8_t *) &dhrbuf[xoff];
		/* aux raster */
		c = fwrite((char *)&ptraux[0],1,packet,fp);
		if (c!= packet) break;
		/* main raster */
		c = fwrite((char *)&ptrmain[0],1,packet,fp);
		if (c!= packet) break;

		if (quietmode == 0) {
			for (i=0;i<width;i++) {
				if (i <packet)ch = ptraux[i];
				else ch = ptrmain[i-packet];
				if (cnt == 0) {
					printf("%3d",ch);
				}
				else {
					printf(",");
					if (cnt%16 == 0) printf("\n");
					printf("%3d",ch);
				}
				cnt++;
			}
		}
	}
	if (quietmode == 0) printf("};\n\n");
	fclose(fp);

	if (c!=packet) {
		if (spritemask != 1) {
			remove(spritefile);
	    	if (quietmode == 1)printf("Error Writing %s!\n",spritefile);
		}
		else {
			remove(fmask);
	    	if (quietmode == 1)printf("Error Writing %s!\n",fmask);
		}
	    return INVALID;
	}

	if (quietmode == 1) {
		if (spritemask != 1) printf("%s created!\n",spritefile);
		else printf("%s created!\n",fmask);
	}

	return SUCCESS;
}


/* read and remap a mask line from an open mask file */
/* required by dithered and non-dithered routines when in use */
int16_t ReadMaskLine(uint16_t y)
{
	uint32_t pos;
	uint16_t x, packet;
	uint8_t ch;

	if (overlay == 0) return INVALID;

	if (mono == 1) {
		/* two sizes for mono overlays depending on output */
		/* 560 x 192 DHGR overlay or 280 x 192 HGR overlay */
		if (hgroutput == 1) packet = 280;
		else packet = 560;
	}
	else packet = 140;

	pos = (uint32_t) (191 - y);
    pos *= packet;
    pos += maskbmp.bfi.bfOffBits;

    fseek(fpmask,pos,SEEK_SET);
	fread((char *)&maskline[0],1,packet,fpmask);
	for (x = 0; x < packet; x++) {
		ch = maskline[x];
		maskline[x] = remap[ch];
	}
	return SUCCESS;
}


/*

http://www.efg2.com/Lab/Library/ImageProcessing/DHALF.TXT


The Floyd-Steinberg filter

This is where it all began, with Floyd and Steinberg's pioneering
research in 1975.  The filter can be diagrammed thus:


          *   7
      3   5   1     (1/16)


In this (and all subsequent) filter diagrams, the "*" represents the pixel
currently being scanning, and the neighboring numbers (called weights)
represent the portion of the error distributed to the pixel in that
position.  The expression in parentheses is the divisor used to break up the
error weights.  In the Floyd-Steinberg filter, each pixel "communicates"
with 4 "neighbors."  The pixel immediately to the right gets 7/16 of the
error value, the pixel directly below gets 5/16 of the error, and the
diagonally adjacent pixels get 3/16 and 1/16.

The weighting shown is for the traditional left-to-right scanning of the
image.  If the line were scanned right-to-left (more about this later), this
pattern would be reversed.  In either case, the weights calculated for the
subsequent line must be held by the program, usually in an array of some
sort, until that line is visited later.

Floyd and Steinberg carefully chose this filter so that it would produce a
checkerboard pattern in areas with intensity of 1/2 (or 128, in our sample
image).  It is also fairly easy to execute in programming code, since the
division by 16 is accomplished by simple, fast bit-shifting instructions
(this is the case whenever the divisor is a power of 2).

*/

/*

Floyd-Steinberg dithering published by Robert Floyd and Louis Steinberg in
1976 was the first 2D error diffusion dithering formula.(Filter Lite is an
algorithm by Sierra that produces similar results.) Floyd-Steinberg dithering
only diffuses the error to neighbouring pixels. This results in very
fine-grained dithering.

In the same year a much more powerful algorithm was also published: Jarvis,
Judice, and Ninke. (Sierra dithering and Sierra 2 are based on Jarvis
dithering, and produce similar results. Atkinson dithering resembles Jarvis
dithering and Sierra dithering; speckling is improved but very light and dark
areas may appear blown out.) Jarvis dithering is coarser than Floyd-Steinberg,
but has fewer visual artifacts.

Five years after Jarvis dithering, Peter Stucki published an adjusted version,
to improve processing time. Its output tends to be clean and sharp.

Seven years after Stucki published his improvement to Jarvis, Judice, Ninke
dithering, Daniel Burkes developed a simplified form of Stucki dithering that
is somewhat less clean and sharp.

*/


/* setting clip to 0 increases the potential amount of retained error */
/* error is accumulated in a short integer and may be negative or positive */
uint8_t AdjustShortPixel(int clip,int16_t *buf,int16_t value)
{

    if (globalclip == 1) clip = 1;

    value = (int16_t)(buf[0] + value);
    if (clip != 0) {
    	if (value < 0) value = 0;
    	else if (value > 255) value = 255;
	}
    buf[0] = value;
   	if (clip == 0) {
    	if (value < 0) value = 0;
    	else if (value > 255) value = 255;
	}
    return (uint8_t) value;
}



/* helper function for ReadCustomDither */
int InitCustomLine(char *ptr, int lidx)
{
	int cnt=0, i;

    customdither[lidx][cnt] = (int16_t) atoi(ptr);

    /* enforce 11 fields */
	for (i=0;ptr[i]!=0;i++) {
		if (ptr[i]== ',') {
			cnt++;
			if (cnt < 11) customdither[lidx][cnt] = (int16_t) atoi((char*)&ptr[i+1]);
		}
	}
	if (cnt != 10) return -1;
}


/* read a custom dither pattern from a comma delimited text file

   line 1 is the custom divisor
   the next 3 lines are 11 fields in the following format:

	0,0,0,0,0,*,0,0,0,0,0
	0,0,0,0,0,0,0,0,0,0,0
	0,0,0,0,0,0,0,0,0,0,0

	unused fields must be padded with zeros

	errata:

	- no range checking
    - current pixel (asterisk) at subscript 5 is not "protected"

*/
int ReadCustomDither(char *name)
{
	FILE *fp;
	char ch, buf[128];
	int i,j;

    /* clear 3-dimensional custom dither array */
    memset(&customdither[0][0],0,sizeof(int16_t)*33);

	fp = fopen(name,"r");
	if (NULL == fp) return -1;

	/* read divisor */
	for (;;) {
		if (NULL == fgets(buf, 128, fp)) {
	    	fclose(fp);
	    	return -1;
		}
		/* ignore comment lines and blank lines */
		ch = buf[0];
		/* leading numeric characters only */
		if (ch < 48 || ch > 57) continue;
		break;
	}
	customdivisor = (int16_t) atoi(buf);
	if (customdivisor < 1) {
		fclose(fp);
		return -1;
	}

    /* read up to 3 lines of dither pattern */
	for (i=0;;) {
		if (NULL == fgets(buf, 128, fp)) {
	    	fclose(fp);
	    	return -1;
		}
		/* ignore comment lines and blank lines */
		ch = buf[0];
		/* leading numeric characters only */
		if (ch < 48 || ch > 57) continue;
		/* condition line - remove trailing comments */
		for (j=0;buf[j]!=0;j++) {
			ch = buf[j];
			/* numeric characters are ok */
			if (ch > 47 && ch < 58) continue;
			/* commas and asterisks are ok */
			if (ch == ',' || ch == '*') continue;
			buf[j] = 0;
			break;
		}

        /* parse fields - there must be 11 fields */
		if(InitCustomLine((char *)&buf[0],i)==-1) {
			fclose(fp);
			return -1;
		}
		i++;
		if (i == 3) break;
	}
	fclose(fp);
	if (i == 0) return -1;

	if (quietmode == 1) {
		printf("Imported Dither from %s\n",name);
	}

    dither = CUSTOM;
    return SUCCESS;

}

/* http://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering */
/* http://www.tannerhelland.com/4660/dithering-eleven-algorithms-source-code/ */
/* http://www.efg2.com/Lab/Library/ImageProcessing/DHALF.TXT */
int run0=0, run1=0, run2=0;

void FloydSteinberg(int y, int width)
{

	double paldistance; /* not used in this function */
	int16_t red, green, blue, red_error, green_error, blue_error;
	int16_t pos, mult;
    int dx,i, x,x1, total_difference, total_error, total_used;
    int testrun, runs, temperror, z;
    uint8_t drawcolor, r,g,b;

   if (ditherstart == 0) {

	   /* for hgr color dithering cancel serpentine effect and go forward only
	   otherwise groups of 7 pixels for choosing between Orange and Green hgr
	   palettes becomes too complicated */

	   /* this solution may effect user definable dithering but it is up to the
		  user to make their own pattern work within the program's limitations
		  */
	   if (hgrdither == 1) serpentine = 0;

	   if (quietmode == 1) {
		  if (mono == 1) puts("Monochrome Dithered Output:");
		  else puts("Color Dithered Output:");

		  if (colorbleed < 100)
		   	printf("Dither = %d - %s, Color Bleed Increase: %d%%\n",dither,dithertext[dither-1],(colorbleed-100)*-1);
		  else if (colorbleed > 100)
		  	printf("Dither = %d - %s, Color Bleed Reduction: %d%%\n",dither,dithertext[dither-1],(colorbleed-100));
		  else
		    printf("Dither = %d - %s\n",dither,dithertext[dither-1]);

		  if (serpentine == 1) puts("Serpentine effect is on!");

	   }
	   ditherstart = 1;
	   /* reduce or increase color bleed */
	   switch(dither) {
			case  FLOYDSTEINBERG: 	bleed = (16 * colorbleed)/100; break;
			case  JARVIS:			bleed = (48 * colorbleed)/100; break;
			case  STUCKI:			bleed = (42 * colorbleed)/100; break;
			case  ATKINSON:         bleed = (8  * colorbleed)/100; break;
			case  BURKES:
			case  SIERRA:           bleed = (32 * colorbleed)/100; break;
			case  SIERRATWO:        bleed = (16 * colorbleed)/100; break;
			case  SIERRALITE:       bleed = (4  * colorbleed)/100; break;
			case  CUSTOM:           bleed = (customdivisor * colorbleed)/100; break;
			default:				bleed = (8  * colorbleed)/100; break; /* same as atkinson */
		}
		if (bleed < 1) bleed = 1;
   }

   /* When converting to HGR do palette matching here between Green-Violet and
	  Orange-Blue palettes in groups of 7 pixels */

   /* from left to right */
   /* if we are dithering HGR we need to decide if we are using the Orange-Blue palette or
      the Green-Violet palette based on groups of 7 pixels */

   if (hgrdither == 1) {
	   testrun = 0;
	   /* the idea here is to work on a copy while we make the first two passes
	   to determine the palette */

	   /* on the third (and final) pass, we dither using the 4 color choice
	   with the lowest cumulative error for each 7 pixel group */

       /* this particular idea is based on how Sheldon Simms tohgr program
		  decides which palette to use but you probably wouldn't know that
		  by just looking at the code */

	   /* Clear the buffers */
	   memset(&OrangeBlueError[0],0,640);
	   memset(&GreenVioletError[0],0,640);
	   memset(&HgrPixelPalette[0],0,320);

	   /* save the original dither buffers */
	   /* work on a copy for the first two passes */
	   memcpy(&redSave[0],&redDither[0],640);
	   memcpy(&greenSave[0],&greenDither[0],640);
	   memcpy(&blueSave[0],&blueDither[0],640);
   }
   else {
	   testrun = 2;
   }

   /* if we are dithering color hgr, for the first two test passes, we don't
   bother to diffuse the error beyond the current scanline */

   /* it is not necessary to do so because all we are concerned with is the
   color of the transformed pixels on the current line, but it is necessary to
   dither the line completely in either palette in order to tansform the pixels
   in the current line */
   for (runs=testrun;runs<3;runs++) {

       /* big hgr color rigamorole here */
	   if (hgrdither == 1) {
	       if (runs == 1 || runs == 2) {
			    /* restore dither buffer after both test runs for the final run */
	   			memcpy(&redDither[0],&redSave[0],640);
	   			memcpy(&greenDither[0],&greenSave[0],640);
	   			memcpy(&blueSave[0],&blueDither[0],640);
		   }

           /* for the first two runs, dither7 does not change */
		   if (runs == 0) {
			   dither7 = 'O';
		   }
		   else if (runs == 1) {
			   dither7 = 'G';
		   }
		   else {
			    /* after the first two runs */
			    /* determine hgr palette for each pixel based on the first two
				   runs here before beginning the 3rd and final run */
		   		for (x = 0; x < width; x+=7) {
					red_error = green_error = 0;
					for (z = 0; z < 7; z++) {
						red_error += OrangeBlueError[x+z];
						green_error += GreenVioletError[x+z];
					}
					/* if the Green-Violet palette has the closest colors for
					   this group then use it. otherwise use the Orange-Blue
					   palette */
					if (green_error < red_error) dither7 = 'G';
					else dither7 = 'O';
					/* set the hgr palette for 7 pixels */
					for (z = 0; z < 7; z++) {
						HgrPixelPalette[x+z] = dither7;
					}
		   		}
		   }

	   }

	   for (x=0;x<width;x++) {

      	  red   = redDither[x];
          green = greenDither[x];
          blue  = blueDither[x];

		  r = (uint8_t)red;
		  g = (uint8_t)green;
		  b = (uint8_t)blue;

          /* for the final pass, use the best hgr 4 color palette, Orange-Blue
		  or Green-Violet */

          /* the palette to use for each pixel comes from an array that was
			 built based on the lowest 7 pixel cumulative error between the two
			 palettes that were tested on the first and second passes
			 respectively */
          if (hgrdither == 1 && runs == 2) dither7 = HgrPixelPalette[x];

		  drawcolor = GetDrawColor(r,g,b,x,y);

		  r = rgbArray[drawcolor][RED];
		  g = rgbArray[drawcolor][GREEN];
		  b = rgbArray[drawcolor][BLUE];

		  redDither[x]   = (int)r;
		  greenDither[x] = (int)g;
		  blueDither[x]  = (int)b;

		  /* the error is linear in this implementation */
		  /* - an integer is used so round-off of errors occurs
			 - also clipping of the error occurs under some circumstances
			 - no luminance consideration
			 - no gamma correction
		  */

		  red_error   = red - r;
		  green_error = green - g;
		  blue_error  = blue - b;

		  if (runs == 0 || runs == 1) {
			    /* for hgr color only accumulate total error per pixel for the first two passes */
			    /* use absolute error */
			    if (red_error < 0) temperror = red_error * -1;
			    else temperror = red_error;
			    if (green_error < 0) temperror += (green_error * -1);
			    else temperror += green_error;
			    if (blue_error < 0) temperror += (blue_error * -1);
			    else temperror += blue_error;

		  		if (runs == 0) OrangeBlueError[x] = temperror;
		  		else GreenVioletError[x] = temperror;

		  		/* before we do the third pass, these arrays will be processed in 7 pixel chunks
		  		   and the lowest cumulative error in each chunk will determine if the
		  		   Orange-Blue or Green-Violet hgr palette will be used for the 7 pixels in the chunk */

		  }

		for (i=0;i<3;i++) {

			/* loop through all 3 RGB channels */
			switch(i) {
				case RED:   colorptr = (int16_t *)&redDither[0];
							seedptr   = (int16_t *)&redSeed[0];
							seed2ptr  = (int16_t *)&redSeed2[0];
							color_error = red_error;
							break;
				case GREEN: colorptr = (int16_t *)&greenDither[0];
							seedptr   = (int16_t *)&greenSeed[0];
							seed2ptr  = (int16_t *)&greenSeed2[0];
							color_error = green_error;
							break;
				case BLUE:  colorptr = (int16_t *)&blueDither[0];
							seedptr   = (int16_t *)&blueSeed[0];
							seed2ptr  = (int16_t *)&blueSeed2[0];
							color_error = blue_error;
							break;
			}

			/* diffuse the error based on the dither */
			switch(dither) {
				/* F 1*/
				case FLOYDSTEINBERG:
					/*
						*   7
					3   5   1 	(1/16)

					Serpentine

					7   *
					1   5   3

					*/

					/* if error summing is turned-on add the accumulated rounding error
					   to the next pixel */
					if (errorsum == 0) {
						total_difference = 0;
					}
					else {
						total_error = (color_error * 16) / bleed;
						total_used =  (color_error * 3)/bleed;
						total_used += (color_error * 5)/bleed;
						total_used += (color_error * 1)/bleed;
						total_used += (color_error * 7)/bleed;
						total_difference = total_error - total_used;
					}

					/* for serpentine effect alternating scanlines run the error in reverse */
					if (serpentine == 1 && y%2 == 1) {
						/* finish this line */
						/* for serpentine effect line 1 error is added behind */
						if (x > 0) AdjustShortPixel(1,(int16_t *)&colorptr[x-1],(int16_t)((color_error * 7)/bleed)+total_difference);
						/* seed next line forward */
						/* for serpentine effect line 2 error is reversed */
						if (x>0)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)((color_error * 1)/bleed));
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)((color_error * 3)/bleed));

					}
					else {
						/* finish this line */
						AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)((color_error * 7)/bleed)+total_difference);

						/* if making hgr passes 0 and 1 dither first line only */
						if (runs < 2 || ditheroneline == 1) break;

						/* seed next line forward */
						if (x>0)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)((color_error * 3)/bleed));
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)((color_error * 1)/bleed));
					}

					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)((color_error * 5)/bleed));
					break;

				/* J 2 */
				case JARVIS:
					/*
						*   7   5
					3   5   7   5   3
					1   3   5   3   1	(1/48)
					*/

					/* finish this line */
					AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)((color_error * 7)/bleed));
					AdjustShortPixel(1,(int16_t *)&colorptr[x+2],(int16_t)((color_error * 5)/bleed));

					/* if making hgr passes 0 and 1 dither first line only */
					if (runs < 2 || ditheroneline == 1) break;

					/* seed next lines forward */
					if (x>0){
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)((color_error * 5)/bleed));
						AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x-1],(int16_t)((color_error * 3)/bleed));
					}
					if (x>1){
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x-2],(int16_t)((color_error * 3)/bleed));
						AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x-2],(int16_t)(color_error/bleed));

					}

					/* seed next line forward */
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)((color_error * 7)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)((color_error * 5)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+2],(int16_t)((color_error * 3)/bleed));

					/* seed furthest line forward */
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x],(int16_t)((color_error * 5)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x+1],(int16_t)((color_error * 3)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x+2],(int16_t)(color_error/bleed));
					break;

				/* S 3 */
				case STUCKI:
					/*
							*   8   4
					2   4   8   4   2
					1   2   4   2   1	(1/42)
					*/

					/* for serpentine effect alternating scanlines run the error in reverse */
					if (serpentine == 1 && y%2 == 1) {
						/* finish this line */
						if(x>0)AdjustShortPixel(1,(int16_t *)&colorptr[x-1],(int16_t)((color_error * 8)/bleed));
						if(x>1)AdjustShortPixel(1,(int16_t *)&colorptr[x-2],(int16_t)((color_error * 4)/bleed));

					}
					else {
						/* finish this line */
						AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)((color_error * 8)/bleed));
						AdjustShortPixel(1,(int16_t *)&colorptr[x+2],(int16_t)((color_error * 4)/bleed));
					}

					/* if making hgr passes 0 and 1 dither first line only */
					if (runs < 2 || ditheroneline == 1) break;

					/* seed next lines forward */
					if (x>0){
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)((color_error * 4)/bleed));
						AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x-1],(int16_t)((color_error * 2)/bleed));
					}
					if (x>1){
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x-2],(int16_t)((color_error * 2)/bleed));
						AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x-2],(int16_t)(color_error/bleed));

					}

					/* seed next line forward */
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)((color_error * 8)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)((color_error * 4)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+2],(int16_t)((color_error * 2)/bleed));

					/* seed furthest line forward */
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x],(int16_t)((color_error * 4)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x+1],(int16_t)((color_error * 2)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x+2],(int16_t)(color_error/bleed));
					break;

				/* A 4 */
				case ATKINSON:
					/*
						*   1   1
					1   1   1
						1			(1/8)

					*/

					/* for serpentine effect alternating scanlines run the error in reverse */
					if (serpentine == 1 && y%2 == 1) {
						/* finish this line */
						if (x>0)AdjustShortPixel(1,(int16_t *)&colorptr[x-1],(int16_t)(color_error/bleed));
						if (x>1)AdjustShortPixel(1,(int16_t *)&colorptr[x-2],(int16_t)(color_error/bleed));
					}
					else {
						/* finish this line */
						AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)(color_error/bleed));
						AdjustShortPixel(1,(int16_t *)&colorptr[x+2],(int16_t)(color_error/bleed));
					}

					/* if making hgr passes 0 and 1 dither first line only */
					if (runs < 2 || ditheroneline == 1) break;

					/* seed next line forward */
					if (x>0)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)(color_error/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)(color_error/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)(color_error/bleed));

					/* seed furthest line forward */
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x],(int16_t)(color_error/bleed));
					break;

				/* B 5 */
				case BURKES:
					/*
							*   8   4
					2   4   8   4   2	(1/32)
					*/

					/* for serpentine effect alternating scanlines run the error in reverse */
					if (serpentine == 1 && y%2 == 1) {
						/* finish this line */
						if(x>0)AdjustShortPixel(1,(int16_t *)&colorptr[x-1],(int16_t)((color_error * 8) /bleed));
						if(x>1)AdjustShortPixel(1,(int16_t *)&colorptr[x-2],(int16_t)((color_error * 4) /bleed));

					}
					else {
						/* finish this line */
						AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)((color_error * 8) /bleed));
						AdjustShortPixel(1,(int16_t *)&colorptr[x+2],(int16_t)((color_error * 4) /bleed));

					}

					/* if making hgr passes 0 and 1 dither first line only */
					if (runs < 2 || ditheroneline == 1) break;

					/* seed next line forward */
					if (x>0)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)((color_error * 4) / bleed));
					if (x>1)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-2],(int16_t)((color_error * 2) / bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)((color_error * 8) /bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)((color_error * 4) /bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+2],(int16_t)((color_error * 2) /bleed));
					break;

				/* SI 6 */
				case SIERRA:
					/*
							*   5   3
					2   4   5   4   2
						2   3   2		(1/32)
					*/
					/* for serpentine effect alternating scanlines run the error in reverse */
					if (serpentine == 1 && y%2 == 1) {
						/* finish this line */
						if(x>0)AdjustShortPixel(1,(int16_t *)&colorptr[x-1],(int16_t)((color_error * 5)/bleed));
						if(x>1)AdjustShortPixel(1,(int16_t *)&colorptr[x-2],(int16_t)((color_error * 3)/bleed));
					}
					else {
						/* finish this line */
						AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)((color_error * 5)/bleed));
						AdjustShortPixel(1,(int16_t *)&colorptr[x+2],(int16_t)((color_error * 3)/bleed));
					}

					/* if making hgr passes 0 and 1 dither first line only */
					if (runs < 2 || ditheroneline == 1) break;

					/* seed next lines forward */
					if (x>0){
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)((color_error * 4)/bleed));
						AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x-1],(int16_t)((color_error * 2)/bleed));
					}
					if (x>1){
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x-2],(int16_t)((color_error * 2)/bleed));
					}

					/* seed next line forward */
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)((color_error * 5)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)((color_error * 4)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+2],(int16_t)((color_error * 2)/bleed));

					/* seed furthest line forward */
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x],(int16_t)((color_error * 3)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x+1],(int16_t)((color_error * 2)/bleed));
					break;

				/* S2 7 */
				case SIERRATWO:
					/*
							*   4   3
					1   2   3   2   1	(1/16)
					*/

					/* for serpentine effect alternating scanlines run the error in reverse */
					if (serpentine == 1 && y%2 == 1) {
						/* finish this line */
						if(x>0)AdjustShortPixel(1,(int16_t *)&colorptr[x-1],(int16_t)((color_error*4)/bleed));
						if(x>1)AdjustShortPixel(1,(int16_t *)&colorptr[x-2],(int16_t)((color_error*3)/bleed));
					}
					else {
						/* finish this line */
						AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)((color_error*4)/bleed));
						AdjustShortPixel(1,(int16_t *)&colorptr[x+2],(int16_t)((color_error*3)/bleed));
					}

					/* if making hgr passes 0 and 1 dither first line only */
					if (runs < 2 || ditheroneline == 1) break;

					/* seed next line forward */
					if (x>0)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)((color_error*2)/bleed));
					if (x>1)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-2],(int16_t)(color_error/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)((color_error*3)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)((color_error*2)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+2],(int16_t)(color_error/bleed));
					break;

				/* SL 8 */
				case SIERRALITE:
					/*
						*   2
					1   1		(1/4)
					*/

					/* for serpentine effect alternating scanlines run the error in reverse */
					if (serpentine == 1 && y%2 == 1) {
						/* finish this line */
						if (x>0)AdjustShortPixel(1,(int16_t *)&colorptr[x-1],(int16_t)((color_error * 2) /bleed));

						/* seed next line forward */
						AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)(color_error/bleed));
					}
					else {
						/* finish this line */
						AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)((color_error * 2) /bleed));
						/* if making hgr passes 0 and 1 dither first line only */
						if (runs < 2 || ditheroneline == 1) break;

						/* seed next line forward */
						if (x>0)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)(color_error/bleed));
					}
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)(color_error/bleed));

					break;


			   case CUSTOM:

					/* 0,0,0,0,0,*,0,0,0,0,0
					   0,0,0,0,0,0,0,0,0,0,0
					   0,0,0,0,0,0,0,0,0,0,0 */

					for (dx = 0,pos=x-5;dx < 11; dx++,pos++) {
					   /* finish this line */
					   if (pos < 0) continue;

					   mult = customdither[0][dx];
					   if (mult > 0) {
						   AdjustShortPixel(1,(int16_t *)&colorptr[pos],(int16_t)((color_error * mult) /bleed));
					   }

					   /* if making hgr passes 0 and 1 dither first line only */
					   if (runs < 2 || ditheroneline == 1) continue;

					   /* seed next line forward */
					   mult = customdither[1][dx];
					   if (mult > 0) {
						   AdjustShortPixel(threshold,(int16_t *)&seedptr[pos],(int16_t)((color_error * mult) /bleed));
					   }
					   /* seed furthest line forward */
					   mult = customdither[2][dx];
					   if (mult > 0) {
						   AdjustShortPixel(threshold,(int16_t *)&seed2ptr[pos],(int16_t)((color_error * mult) /bleed));
					   }

					}
					break;

				default: /* buckels dither - d9 */
				   /*
					  * 2 1
					1 2 1
					  1          (1/8)

					Serpentine

				  1 2 *
					1 2 1
					  1

					*/

					/* if error summing is turned-on add the accumulated rounding error
					   to the next pixel */
					if (errorsum == 0) {
						total_difference = 0;
					}
					else {
						total_error = (color_error * 8) / bleed;
						total_used =  (color_error * 2)/bleed;
						total_used += (color_error * 2)/bleed;
						total_used += (color_error /bleed);
						total_used += (color_error /bleed);
						total_used += (color_error /bleed);
						total_used += (color_error /bleed);
						total_difference = total_error - total_used;
					}

					/* for serpentine effect alternating scanlines run the error in reverse */
					if (serpentine == 1 && y%2 == 1) {
						/* finish this line */
						if (x>0)AdjustShortPixel(1,(int16_t *)&colorptr[x-1],(int16_t)((color_error*2)/bleed)+total_difference);
						if (x>1)AdjustShortPixel(1,(int16_t *)&colorptr[x-2],(int16_t)(color_error/bleed));
					}
					else {
						/* finish this line */
						AdjustShortPixel(1,(int16_t *)&colorptr[x+1],(int16_t)((color_error*2)/bleed)+total_difference);
						AdjustShortPixel(1,(int16_t *)&colorptr[x+2],(int16_t)(color_error/bleed));
					}

					/* if making hgr passes 0 and 1 dither first line only */
					if (runs < 2 || ditheroneline == 1) break;

					/* seed next line forward */
					if (x>0)AdjustShortPixel(threshold,(int16_t *)&seedptr[x-1],(int16_t)(color_error/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x],(int16_t)((color_error*2)/bleed));
					AdjustShortPixel(threshold,(int16_t *)&seedptr[x+1],(int16_t)(color_error/bleed));

					/* seed furthest line forward */
					AdjustShortPixel(threshold,(int16_t *)&seed2ptr[x],(int16_t)(color_error/bleed));



				}
			}
		}
	}

    /* turn-off hgr color dither */
	dither7 = 0;

   /* get the mask line from the mask file if we are overlaying this image */
   /* the mask file is a 256 color BMP and is applied after rendering is complete and */
   /* immediately before Preview files are written to disk and the DHGR buffer is plotted */
   /* for monochrome masking the maskfile is either 280 x 192 or 560 x 192 */
   /* for color masking the maskfile is always 140 x 192 */

   if (overlay == 1) {
   		ReadMaskLine(y);
   }

   /* plot dithered scanline in DHGR buffer using selected conversion palette */
   /* plot dithered scanline in Preview buffer using selected preview palette */
   for (x=0,x1=0;x<width;x++) {


        maskpixel = 0;
        if (overlay == 1) {
			overcolor = maskline[x];
			if (mono == 1) {
				/* for monochrome masking if an area is black or white
				   it overlays the image */
				if (overcolor == 0 || overcolor == 15) maskpixel = 1;
			}
			else {
				/* for color masking clearcolor is the transparent color for the mask */
				/* if the overlay color is some other color then the pixel is overlaid
	     		   with the mask color */
				if (overcolor != clearcolor) maskpixel = 1;
			}

		}

        if (maskpixel == 1) {
			drawcolor = (uint8_t)overcolor;
		}
		else {
			r = (uint8_t)redDither[x];
			g = (uint8_t)greenDither[x];
			b = (uint8_t)blueDither[x];
			drawcolor = GetMedColor(r,g,b,&paldistance);
		}

		if (mono == 1) {
			if (width == 280) hrmonoplot(x,y,drawcolor);
			else dhrmonoplot(x,y,drawcolor);
		}
		else dhrplot(x,y,drawcolor);

		/* if color preview option, plot double-wide pixels in pairs of 24-bit RGB triples */
		/* unless plotting double lo-res */
		if (preview == 1) {
			if (mono == 1 || (loresoutput == 1 && lores == 0)) {
				previewline[x1] = rgbPreview[drawcolor][BLUE]; x1++;
				previewline[x1] = rgbPreview[drawcolor][GREEN];x1++;
				previewline[x1] = rgbPreview[drawcolor][RED];  x1++;

			}
			else {
				/* we are plotting a double pixel in a 6 byte chunk - b,g,r,b,g,r */
				previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][BLUE]; x1++;
				previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][GREEN];x1++;
				previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][RED];  x1+=4;
			}
		}
   }

}

uint16_t WriteDIBHeader(FILE *fp, uint16_t pixels, uint16_t rasters)
{
    uint16_t outpacket;
    int c;

    memset((char *)&mybmp.bfi.bfType[0],0,sizeof(BMPHEADER));

    /* create the info header */
    mybmp.bmi.biSize = (uint32_t)sizeof(BITMAPINFOHEADER);
    mybmp.bmi.biWidth  = (uint32_t)pixels;
    mybmp.bmi.biHeight = (uint32_t)rasters;
    mybmp.bmi.biPlanes = 1;
    mybmp.bmi.biBitCount = 24;
    mybmp.bmi.biCompression = (uint32_t) BI_RGB;

    /* BMP scanlines are padded to a multiple of 4 bytes (DWORD) */
    outpacket = (uint16_t)mybmp.bmi.biWidth * 3;
    while (outpacket%4 != 0)outpacket++;
    mybmp.bmi.biSizeImage = (uint32_t)outpacket;
	mybmp.bmi.biSizeImage *= mybmp.bmi.biHeight;

    /* create the file header */
    mybmp.bfi.bfType[0] = 'B';
    mybmp.bfi.bfType[1] = 'M';
    mybmp.bfi.bfOffBits = (uint32_t) sizeof(BMPHEADER);
    mybmp.bfi.bfSize = mybmp.bmi.biSizeImage + mybmp.bfi.bfOffBits;

 	/* write the header for the output BMP */
    c = fwrite((char *)&mybmp.bfi.bfType[0],sizeof(BMPHEADER),1,fp);

    if (c!= 1)outpacket = 0;

return outpacket;
}

void DiffuseError(uint16_t outpacket)
{
	/*
		http://en.wikipedia.org/wiki/Error_diffusion

		x,y axis (two dimensional) color error diffusion

		in the case of a BMP this disperses the color from the bottom left diagonally through the image
		in the case of some other image format that stores rasters from the top instead of the bottom this would
		disperse the color diagonally from the top left.

        the following scaling ratio is applied:

        1/2 of the gun value of the current pixel is summed with previous pixels as follows:

        1/4 of the gun value of the previous pixel is added to 1/2 the value of the current pixel
        1/8 of the gun value from the previous pixel on the previous line is added to the 1/2 the value of the current pixel
		1/8 of the gun value from the same pixel on the previous line is added to 1/2 the value of the current pixel

	*/

	uint8_t r2, g2, b2, r4, g4, b4;
    uint16_t r, g, b;
    int16_t i;

	/* create previous pixels for current pixels */
	/* previous pixel on same line */
	b2 = dibscanline1[0];
	g2 = dibscanline1[1];
	r2 = dibscanline1[2];

	/* previous pixel from previous line */
	b4 = dibscanline2[0];
	g4 = dibscanline2[1];
	r4 = dibscanline2[2];


	for (i=0; i < outpacket; i+=3) {

        /* RGB Triples */
	    b = (uint16_t) dibscanline1[i];
	    g = (uint16_t) dibscanline1[i+1];
	    r = (uint16_t) dibscanline1[i+2];

        /* add pixels to create 7/8 ratio of required value */
        /* 4 - current pixels
           2 - previous pixels
           1 - previous pixel below */
	    b *= 4; b += b2; b += b2; b += b4;
	    g *= 4; g += g2; g += g2; g += g4;
	    r *= 4; r += r2; r += r2; r += r4;

        /* add 1 current pixel below - 1/8 ratio of required value */
        /* carry forward b4,g4 and r4 to next pixel */
        /* current pixel below becomes previous pixel below */
        b4 = dibscanline2[i];   b += b4; while (b % 8 != 0) b++; b /=8;
		g4 = dibscanline2[i+1]; g += g4; while (g % 8 != 0) g++; g /=8;
		r4 = dibscanline2[i+2]; r += r4; while (r % 8 != 0) r++; r /=8;

     	/* assign new color to current pixel */
        /* and carry forward b2,g2 and r2 to next pixel */
        /* current pixel becomes previous pixel */

		dibscanline1[i]   = b2 = (uint8_t)b;
		dibscanline1[i+1] = g2 = (uint8_t)g;
        dibscanline1[i+2] = r2 = (uint8_t)r;
	}
}


/* create an error-diffused copy of the input file
   and use that instead */
FILE *ReadDIBFile(FILE *fp, uint16_t packet)
{
	FILE *fpdib;
	uint16_t y,outpacket;


    if((fpdib=fopen(dibfile,"wb"))==NULL) {
		printf("Error Opening %s for writing!\n",dibfile);
		return fp;
	}

    outpacket = WriteDIBHeader(fpdib,bmpwidth,bmpheight);
    if (outpacket != packet) {
		fclose(fpdib);
		remove(dibfile);
		printf("Error writing header to %s!\n",dibfile);
		return fp;
	}

    /* seek past extraneous info in header if any */
	fseek(fp,bfi.bfOffBits,SEEK_SET);
	for (y=0;y<bmpheight;y++) {
		fread((char *)&bmpscanline[0],1,packet,fp);
		memcpy(&dibscanline1[0],&bmpscanline[0],packet);
		if (y==0) memcpy(&dibscanline2[0],&bmpscanline[0],packet);
        DiffuseError(packet);
		/* save a copy of the previous line */
		if (diffuse == 2) {
			/* if diffusion is by original value use pure line */
			memcpy(&dibscanline2[0],&bmpscanline[0],packet);
		}
		else {
			/* otherwise use diffused line */
			memcpy(&dibscanline2[0],&dibscanline1[0],packet);
		}
        fwrite((char *)&dibscanline1[0],1,packet,fpdib);

	}
    fclose(fpdib);
    fclose(fp);

    if((fp=fopen(dibfile,"rb"))==NULL) {
		printf("Error Opening %s for reading!\n",dibfile);
   		if((fp=fopen(bmpfile,"rb"))==NULL) {
			printf("Error Opening %s for reading!\n",bmpfile);
			return fp;
		}
	}
    /* read the header stuff into the appropriate structures */
    fread((char *)&bfi.bfType[0],
	             sizeof(BITMAPFILEHEADER),1,fp);
    fread((char *)&bmi.biSize,
                 sizeof(BITMAPINFOHEADER),1,fp);
    return fp;
}


/* helper functions for horizontal resizing */
int ExpandBMPLine(uint8_t *src, uint8_t *dest, uint16_t srcwidth, uint16_t scale)
{
	int i,j,k;
	unsigned char r,g,b;

	srcwidth *=3;
	for (i=0,j=0,k=0;i<srcwidth;) {
		b = src[i++];
		g = src[i++];
		r = src[i++];

		for (j=0;j<scale;j++) {
			dest[k] = b; k++;
			dest[k] = g; k++;
			dest[k] = r; k++;
		}
	}
	return k;
}

int ShrinkBMPLine(uint8_t *src, uint8_t *dest, int srcwidth)
{
	int i,j,k;
	uint16_t r,g,b;


    scale = srcwidth / 140;

	srcwidth *=3;
	for (i=0,j=0,k=0;k<srcwidth;) {
        b = g = r = 0;
		for (j=0;j<scale;j++) {
			b += src[k++];
			g += src[k++];
			r += src[k++];
		}

		dest[i] = (b/scale);i++;
		dest[i] = (g/scale);i++;
		dest[i] = (r/scale);i++;

	}
	return i;
}


/* shrink 640 or 320 to 140 */
/* uses dhrbuf as a work buffer and output buffer */
void ShrinkPixels(FILE *fp)
{

	int packet = (bmpwidth * 3);

	while (packet%4 != 0)packet++;

	fread((char *)&bmpscanline[0],1,packet,fp);
  	ExpandBMPLine((uint8_t *)&bmpscanline[0],(uint8_t *)&dhrbuf[0],bmpwidth,7);
	ShrinkBMPLine((uint8_t *)&dhrbuf[0],(uint8_t *)&dhrbuf[0],(uint16_t)(bmpwidth * 7));
}

/* table-driven scaling from 25 to 24 lines */
void ShrinkLines25to24(FILE *fp, FILE *fp2)
{
	uint16_t pixel,x,i;
	uint16_t x1,x2;

	ShrinkPixels(fp);
	memcpy(&dibscanline1[0],&dhrbuf[0],420);
	if (bmpheight == 400) {
		ShrinkPixels(fp);
		for (x=0;x<420;x++) {
			pixel = (uint16_t) dhrbuf[x];
			pixel += dibscanline1[x];
			dibscanline1[x] = (uint8_t) (pixel/2);
		}
	}
	for (i=0;i<24;i++) {
		ShrinkPixels(fp);
		memcpy(&dibscanline2[0],&dhrbuf[0],420);
		if (bmpheight == 400) {
			ShrinkPixels(fp);
			for (x=0;x<420;x++) {
				pixel = (uint16_t) dhrbuf[x];
				pixel += dibscanline2[x];
				dibscanline2[x] = (uint8_t) (pixel/2);
			}
		}

        for (x=0;x<420;x++) {
			x1 = (uint16_t)dibscanline1[x];
			x2 = (uint16_t)dibscanline2[x];
			pixel = (uint16_t) (x1 * mix25to24[i][0]) + (x2 * mix25to24[i][1]);
			bmpscanline[x] = (uint8_t)(pixel/25);
		}
	   fwrite((char *)&bmpscanline[0],1,420,fp2);
	   if (i<23)memcpy(&dibscanline1[0],&dibscanline2[0],420);
	}
}


/* 640 x 480 scaled to 140 x 192 */
void ShrinkLines640x480(FILE *fp, FILE *fp2)
{
	uint16_t pixel1,pixel2,x,i;

	ShrinkPixels(fp);
	memcpy(&dibscanline1[0],&dhrbuf[0],420);
	ShrinkPixels(fp);
	memcpy(&dibscanline2[0],&dhrbuf[0],420);
	ShrinkPixels(fp);
	memcpy(&dibscanline3[0],&dhrbuf[0],420);
	ShrinkPixels(fp);
	memcpy(&dibscanline4[0],&dhrbuf[0],420);
	ShrinkPixels(fp);

 	for (x=0;x<420;x++) {
		pixel1 = (uint16_t) dibscanline1[x];
		pixel1 += dibscanline2[x];
		pixel1 *= 2;
		pixel1 += dibscanline3[x];
		dibscanline1[x] = (uint8_t) (pixel1/5);

		pixel2 = (uint16_t) dhrbuf[x];
		pixel2 += dibscanline4[x];
		pixel2 *= 2;
		pixel2 += dibscanline3[x];
		dibscanline2[x] = (uint8_t) (pixel2/5);
	}

	fwrite((char *)&dibscanline1[0],1,420,fp2);
	fwrite((char *)&dibscanline2[0],1,420,fp2);
}

/* merges the RGB values of 2 lines into one */
void ShrinkLines560x384(FILE *fp, FILE *fp2)
{

	uint16_t x, pixel, packet = (bmpwidth * 3);

	while (packet%4 != 0)packet++;

	fread((char *)&bmpscanline[0],1,packet,fp);
	ShrinkBMPLine((uint8_t *)&bmpscanline[0],(uint8_t *)&dibscanline1[0],bmpwidth);
	fread((char *)&bmpscanline[0],1,packet,fp);
	ShrinkBMPLine((uint8_t *)&bmpscanline[0],(uint8_t *)&dibscanline2[0],bmpwidth);
	for (x=0;x<420;x++) {
		pixel = (uint16_t)dibscanline1[x];
		pixel+= dibscanline2[x];
		bmpscanline[x] = (uint8_t)(pixel/2);
	}
	fwrite((char *)&bmpscanline[0],1,420,fp2);
}

/* lo-res and double lo-res input files are in multiples of 80 pixels */
int ShrinkLoResLine(uint8_t *src, uint8_t *dest, int srcwidth)
{
	int i,j,k;
	uint16_t r,g,b;

    scale = srcwidth / 80;

	srcwidth *=3;
	for (i=0,j=0,k=0;k<srcwidth;) {
        b = g = r = 0;
		for (j=0;j<scale;j++) {
			b += src[k++];
			g += src[k++];
			r += src[k++];
		}

		dest[i] = (b/scale);i++;
		dest[i] = (g/scale);i++;
		dest[i] = (r/scale);i++;

	}
	return i;
}


void ShrinkLoResData(FILE *fp, FILE *fp2)
{

	uint16_t x, x1, x2, y, lines, srcwidth, packet = (bmpwidth * 3), pixel;

	while (packet%4 != 0)packet++;


    switch(bmpwidth) {
		case 40:
		case 80:
		case 88:  lines = 1; srcwidth = 80; break;
		case 160:
		case 176: lines = 2; srcwidth = 160; break;
		case 320: lines = 4; srcwidth = 320; break;
		case 560: lines = 8; srcwidth = 560; break;
		case 640: lines = 10;srcwidth = 640; break;
	}

    /* clear accumulators */
	memset(&redDither[0],0,480);
	memset(&greenDither[0],0,480);
	memset(&blueDither[0],0,480);

    /* scale up */
	for (y = 0; y < lines; y++) {

		if (bmpwidth == 40) {
			fread((char *)&dibscanline1[0],1,packet,fp);
			/* double the width */
			for (x = 0, x1 = 0, x2 = 0; x < 40; x++) {
				bmpscanline[x2] = bmpscanline[x2+3] = dibscanline1[x1]; x1++; x2++;
				bmpscanline[x2] = bmpscanline[x2+3] = dibscanline1[x1]; x1++; x2++;
				bmpscanline[x2] = bmpscanline[x2+3] = dibscanline1[x1]; x1++; x2+=4;
			}
		}
		else {
			fread((char *)&bmpscanline[0],1,packet,fp);
		}
		ShrinkLoResLine((uint8_t *)&bmpscanline[0],(uint8_t *)&dibscanline1[0],srcwidth);

		for (x = 0, x1=0; x < 80; x++) {
			blueDither[x] += dibscanline1[x1]; x1++;
			greenDither[x] += dibscanline1[x1]; x1++;
			redDither[x] += dibscanline1[x1]; x1++;

		}
	}

	/* scale down */
	for (x = 0, x1=0; x < 80; x++) {
		pixel = blueDither[x] / lines;
		bmpscanline[x1] = (uint8_t) pixel; x1++;
		pixel = greenDither[x] / lines;
		bmpscanline[x1] = (uint8_t) pixel; x1++;
		pixel = redDither[x] / lines;
		bmpscanline[x1] = (uint8_t) pixel; x1++;

	}
	fwrite((char *)&bmpscanline[0],1,240,fp2);
}


/* create a resized copy of the input file
   and use that instead */
FILE *ResizeBMP(FILE *fp, int16_t resize)
{
	FILE *fp2;
	uint16_t x,y,packet,outpacket,chunks;
    uint16_t i,j,r,g,b;
    uint32_t offset=0L;

#ifdef TURBOC
	if (resize == 0)return NULL;
#endif

    if((fp2=fopen(scaledfile,"wb"))==NULL) {
		printf("Error Opening %s for writing!\n",scaledfile);
		return fp;
	}

	if (loresoutput == 1) {
		/* Lo-Res and Double Lo-Res */
		if (appletop == 0) outpacket = WriteDIBHeader(fp2,80,48);
		else outpacket = WriteDIBHeader(fp2,80,40);
		if (outpacket != 240) {
			fclose(fp2);
			remove(scaledfile);
			printf("Error writing header to %s!\n",scaledfile);
			return fp;
		}
	}
	else {
        /* HGR and DHGR */
		if (justify == 1) outpacket = WriteDIBHeader(fp2,280,192);
		else outpacket = WriteDIBHeader(fp2,140,192);
		if (outpacket != 420 && outpacket != 840) {
			fclose(fp2);
			remove(scaledfile);
			printf("Error writing header to %s!\n",scaledfile);
			return fp;
		}
	}

    packet = bmpwidth * 3;
	while (packet%4 != 0)packet++;

    if (justify == 1) {
		if (loresoutput == 0) {
		   /* HGR and DHGR */
		   switch (bmpwidth) {
			   case 640:
						 if (jxoffset > -1) {
							if (jxoffset > 80) jxoffset = 80;
							offset+= jxoffset * 3;
						 }
						 else {
							offset += 120;
						 }
						 if (bmpheight == 480) {
							 if (jyoffset > -1) {
								if (jyoffset > 96)jyoffset = 0;
								else jyoffset = 96 - jyoffset;
								offset += (1920L * jyoffset);
							 }
							 else {
								offset += (1920L * 48);
							}
						 }
						 if (bmpheight == 400) {
							 if (jyoffset > -1) {
								if (jyoffset > 16)jyoffset = 0;
								else jyoffset = 16 - jyoffset;
								offset += (1920L * jyoffset);
							 }
							 else {
								offset += (1920L * 8);
							}
						 }
						 break;

			   case 320:
						 if (jxoffset > -1) {
							if (jxoffset > 40) jxoffset = 40;
							offset+= jxoffset * 3;
						 }
						 else {
							offset += 60;
						 }
						 if (jyoffset > -1) {
							if (jyoffset > 8)jyoffset = 0;
							else jyoffset = 8 - jyoffset;
							offset += (960L * jyoffset);
						 }
						 else {
							offset += (960L * 4);
						 }
						 break;

		   }
	   }
	   else {
		   /* LGR and DLGR */
		   offset += (jyoffset * packet);
		   offset += (jxoffset * 3);
	   }

	}

    /* seek past extraneous info in header if any */
	fseek(fp,bfi.bfOffBits+offset,SEEK_SET);

    if (justify == 1 && loresoutput == 0) {
		for (y = 0;y< 192;y++) {
		    fread((char *)&dibscanline1[0],1,packet,fp);
		    if (bmpheight == 200) {
				/* no merging at all on 320 x 200 */
				fwrite((char *)&dibscanline1[0],1,outpacket,fp2);
				continue;
			}
			fread((char *)&dibscanline2[0],1,packet,fp);
			for (x = 0,i=0,j=0;x<280;x++) {
				b = (uint16_t)dibscanline1[i]; b+= dibscanline2[i]; i++;
				g = (uint16_t)dibscanline1[i]; g+= dibscanline2[i]; i++;
				r = (uint16_t)dibscanline1[i]; r+= dibscanline2[i]; i++;
				/* half merge (merge vertically) unless merge is turned-on */
				if (merge == 0) {
					i+=3;b*=2;g*=2;r*=2;
				}
				else {
					b += dibscanline1[i]; b+= dibscanline2[i]; i++;
					g += dibscanline1[i]; g+= dibscanline2[i]; i++;
					r += dibscanline1[i]; r+= dibscanline2[i]; i++;
				}
			    bmpscanline[j] = (uint8_t) (uint16_t)(b/4);j++;
			    bmpscanline[j] = (uint8_t) (uint16_t)(g/4);j++;
			    bmpscanline[j] = (uint8_t) (uint16_t)(r/4);j++;
			}
			fwrite((char *)&bmpscanline[0],1,outpacket,fp2);
		}
	}
    else {
		if (loresoutput == 1) {
			/* LGR and DLGR input file */
			if (appletop == 1) chunks = 40;
			else chunks = 48;

            for (y=0;y<chunks;y++) ShrinkLoResData(fp,fp2);
		}
		else {
			/* HGR and DHGR input file */
			switch(bmpheight)
			{
				case 200:
				case 400: chunks = 8;   break;
				case 384: chunks = 192; break;
				case 480: chunks = 96;  break;
			}

			for (y=0;y<chunks;y++) {
				switch(bmpheight) {
					case 200:
					case 400: ShrinkLines25to24(fp,fp2);break;
					case 480: ShrinkLines640x480(fp,fp2);break;
					case 384: ShrinkLines560x384(fp,fp2);break;
				}
			}
		}
	}
    fclose(fp2);
    fclose(fp);

    if((fp=fopen(scaledfile,"rb"))==NULL) {
		printf("Error Opening %s for reading!\n",scaledfile);
   		if((fp=fopen(bmpfile,"rb"))==NULL) {
			printf("Error Opening %s for reading!\n",bmpfile);
			return fp;
		}
	}
    /* read the header stuff into the appropriate structures */
    fread((char *)&bfi.bfType[0],
	             sizeof(BITMAPFILEHEADER),1,fp);
    fread((char *)&bmi.biSize,
                 sizeof(BITMAPINFOHEADER),1,fp);
    return fp;
}


/* expand monochrome bmp lines to 24-bit bmp lines */
void ReformatMonoLine()
{
     int i,j,k,packet;
     uint8_t b = 0, w = 255;

     if (bmpwidth == 280) packet = 35;
     else packet = 70;

     memcpy(&dibscanline1[0],&bmpscanline[0],packet);

     if (reverse == 1) {
		 b = 255;
		 w = 0;
	 }

     for(i=0,j=0;i<packet;i++)
     {

        for(k=0;k<8;k++)
        {
            if (dibscanline1[i]&msk[k]) {
				bmpscanline[j] = bmpscanline[j+1] = bmpscanline[j+2] = w;
			}
            else {
				bmpscanline[j] = bmpscanline[j+1] = bmpscanline[j+2] = b;
			}
            j+=3;
        }
     }
}

/* expand 16 color and 256 color bmp lines to 24-bit bmp lines */
void ReformatVGALine()
{
	int16_t i, j, packet;
	uint8_t ch;

    memset(dibscanline1,0,1920);
	if (bmi.biBitCount == 8) {
       memcpy(&dibscanline1[0],&bmpscanline[0],bmpwidth);
    }
    else {
		packet = bmpwidth /2;
		if (bmpwidth%2 != 0) packet++;
		for (i=0,j=0;i<packet;i++) {
			ch = bmpscanline[i] >> 4;
			dibscanline1[j] = ch; j++;
			ch = bmpscanline[i] & 0xf;
			dibscanline1[j] = ch; j++;
		}
	}
	memset(&bmpscanline[0],0,1920);
	for (i=0,j=0;i<bmpwidth;i++) {
		  ch = dibscanline1[i];
	      bmpscanline[j] = sbmp[ch].rgbBlue; j++;
	      bmpscanline[j] = sbmp[ch].rgbGreen; j++;
	      bmpscanline[j] = sbmp[ch].rgbRed; j++;
	 }
}

/* convert 16 color and 256 color bmps to 24 bit bmps */
/* convert Monochrome bmps to 24 bit bmps */
FILE *ReformatBMP(FILE *fp)
{

    FILE *fp2;
	int16_t status = SUCCESS;
	uint16_t packet, outpacket,y;

	if (bmi.biBitCount == 1) {
		/* Mono HGR = 280 and Mono DHGR = 560 */
		if (bmpwidth != 280 && bmpwidth != 560) status = INVALID;
		if (bmpheight != 192) status = INVALID;
	}
	else {
		/* HGR and DHGR size check */
		/* LGR and DLGR sizes were checked previously in Convert() */
		if (loresoutput == 0) {
			if (bmpwidth > 280) {
				status = INVALID;
				switch(bmpwidth) {
					case 640: if (bmpheight == 400 || bmpheight == 480) status = SUCCESS; break;
					case 320: if (bmpheight == 200) status = SUCCESS; break;
					case 560: if (bmpheight == 384) status = SUCCESS; break;
				}
			}
			else {
				if (bmpheight > 192) status = INVALID;
			}
		}
	}

	if (status == INVALID) {
		fclose(fp);
		fp = NULL;
		printf("%s is not a supported size!\n",bmpfile);
		return fp;
	}

	if (bmi.biBitCount == 8)
		fread((char *)&sbmp[0].rgbBlue, sizeof(RGBQUAD)*256,1,fp);
	else if (bmi.biBitCount == 4)
		fread((char *)&sbmp[0].rgbBlue, sizeof(RGBQUAD)*16,1,fp);
	else if (bmi.biBitCount == 1)
	    fread((char *)&sbmp[0].rgbBlue, sizeof(RGBQUAD)*2,1,fp);

    /* seek past extraneous info in header if any */
	fseek(fp,bfi.bfOffBits,SEEK_SET);

    /* align on 4 byte boundaries */
    if (bmi.biBitCount == 1) {
		if (bmpwidth == 280) packet = 36;
		else packet = 72;
	}
    else if (bmi.biBitCount == 8) {
		packet = bmpwidth;
	}
	else {
		packet = bmpwidth / 2;
		if (bmpwidth%2 != 0)packet++;
	}
    while ((packet % 4)!=0)packet++;

    if((fp2=fopen(reformatfile,"wb"))==NULL) {
		printf("Error Opening %s for writing!\n",reformatfile);
		return fp;
	}
    if (bmi.biBitCount == 1) {
		if (bmpwidth == 280) outpacket = WriteDIBHeader(fp2,bmpwidth,bmpheight);
		else outpacket = WriteDIBHeader(fp2,bmpwidth,bmpheight*2);
	}
	else {
    	outpacket = WriteDIBHeader(fp2,bmpwidth,bmpheight);
	}
    if (outpacket < 1) {
		fclose(fp2);
		remove(reformatfile);
		printf("Error writing header to %s!\n",reformatfile);
		return fp;
	}

  	for (y=0;y<bmpheight;y++) {
		fread((char *)&bmpscanline[0],1,packet,fp);
		if (bmi.biBitCount == 1) ReformatMonoLine();
		else ReformatVGALine();
        fwrite((char *)&bmpscanline[0],1,outpacket,fp2);
        /* double lines for DHGR monochrome conversion */
        /* single lines for HGR monochrome conversion */
        if (bmi.biBitCount == 1 && bmpwidth == 560) fwrite((char *)&bmpscanline[0],1,outpacket,fp2);
	}
    fclose(fp2);
    fclose(fp);

    reformat = 1;

    if((fp=fopen(reformatfile,"rb"))==NULL) {
		printf("Error Opening %s for reading!\n",reformatfile);
   		if((fp=fopen(bmpfile,"rb"))==NULL) {
			printf("Error Opening %s for reading!\n",bmpfile);
			return fp;
		}
	}
    /* read the header stuff into the appropriate structures */
    fread((char *)&bfi.bfType[0],
	             sizeof(BITMAPFILEHEADER),1,fp);
    fread((char *)&bmi.biSize,
                 sizeof(BITMAPINFOHEADER),1,fp);
    return fp;
}


/* overlay using a 256 color BMP file in verbatim output resolution */
/* HGR and DHGR color overlay files are 140 x 192 */
/* HGR and DHGR monochrome are 280 x 192 and 560 x 192 respectively */
int16_t OpenMaskFile()
{

	int16_t status = INVALID;
	uint16_t i, width=0, height=0;
	double dummy;
	int c;

    if (overlay == 0) return status;

    overlay = 0;
    fpmask = fopen(maskfile,"rb");
    if (NULL == fpmask) {
		printf("Error opening maskfile %s\n",maskfile);
		return status;
	}

    for (;;) {

		c = fread((char *)&maskbmp.bfi.bfType[0],sizeof(BMPHEADER),1,fpmask);

		if (c!= 1) {
			/* printf("header read returned %d\n",c); */
			break;
		}

    	if (maskbmp.bmi.biCompression==BI_RGB &&
     		maskbmp.bfi.bfType[0] == 'B' && maskbmp.bfi.bfType[1] == 'M' &&
     		maskbmp.bmi.biPlanes==1 && maskbmp.bmi.biBitCount == 8) {
				width = (uint16_t) maskbmp.bmi.biWidth;
				height = (uint16_t) maskbmp.bmi.biHeight;
		}

        /* this ensures that only full-screen output is masked */
        /* it doesn't make sense to mix image fragment routines into here */
        if (mono == 1) {
			if (hgroutput == 0) {
				if (width != 560 || height != 192) {
					/* printf("width = %d, height = %d\n",width,height); */
					puts("Mask file width must be 560 x 192");
					break;
				}
			}
			else {
				if (width != 280 || height != 192) {
					/* printf("width = %d, height = %d\n",width,height); */
					puts("Mask file width must be 280 x 192");
					break;
				}
			}

		}
		else {
        	if (width != 140 || height != 192) {
				/* printf("width = %d, height = %d\n",width,height); */
				puts("Mask file width must be 140 x 192");
				break;
			}
		}

        fread((char *)&maskpalette[0].rgbBlue, sizeof(RGBQUAD)*256,1,fpmask);


		for (i=0;i<256;i++) {
			if (mono == 1) {
				/* build a remap array for monochrome output */
				if (maskpalette[i].rgbRed == 255 && maskpalette[i].rgbGreen == 255 &&
				    maskpalette[i].rgbBlue == 255) {
						remap[i] = 15;
				}
				else if (maskpalette[i].rgbRed == 0 && maskpalette[i].rgbGreen == 0 &&
				    maskpalette[i].rgbBlue == 0) {
						remap[i] = 0;
				}
				else {
					/* anything else maps to color 1 for mono */
					remap[i] = 1;
				}

			}
			else {
				/* build a remap array for color output */
				remap[i] = GetMedColor(maskpalette[i].rgbRed,
			                           maskpalette[i].rgbGreen,
			                       	   maskpalette[i].rgbBlue,&dummy);
			}
		}
		fseek(fpmask,bfi.bfOffBits,SEEK_SET);
		status = SUCCESS;
		overlay = 1;
		break;
	}

    if (status == INVALID){
		/* puts("Failed!"); */
		fclose(fpmask);
		fpmask = NULL;
		if (quietmode == 1)printf("Error loading %s\n",maskfile);
	}
	else {
		if (quietmode == 1)printf("Loaded mask %s\n",maskfile);
	}

    return status;
}

/* LGR and DLGR only */
int16_t ValidLoResSizeRange()
{
	int16_t status = INVALID;

	/* monochrome input files are not accepted for LGR or DLGR conversion */
	if (bmi.biBitCount != 1) {

	   /* http://en.wikipedia.org/wiki/Windowbox_(film) - cropped (clipped) images */
	   /* restricted to a reasonable number of sizes that make sense to me */
	   /* additional scaling can be done outside of here */
	   /* for lores verbatim fullscreen output use 40 x 48 input files */
	   /* for double lores verbatim fullscreen output use 80 x 48 input files */
	   /* for mixed text and graphics mode output of the above is automatic with
		  input files of 40 lines, and by default clips the bottom 8 lines with
		  input files of 48 lines... and optionally the windowbox can be shifted
		  downwards by 0-8 lines when justify option JL is used.

		  larger sizes behave similarly. scaling of larger sizes uses pixel merge
		  to combine pixels and scanlines so detail loss will occur. sizes like
		  88 x 52, 176 x 104 and 320 x 200 also provide optional windowbox shifting for
		  fullscreen output as well as for mixed text and graphics output. these
		  over-scanned sizes are centered on the display by default. over-scanned sizes
		  use the same nominal resolution as pre-scaled sizes,

		  640 x 480 (fullscreen) and 640 x 400 (mixed text and graphics) is the only
		  "Classic Size" supported for LGR and DLGR

		  during processing, in order to lever the same routines used by HGR and DHGR,
		  half-scaling is provided for LGR as a "second level" of scaling. all output
		  is restricted to one of 4 sizes:

		  LGR - 40 x 40 and 40 x 48
		  DLGR - 80 x 40 and 80 x 48

		  LGR and DLGR image fragments are not supported for this version of Bmp2DHR

		  */

		switch(bmpwidth) {

		case 40:  lores = 1; /* verbatim 1:1 lgr only - nominal size 40 x 48 */
		case 80:
				  /* verbatim 1:1 for dlgr - nominal size 80 x 48 */
				  /* 2:1 scaled for lgr */
				  if (bmpheight == 40 || bmpheight == 48) status = SUCCESS;
				  else break;
				  jxoffset = 0; /* windowbox in vertical axis only */
				  if (bmpheight == 40) {
					  /* mixed text and graphics */
					  /* 40 x 40 and 80 x 40 - windowbox not required */
					  appletop = 1;
					  justify = jyoffset = 0;
					  break;
				  }
				  if (appletop == 1) {
					  /* mixed text and graphics */
					  /* 40 x 48 and 80 x 48 - windowbox required */
					  /* top justified if not otherwise specified */
					  if (justify == 1 && (jyoffset > -1 || jyoffset < 9)) {
						  jyoffset = 8 - jyoffset;
						  break;
					  }
					  jyoffset = 8;
					  justify = 1;

				  }
				  else {
					  /* fullscreen */
					  /* 40 x 48 and 80 x 48 */
					  justify = jyoffset = 0;

				  }
				  break;

		case 88:  /* the next two input widths (88 and 176) are processed as over-scanned images */
				  /* these originate from clipped BMP format "MiniPix" conversions */
				  /* saved in Windows Paint as "old" and "new" printshop "pastes" from ClipShop in
					 small-copy (single-scaled) or regular copy (double-scaled) format. */

				  if (bmpheight != 52) break;
				  status = SUCCESS;  /* verbatim for dlgr - nominal size 80 x 48 */
				  if (jxoffset < 0 || jxoffset > 8) {
					  jxoffset = 4; /* centre */
				  }
				  if (appletop == 1) { /* mixed text and graphics - dlgr windowbox 80 x 40 */
					  if (justify == 1 && (jyoffset > -1 && jyoffset < 13)) jyoffset = 12 - jyoffset;
					  else jyoffset = 10;
					  justify = 1;
					  break;
				  }
				  justify = 1;
				  if (jyoffset < 0 || jyoffset > 4) {
					  jyoffset = 2; /* centre */
				  }
				  break;
		case 176: if (bmpheight != 104) break;
				  status = SUCCESS; /* dlgr double-scaled - nominal size 160 x 96 */
				  if (jxoffset < 0 || jxoffset > 16) {
					  jxoffset = 8; /* centre */
				  }
				  if (appletop == 1) { /* mixed text and graphics - dlgr windowbox 160 x 80 */
					  if (justify == 1 && (jyoffset > -1 && jyoffset < 25)) jyoffset = 24 - jyoffset;
					  else jyoffset = 20;
					  justify = 1;
					  break;
				  }
				  justify = 1;
				  if (jyoffset < 0 || jyoffset > 8) {
					  jyoffset = 4; /* centre */
				  }
				  break;
		case 160: /* nominal size 160 x 96 */
				  /* 2:2 scaled for dlgr, 4:2 scaled for lgr */
				  if (bmpheight == 80 || bmpheight == 96) status = SUCCESS;
				  else break;
				  jxoffset = 0;
				  if (bmpheight == 80) {
					  /* 160 x 80 - mixed text and graphics */
					  appletop = 1;
					  justify = jyoffset = 0;
					  break;
				  }
				  if (appletop == 1) {
					  /* mixed text and graphics */
					  /* 160 x 96 - windowbox required */
					  /* top justified if not otherwise specified */
					  if (justify == 1 && (jyoffset > -1 || jyoffset < 17)) {
						  jyoffset = 16 - jyoffset;
						  break;
					  }
					  jyoffset = 16;
					  justify = 1;

				  }
				  else {
					  /* fullscreen */
					  /* 160 x 96 */
					  justify = jyoffset = 0;

				  }
				  break;
		case 320: /* nominal size 320 x 192 */
				  /* 4:4 scaled for dlgr, 8:4 scaled for lgr */
				  if (bmpheight == 160 || bmpheight == 192 || bmpheight == 200) {
					  status = SUCCESS;
					  jxoffset = 0; /* vertical scaling of mixed text and graphics only */
					  if (bmpheight == 160) {
						  appletop = 1;
						  justify = jyoffset = 0;
						  break;
					  }
					  if (bmpheight == 192) {
						  if (appletop == 1) {
							  if (justify == 1 && (jyoffset > -1 && jyoffset < 33)) jyoffset = 32 - jyoffset;
							  else jyoffset = 32;
							  justify = 1;
							  break;
						  }
						  justify = jyoffset = 0;
						  break;
					  }
					  /* 320 x 200 */
					  /* centre in frame by default */
					  if (appletop == 1) {
						  if (justify == 1 && (jyoffset > -1 && jyoffset < 41)) jyoffset = 40 - jyoffset;
						  else jyoffset = 36;
						  justify = 1;
						  break;
					  }
					  if (justify == 1 && (jyoffset > -1 && jyoffset < 9)) jyoffset = 8 - jyoffset;
					  else jyoffset = 4;
					  justify = 1;
				  }
				  break;
		case 560: /* "Classic" full-screen conversion of pre-scaled 560 x 384 input */
				  /* "Classic" mixed text and graphics screen conversion of pre-scaled
					 560 x 384 full-screen or 560 x 320 cropped input */
				  /* 7:8 scaled for dlgr, 14:8 scaled for lgr */
				  if (bmpheight == 320 || bmpheight == 384) status = SUCCESS;
				  else break;
				  jxoffset = 0;
				  if (bmpheight == 320) {
					  /* mixed text and graphics */
					  appletop = 1;
					  justify = jyoffset = 0;
					  break;
				  }
				  if (appletop == 1) {
						/* mixed text and graphics */
						if (justify == 1 && (jyoffset > -1 && jyoffset < 65)) jyoffset = 64 - jyoffset;
						else jyoffset = 64;
						justify = 1;
				  }
				  else {
						/* fullscreen */
						justify = jyoffset = 0;
				  }
				  break;
		case 640: /* "Classic" full-screen conversion of 640 x 480 square pixeled input */
				  /* "Classic" mixed text and graphics screen conversion of square pixeled
					  640 x 480 full-screen or 640 x 400 cropped input */
				  /* 8:10 scaled for dlgr, 16:10 scaled for dlgr */
				  if (bmpheight == 480 || bmpheight == 400) status = SUCCESS;
				  else break;
				  jxoffset = 0;
				  if (bmpheight == 400) {
					  /* mixed text and graphics */
					  appletop = 1;
					  justify = jyoffset = 0;
					  break;
				  }
				  if (appletop == 1) {
						/* mixed text and graphics */
						if (justify == 1 && (jyoffset > -1 && jyoffset < 81)) jyoffset = 80 - jyoffset;
						else jyoffset = 64;
						justify = 1;
				  }
				  else {
						/* fullscreen */
						justify = jyoffset = 0;
				  }
				  break;
		}
	}

	return status;
}

/* for color DHGR */
/* 1. reads a 24 bit BMP file in the range from 1 x 1 to 280 x 192 */
/* 2. writes a DHGR screen image or optionally a DHGR image fragment */
/* 3. also creates an optional preview file...
   		when preview is on... also leaves an optional error-diffused dib file
   		in place if error diffusion is also turned-on */
/* Etcetera */
int16_t Convert()
{

    FILE *fp, *fpdib, *fpreview;
    int16_t status = INVALID, resize = 0;
	uint16_t x,x1,x2,y,yoff,i,packet, outpacket, width, dwidth, red, green, blue;
	uint8_t r,g,b,drawcolor;
	uint32_t pos, prepos;

    /* if using a mask file, open it now */
    /* leave it open throughout the conversion session */
    /* it will be closed in main before exiting */
	if (overlay == 1)OpenMaskFile();

    if((fp=fopen(bmpfile,"rb"))==NULL) {
		printf("Error Opening %s for reading!\n",bmpfile);
		return status;
	}
    /* read the header stuff into the appropriate structures */
    fread((char *)&bfi.bfType[0],
	             sizeof(BITMAPFILEHEADER),1,fp);
    fread((char *)&bmi.biSize,
                 sizeof(BITMAPINFOHEADER),1,fp);

    /* reformat to 24 bit */
    if (bmi.biCompression==BI_RGB &&
        bfi.bfType[0] == 'B' && bfi.bfType[1] == 'M' && bmi.biPlanes==1) {

		bmpwidth = (uint16_t) bmi.biWidth;
		bmpheight = (uint16_t) bmi.biHeight;

		if (loresoutput == 1) {
			/* LGR and DLGR */
			status = ValidLoResSizeRange();
			if (status == INVALID) {
				fclose(fp);
				printf("%s is in the wrong format!\n",bmpfile);
				return status;
			}
		}

       if (bmi.biBitCount == 8 || bmi.biBitCount == 4) {
	    	fp = ReformatBMP(fp);
	    	if (fp == NULL) return INVALID;
		}
	}

    if (bmi.biCompression==BI_RGB &&
        bfi.bfType[0] == 'B' && bfi.bfType[1] == 'M' &&
        bmi.biPlanes==1 && bmi.biBitCount == 24) {

		bmpwidth = (uint16_t) bmi.biWidth;
		bmpheight = (uint16_t) bmi.biHeight;

		if (loresoutput == 0) {
			/* color HGR and DHGR */
			/* resize some classic screen sizes */
			if (bmpwidth == 320 && bmpheight == 200)
			   resize = 1;
			else  if (bmpwidth == 640 && bmpheight == 400)
			   resize = 2;
			else if (bmpwidth == 640 && bmpheight == 480)
			   resize = 3;
			else if (bmpwidth == 560 && bmpheight == 384)
			   resize = 4;
		}
		else {
			/* color LGR and DLGR */
			/* all lo-res and double lo-res input is resized to one of 2 -
			   sizes of input file:

			   80 x 48 or 80 x 40

			   the input file is then processed as a "small" double hi-res
			   image. since the color palette is exactly the same, the same
			   rendering options are available.

			   after processing the double hi-res output buffer is converted to
			   lo-res or double lo-res formatting and saved as Apple II native
			   LGR or DLGR output.

			   */
			resize = 5;
		}

        if (resize != 0) {
    		memset(&bmpscanline[0],0,1920);
    		memset(&dibscanline1[0],0,1920);
    		memset(&dibscanline2[0],0,1920);
    		memset(&dibscanline3[0],0,1920);
    		memset(&dibscanline4[0],0,1920);
			fp = ResizeBMP(fp,resize);
			if (fp == NULL) return INVALID;
			bmpwidth = (uint16_t) bmi.biWidth;
			bmpheight = (uint16_t) bmi.biHeight;
		}

        if (loresoutput == 0) {
			/* HGR and DHGR output */
			if (scale == 0) {
				if (bmpwidth > 140) scale = 1;
			}

			if (scale == 1) {
				width = bmpwidth;
				dwidth = (bmpwidth+1)/2;
				if (bmpwidth  > 0 && bmpwidth < 281 &&
					bmpheight > 0 && bmpheight < 193) status = SUCCESS;
			}
			else {
				width = bmpwidth * 2;
				dwidth = bmpwidth;
				if (bmpwidth  > 0 && bmpwidth < 141 &&
					bmpheight > 0 && bmpheight < 193) status = SUCCESS;

			}
		}
		else {
			/* LGR and DLGR */
			width = bmpwidth;
			if (lores == 1) {
				scale = 1;
				dwidth = 40;
			}
			else {
				scale = 0;
				dwidth = 80;
			}
		}
	}

    if (status == INVALID) {
		fclose(fp);
		printf("%s is in the wrong format!\n",bmpfile);
		return status;
	}


	packet = bmpwidth * 3;
    /* BMP scanlines are padded to a multiple of 4 bytes (DWORD) */
	while ((packet % 4) != 0) packet++;

    /* error diffusion option */
    if (diffuse != 0) {
		/* clear buffers */
    	memset(&bmpscanline[0],0,960);
    	memset(&dibscanline1[0],0,960);
    	memset(&dibscanline2[0],0,960);
		fp = ReadDIBFile(fp, packet);
		if (fp == NULL) return INVALID;
	}

	if (preview!=0) {
		fpreview = fopen(previewfile,"wb+");

		if (fpreview != NULL) {
			outpacket = WriteDIBHeader(fpreview,width,bmpheight);
			if (outpacket == 0) {
				fclose(fpreview);
				remove(previewfile);
				printf("Error writing header to %s!\n",previewfile);
				preview = 0;
			}
			else {
				/* pad the preview file */
				memset(&dibscanline1[0],0,960);
    			for (y=0;y<bmpheight;y++) fwrite((char *)&dibscanline1[0],1,outpacket,fpreview);
    			/* set the seek distance to scanline 0 in the preview file */
    			prepos = (uint32_t) (bmpheight - 1);
    			prepos *= outpacket;
    			prepos += mybmp.bfi.bfOffBits;
			}

		}
		else {
			printf("Error opening %s for writing!\n",previewfile);
			preview = 0;
		}
	}


	/* read BMP from top scanline to bottom scanline */
    pos = (uint32_t) (bmpheight - 1);
    pos *= packet;
    pos += bfi.bfOffBits;

    /* clear buffers */
    dhrclear();
	memset(&bmpscanline[0],0,960);
	memset(&previewline[0],0,960);

	if (dither != 0) {
		/* sizeof(int16_t) * 320 */
		memset(&redDither[0],0,640);
		memset(&greenDither[0],0,640);
		memset(&blueDither[0],0,640);
		memset(&redSeed[0],0,640);
		memset(&greenSeed[0],0,640);
		memset(&blueSeed[0],0,640);
 		memset(&redSeed2[0],0,640);
		memset(&greenSeed2[0],0,640);
		memset(&blueSeed2[0],0,640);
	}

	for (y=0;y<bmpheight;y++,pos-=packet) {
		fseek(fp,pos,SEEK_SET);
		fread((char *)&bmpscanline[0],1,packet,fp);

        if (overlay == 1)ReadMaskLine(y);

		if (scale == 1) {
			for (x = 0,i = 0, x1=0; x < bmpwidth; x++) {
				/* get even pixel values */
				b = bmpscanline[i]; i++;
				g = bmpscanline[i]; i++;
				r = bmpscanline[i]; i++;
				x++;

                /* get odd pixel values */
               	if (x < bmpwidth) {
					if (merge == 0) {
					  blue  = (uint16_t)b;
					  green = (uint16_t)g;
					  red   = (uint16_t)r;
					  i+=3;
					}
					else {
					  blue  = (uint16_t)bmpscanline[i]; i++;
					  green = (uint16_t)bmpscanline[i]; i++;
					  red   = (uint16_t)bmpscanline[i]; i++;
					}

				}
				else {
					/* if no odd pixel double-plot the last pixel */
                	if (merge == 0) {
						blue  = (uint16_t)b;
						green = (uint16_t)g;
						red   = (uint16_t)r;
					}
					else {
 						/* merge with background color
                   	   	   on some fragments the background color might already be padded-out
                		*/
						blue  = (uint16_t)rgbArray[backgroundcolor][2];
						green = (uint16_t)rgbArray[backgroundcolor][1];
						red   = (uint16_t)rgbArray[backgroundcolor][0];
					}
			  	}

				blue  += b;
				green += g;
				red   += r;

				b = (uint8_t) (blue/2);
				g = (uint8_t) (green/2);
				r = (uint8_t) (red/2);

                if (dither == 0) {

					maskpixel = 0;
					if (overlay == 1) {
						overcolor = maskline[x/2];
						/* clearcolor is the transparent color for the mask */
						/* if the overlay color is some other color then the pixel is overlaid
						   with the mask color */
						if (overcolor != clearcolor) maskpixel = 1;
					}
					if (maskpixel == 1) {
						drawcolor = (uint8_t)overcolor;
					}
					else {
						/* get nearest color index from currently selected conversion palette */
						drawcolor = GetDrawColor(r,g,b,x/2,y);
					}

					/* plot to DHGR buffer */
					dhrplot(x/2,y,drawcolor);
					if (preview == 1) {
						/* plot preview using currently selected preview palette */
						previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][BLUE]; x1++;
						previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][GREEN]; x1++;
						previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][RED]; x1+=4;
					}
				}
				else {
					/* Floyd-Steinberg Etc. dithering */
					/* values are already seeded from previous line(s) */
					x2 = x/2;

					AdjustShortPixel(1,(int16_t *)&redDither[x2],(int16_t)r);
					AdjustShortPixel(1,(int16_t *)&greenDither[x2],(int16_t)g);
					AdjustShortPixel(1,(int16_t *)&blueDither[x2],(int16_t)b);
				}
			}
		}
		else {
			/* merge has no meaning unless we are scaling */
			for (x = 0,i = 0,x1=0; x < bmpwidth; x++) {
				b = bmpscanline[i]; i++;
				g = bmpscanline[i]; i++;
				r = bmpscanline[i]; i++;

				if (dither != 0) {
					/* Floyd-Steinberg Etc. dithering */
					/* values are already seeded from previous line(s) */
					AdjustShortPixel(1,(int16_t *)&redDither[x],(int16_t)r);
					AdjustShortPixel(1,(int16_t *)&greenDither[x],(int16_t)g);
					AdjustShortPixel(1,(int16_t *)&blueDither[x],(int16_t)b);
				}
				else {
					maskpixel = 0;
					if (overlay == 1) {
						overcolor = maskline[x];
						/* clearcolor is the transparent color for the mask */
						/* if the overlay color is some other color then the pixel is overlaid
						   with the mask color */
						if (overcolor != clearcolor) maskpixel = 1;
					}
					if (maskpixel == 1) {
						drawcolor = (uint8_t)overcolor;
					}
					else {
						/* get nearest color index from currently selected conversion palette */
                		drawcolor = GetDrawColor(r,g,b,x,y);
					}
					/* plot to DHGR buffer */
					dhrplot(x,y,drawcolor);
					if (preview == 1) {
						/* plot preview using currently selected preview palette */
						previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][BLUE]; x1++;
						previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][GREEN]; x1++;
						previewline[x1] = previewline[x1+3] = rgbPreview[drawcolor][RED];
						if (loresoutput == 1 && lores == 0) x1++;
						else x1+=4;
					}
				}
			}
		}

        if (dither != 0) {
		   /* Floyd-Steinberg dithering */
		   FloydSteinberg(y,dwidth);
		   /* seed next line - promote nearest forward array to
		      current line */
		   memcpy(&redDither[0],&redSeed[0],640);
		   memcpy(&greenDither[0],&greenSeed[0],640);
		   memcpy(&blueDither[0],&blueSeed[0],640);

           /* seed first seed - promote furthest forward array
              to nearest forward array */
		   memcpy(&redSeed[0],&redSeed2[0],640);
		   memcpy(&greenSeed[0],&greenSeed2[0],640);
		   memcpy(&blueSeed[0],&blueSeed2[0],640);

		   /* clear last seed - furthest forward array */
 		   /* this is not used in all the error diffusion dithers */
 		   /* - but dithers like atkinson use 2 foward arrays */
 		   /* - in dithers that use only one forward array this does no harm */
 		   /* somewhat brute force but simple code */
 		   memset(&redSeed2[0],0,640);
		   memset(&greenSeed2[0],0,640);
		   memset(&blueSeed2[0],0,640);
		}

		if (preview != 0) {
			/* write the preview line to the preview file */
			fseek(fpreview,prepos,SEEK_SET);
			fwrite((char *)&previewline[0],1,outpacket,fpreview);
			prepos -= outpacket;
		}

	}

	fclose(fp);

	if (preview != 0) {
		fclose(fpreview);
		if (quietmode != 0) printf("Preview file %s created!\n",previewfile);
	}

    if (debug == 0) {
		if (diffuse  != 0) remove(dibfile);
		if (resize != 0) remove(scaledfile);
		if (reformat != 0) remove(reformatfile);
	}

    if (savedhr() != SUCCESS) return INVALID;
    if (savesprite() != SUCCESS) return INVALID;

	return SUCCESS;

}

int16_t ConvertMono()
{

    FILE *fp, *fpreview;
    int16_t status = INVALID;
	uint16_t x,y,i,packet, outpacket, red, green, blue, verbatim;
	uint32_t pos, prepos;

    if((fp=fopen(bmpfile,"rb"))==NULL) {
		printf("Error Opening %s for reading!\n",bmpfile);
		return status;
	}
    /* read the header stuff into the appropriate structures */
    fread((char *)&bfi.bfType[0],
	             sizeof(BITMAPFILEHEADER),1,fp);
    fread((char *)&bmi.biSize,
                 sizeof(BITMAPINFOHEADER),1,fp);

	bmpwidth = (uint16_t) bmi.biWidth;
	bmpheight = (uint16_t) bmi.biHeight;

    /* monochrome verbatim DHGR conversion */
	if (bmpwidth == 560 && bmpheight == 192 && bmi.biBitCount == 1) {
		verbatim = 1;
		hgroutput = 0;
	}
	/* color to dithered DHGR monochrome conversion */
	else if (bmpwidth == 560 && bmpheight == 384 && bmi.biBitCount != 1) {
		verbatim = 2;
		hgroutput = 0;
	}
	/* monochrome verbatim HGR conversion */
	else if (bmpwidth == 280 && bmpheight == 192 && bmi.biBitCount == 1) {
		verbatim = hgroutput = 1;

	}
	/* color to dithered HGR monochrome conversion */
	else if (bmpwidth == 280 && bmpheight == 192 && bmi.biBitCount != 1) {
		verbatim = hgroutput = 1;
	}
	else {
		fclose(fp);
		puts("Invalid size for Monochrome conversion!");
		return status;
	}


    /* reformat to 24 bit */
    if (bmi.biCompression==BI_RGB &&
        bfi.bfType[0] == 'B' && bfi.bfType[1] == 'M' && bmi.biPlanes==1 &&
       ((bmi.biBitCount == 8) || (bmi.biBitCount == 4) || (bmi.biBitCount == 1))) {
	    fp = ReformatBMP(fp);
	    if (fp == NULL) return INVALID;
	}

    if (bmi.biCompression==BI_RGB &&
        bfi.bfType[0] == 'B' && bfi.bfType[1] == 'M' &&
        bmi.biPlanes==1 && bmi.biBitCount == 24) {

		bmpwidth = (uint16_t) bmi.biWidth;
		bmpheight = (uint16_t) bmi.biHeight;

		status = SUCCESS;
	}

    if (status == INVALID) {
		fclose(fp);
		printf("%s is in the wrong format!\n",bmpfile);
		return status;
	}

    /* if using a mask file, open it now */
    /* leave it open throughout the conversion session */
    /* it will be closed in main before exiting */
	if (overlay == 1)OpenMaskFile();

	packet = bmpwidth * 3;
    /* BMP scanlines are padded to a multiple of 4 bytes (DWORD) */
	while ((packet % 4) != 0) packet++;

	if (preview!=0) {
		fpreview = fopen(previewfile,"wb+");

		if (fpreview != NULL) {
			outpacket = WriteDIBHeader(fpreview,bmpwidth,bmpheight);
			if (outpacket == 0) {
				fclose(fpreview);
				remove(previewfile);
				printf("Error writing header to %s!\n",previewfile);
				preview = 0;
			}
			else {
				/* pad the preview file */
				memset(&dibscanline1[0],0,960);
    			for (y=0;y<bmpheight;y++) fwrite((char *)&dibscanline1[0],1,outpacket,fpreview);
    			/* set the seek distance to scanline 0 in the preview file */
    			prepos = (uint32_t) (bmpheight - 1);
    			prepos *= outpacket;
    			prepos += mybmp.bfi.bfOffBits;
			}

		}
		else {
			printf("Error opening %s for writing!\n",previewfile);
			preview = 0;
		}
	}


	/* read BMP from top scanline to bottom scanline */
    pos = (uint32_t) (bmpheight - 1);
    pos *= packet;
    pos += bfi.bfOffBits;

    /* clear buffers */
    memset(dhrbuf,0,16384);
	memset(&bmpscanline[0],0,1920);
	memset(&previewline[0],0,1920);

	/* sizeof(int16_t) * 640 */
	memset(&redDither[0],0,1280);
	memset(&greenDither[0],0,1280);
	memset(&blueDither[0],0,1280);
	memset(&redSeed[0],0,1280);
	memset(&greenSeed[0],0,1280);
	memset(&blueSeed[0],0,1280);
	memset(&redSeed2[0],0,1280);
	memset(&greenSeed2[0],0,1280);
	memset(&blueSeed2[0],0,1280);


	for (y=0;y<192;y++,pos-=packet) {
		fseek(fp,pos,SEEK_SET);
		fread((char *)&bmpscanline[0],1,packet,fp);
		if (hgroutput != 1) {
			pos-=packet;
			fread((char *)&bmpscanline2[0],1,packet,fp);
		}

		for (x = 0,i = 0; x < bmpwidth; x++, i+=3) {

			blue = (uint16_t)bmpscanline[i];
			green = (uint16_t)bmpscanline[i+1];
			red = (uint16_t)bmpscanline[i+2];

			if (verbatim == 2) {
				blue  +=  bmpscanline2[i];
				green += bmpscanline2[i+1];
				red   += bmpscanline2[i+2];
			}
			/* Floyd-Steinberg Etc. dithering */
			/* values are already seeded from previous line(s) */
			AdjustShortPixel(1,(int16_t *)&redDither[x],(int16_t)red/verbatim);
			AdjustShortPixel(1,(int16_t *)&greenDither[x],(int16_t)green/verbatim);
			AdjustShortPixel(1,(int16_t *)&blueDither[x],(int16_t)blue/verbatim);
		}

	   /* Floyd-Steinberg dithering */
	   FloydSteinberg(y,bmpwidth);
	   /* seed next line - promote nearest forward array to
		  current line */
	   memcpy(&redDither[0],&redSeed[0],1280);
	   memcpy(&greenDither[0],&greenSeed[0],1280);
	   memcpy(&blueDither[0],&blueSeed[0],1280);

	   /* seed first seed - promote furthest forward array
		  to nearest forward array */
	   memcpy(&redSeed[0],&redSeed2[0],1280);
	   memcpy(&greenSeed[0],&greenSeed2[0],1280);
	   memcpy(&blueSeed[0],&blueSeed2[0],1280);

	   /* clear last seed - furthest forward array */
	   /* this is not used in all the error diffusion dithers */
	   /* - but dithers like atkinson use 2 forward arrays */
	   /* - in dithers that use only one forward array this does no harm */
	   /* somewhat brute force but simple code */
	   memset(&redSeed2[0],0,1280);
	   memset(&greenSeed2[0],0,1280);
	   memset(&blueSeed2[0],0,1280);


		if (preview != 0) {
			/* write the preview line to the preview file */
			fseek(fpreview,prepos,SEEK_SET);
			fwrite((char *)&previewline[0],1,outpacket,fpreview);
			prepos -= outpacket;

			if (hgroutput != 1) {
				fseek(fpreview,prepos,SEEK_SET);
				fwrite((char *)&previewline[0],1,outpacket,fpreview);
				prepos -= outpacket;
			}
		}

	}

	fclose(fp);

	if (preview != 0) {
		fclose(fpreview);
		if (quietmode != 0) printf("Preview file %s created!\n",previewfile);
	}

    if (debug == 0) {
		if (reformat != 0) remove(reformatfile);
	}

    if (savedhr() != SUCCESS) return INVALID;
	return SUCCESS;

}


void pusage(void)
{
	int16_t i;

    puts(title);
	for (i=0;usage[i] != NULL;i++) puts(usage[i]);
}



/* ------------------------------------------------------------------------ */
/* palette reader and helper functions                                      */
/* adapted from Clipshop                                                    */
/* ------------------------------------------------------------------------ */

/* strip line feeds from ascii file lines... */

void nocr(char *ptr) {
  int idx;
  for (idx = 0; ptr[idx] != 0; idx++)
    if (ptr[idx] == LFEED || ptr[idx] == CRETURN || ptr[idx] == '#')
      ptr[idx] = 0;
}

/*
squeeze redundant whitespace from lines read-in from a palette file
(leave only a single space character)
this is important if the user has created their own palette file
by hand... since they may accidentally type more than one whitespace
between RGB values...

Also, phototsyler version 2 palette file lines are fixed width,
right justified so we need to massage these for our reader...
*/
void SqueezeLine(char *ptr)
{
  int idx, jdx, len;
  char buf[128];

  idx = 0;
  while (ptr[idx] == ' ')idx++;  /* remove leading whitespace */
  strcpy(buf, &ptr[idx]);

  jdx = 0;
  ptr[jdx] = ASCIIZ;

  for (idx = 0; buf[idx] != ASCIIZ; idx++) {
    if (buf[idx] == 9) buf[idx] = ' ';         /* no tabs please */
    if (buf[idx] == ',') buf[idx] = ' ';       /* no commas please */
    if (buf[idx] == ' ' && buf[idx +1] == ' ')
      continue;
    /* truncate if any non-numeric characters */
    if ((buf[idx] < '0' || buf[idx] > '9') && buf[idx] != ' ')
      buf[idx] = ASCIIZ;
    ptr[jdx] = buf[idx]; jdx++;
    ptr[jdx] = ASCIIZ;
  }

  /* remove trailing whitespace...
    this occurrs during parsing of photostyler */
  len = strlen(ptr);
  while (len > 0) {
    len--;
    if (ptr[len] != ' ')
      break;
    ptr[len] = ASCIIZ;
  }
}

/* split the RGB triple from a text line read-in from an
   ascii palette file. */
int ReadPaletteLine(unsigned char *ptr, unsigned char *palptr, unsigned int colordepth)
{
  int red, green, blue, idx, spaces = 0;

  red = atoi(ptr);
  if (red < 0 || red > 255) return INVALID;

  /* there must be at least 3 fields */
  for (idx = 0; ptr[idx] != 0; idx++) {
    if (ptr[idx] == ' ' && ptr[idx+1] >= '0' && ptr[idx+1] <= '9') {
       spaces++;
       switch(spaces) {
         case 1:
           green = atoi(&ptr[idx+1]);
           if (green < 0 || green > 255) return INVALID;
           break;
         case 2:
           blue = atoi(&ptr[idx+1]);
           if (blue < 0 || blue > 255) return INVALID;
           break;
       }
    }
  }

  if (spaces<2)
    return INVALID;

  if (colordepth == 6) {
     palptr[0] = (uint8_t)red << 2;
     palptr[1] = (uint8_t)green << 2;
     palptr[2] = (uint8_t)blue << 2;
   }
   else {
     palptr[0] = (uint8_t)red;
     palptr[1] = (uint8_t)green;
     palptr[2] = (uint8_t)blue;
   }
   return SUCCESS;

}

/* check version if Paintshop palette since JASC may change someday */
/* also check Aldus version although that product is old... */

/* The Top Half of NeoPaint Windows Palettes are the same as their */
/* DOS palettes so we use the 6 bit color values and handle both   */
/* file types the same way... so no worry about neopaint versions. */

char *Gimp = "GIMP Palette"; /* followed by RGB values and comments */

/* NeoPaint and PaintShop Pro headers
   3 lines followed by RGB values */
char *NeoPaint  = "NeoPaint Palette File";
char *PaintShop = "JASC-PAL";
char *PaintShopVersion = "0100";

/* Aldus photostyler
   3 lines followed by RGB values */
char *AldusPal = "CWPAL";
char *AldusClr = "CWCLR";           /* partial palettes */
char *AldusVersion = "100";

#define GENERIC 1
#define GIMP 2
#define JASC 3
#define NEO 4
#define ALDUS 5

int16_t GetUserPalette(char *name)
{
	FILE *fp;
	char buf[128];
	int cnt=16;
	int16_t status = INVALID;
	unsigned colordepth=8,userpaltype=GENERIC;

	fp = fopen(name,"r");
	if (fp == NULL) return status;

	for (;;) {
  		if (NULL == fgets(buf, 128, fp)) {
    		fclose(fp);
    		break;
		}
  		nocr(buf);
  		SqueezeLine(buf);

        /* check for some known palette types */
  		if (strcmp(Gimp, buf)==0) userpaltype = GIMP;
  		else if (strcmp(PaintShop, buf)==0) userpaltype = JASC;
  		else if (strcmp(NeoPaint, buf)==0) {
  			colordepth = 6;
    		userpaltype = NEO;
  		}
  		else if (strcmp(AldusPal, buf) == 0 || strcmp(AldusClr, buf) == 0) {
	  		userpaltype = ALDUS;
  		}
  		/* if not a known type then assume it's just a simple csv */

  		status = SUCCESS;
		switch(userpaltype)
		{
			case GENERIC: rewind(fp); break;

			case JASC:
			case NEO:
			case ALDUS:
			    /* check 2 remaining header lines */
				status = INVALID;
				if (NULL == fgets(buf, 128, fp)) break;
				nocr(buf);
				SqueezeLine(buf);
				if (userpaltype == JASC && strcmp(PaintShopVersion, buf)!=0)break;
				if (userpaltype == ALDUS && strcmp(AldusVersion, buf) != 0)break;
				if (NULL == fgets(buf, 128, fp)) break;
				cnt = atoi(buf);
				if (cnt < 16) break;
				status = SUCCESS;
		}
		if (status == INVALID) break;

        memset(&rgbUser[0][0],0,48);
        cnt = 0;
		while (fgets(buf,128,fp) != NULL) {
			if (buf[0] == '#') continue;
			if (strlen(buf) < 5) continue;
  			nocr(buf);
  			SqueezeLine(buf);
    		if (INVALID == ReadPaletteLine(buf,(uint8_t *)&rgbUser[cnt][0],colordepth)) continue;
    		cnt++;
    		if (cnt > 15)break;
		}
		break;
	}
	fclose(fp);

	if (cnt < 15) {
		printf("%s contains only %d colors!",name,cnt);
	}
	if (status == INVALID) {
		printf("%s is not a valid palette file!",name);
	}
	return status;
}

/* returns the Apple II Hires drawcolor 0-15 */
/* a double hi-res pixel can occur at any one of 7 positions */
/* in a 4 byte block which spans aux and main screen memory */
/* the horizontal resolution is 140 pixels */
int dhrgetpixel(int x,int y)
{
    int xoff, pattern, idx;
    unsigned char *ptraux, *ptrmain,c1, c2, d1, d2;

    pattern = (x%7);
	xoff = HB[y] + ((x/7) * 2);
    ptraux  = (unsigned char *) &dhrbuf[xoff-0x2000];
    ptrmain = (unsigned char *) &dhrbuf[xoff];


	switch(pattern)
	{
		/* left this here for reference

		unsigned char dhrpattern[7][4] = {
		0,0,0,0,
		0,0,0,1,
		1,1,1,1,
		1,1,2,2,
		2,2,2,2,
		2,3,3,3,
        3,3,3,3};
        */

        /* compare colors in the input file to color patterns and return drawcolor */
        /* somewhat inelegant but lazy to read and debug if a problem */
		case 0: c1 = ptraux[0] &0x0f;
		        for (idx = 0; idx < 16; idx++) {
				  d1 = dhrbytes[idx][0] & 0x0f;
				  if (d1 == c1) return idx;
				}
		        break;
		case 1: c1 = ptraux[0] & 0x70;
		        c2 = ptrmain[0] & 0x01;
		        for (idx = 0; idx < 16; idx++) {
				  d1 = dhrbytes[idx][0] & 0x70;
				  d2 = dhrbytes[idx][1] & 0x01;
				  if (d1 == c1 && d2 == c2) return idx;
				}
		        break;
		case 2: c1 = ptrmain[0] & 0x1e;
		        for (idx = 0; idx < 16; idx++) {
				  d1 = dhrbytes[idx][1] & 0x1e;
				  if (d1 == c1) return idx;
				}
		        break;
		case 3: c1 = ptrmain[0] & 0x60;
		        c2 = ptraux[1] & 0x03;
		        for (idx = 0; idx < 16; idx++) {
				  d1 = dhrbytes[idx][1] & 0x60;
				  d2 = dhrbytes[idx][2] & 0x03;
				  if (d1 == c1 && d2 == c2) return idx;
				}
                break;
		case 4: c1 = ptraux[1] & 0x3c;
		        for (idx = 0; idx < 16; idx++) {
				  d1 = dhrbytes[idx][2] & 0x3c;
				  if (d1 == c1) return idx;
				}
		        break;
		case 5: c1 = ptraux[1] & 0x40;
 		        c2 = ptrmain[1] & 0x07;
		        for (idx = 0; idx < 16; idx++) {
				  d1 = dhrbytes[idx][2] & 0x40;
				  d2 = dhrbytes[idx][3] & 0x07;
				  if (d1 == c1 && d2 == c2) return idx;
				}
                break;
		case 6: c1 = ptrmain[1] & 0x78;
		        for (idx = 0; idx < 16; idx++) {
				  d1 = dhrbytes[idx][3] & 0x78;
				  if (d1 == c1) return idx;
				}
 		        break;
	}

    return INVALID;

}


int save_to_bmp24(void)
{

    FILE *fp;
    uint8_t tempr, tempg, tempb;
	int i,x,y, y2 = 191,idx = 1;
	uint16_t width = 280, height = 192, outpacket;

	fp = fopen(previewfile,"wb");
	if (NULL == fp) {
		printf("Error opening %s for writing!\n",previewfile);
		preview = 0;
		return INVALID;
	}

	if (mono == 1 && hgroutput == 0) {
		width = 560;
		height = 384;
		idx = 2;
	}

	/* write header for 24 bit bmp */
    outpacket = WriteDIBHeader(fp,width,height);
	if (outpacket == 0) {
		fclose(fp);
		remove(previewfile);
		printf("Error writing header to %s!\n",previewfile);
		preview = 0;
		return INVALID;
	}

	if (mono == 0) {
		/* write rgb triples and double each pixel to preserve the aspect ratio */
   		for (y = 0; y< 192; y++) {

		   for (x = 0; x < 140; x++) {
			  idx = dhrgetpixel(x,y2);

			  /* range check */
			  if (idx < 0 || idx > 15)idx = 0; /* default black */

			  tempr = rgbPreview[idx][0];
			  tempg = rgbPreview[idx][1];
			  tempb = rgbPreview[idx][2];

			  /* reverse order */
			  fputc(tempb, fp);
			  fputc(tempg, fp);
			  fputc(tempr, fp);

			  /* double-up */
			  fputc(tempb, fp);
			  fputc(tempg, fp);
			  fputc(tempr, fp);
		   }
		   y2 -= 1;
		}
	}
	else {
		for (y = 0;y< 192;y++,y2--) {
			if (width == 560) applemonobites(y2,1);
			else applemonobites(y2,0);
			for (i=0;i < idx;i++) {
				for (x = 0; x < width; x++) {
					if (buf280[x] == 0) tempb = 0;
					else tempb = 255;
					/* any order - black and white */
					fputc(tempb, fp);
					fputc(tempb, fp);
					fputc(tempb, fp);
				}
			}
		}
	}

	fclose(fp);
	return SUCCESS;

}

/* titling from a textfile */
/* only available for full-screen raw output */
/* no attempt at proportional spacing */
/* 4 x 6 font titling */
/* based on a 140 x 192 matrix */
/* 140 / 4 = 35 characters across */
/* 192 / 6 = 32 lines down */
int16_t GetUserTextFile()
{
	FILE *fp;
	char buf[128];
	int x,y,i,cnt=0;

	fp = fopen(usertextfile,"r");
	if (NULL == fp) {
		/* for batch operations */
		fp = fopen("b2d.txt","r");
		if (NULL == fp) return INVALID;
	}

    /* read up to 32 lines of text */
	for (i=0,y=0;i<32;i++,y+=6) {
  		if (NULL == fgets(buf, 128, fp)) {
    		break;
		}
  		nocr(buf);
  		if (buf[0] == 0) continue;
  	    buf[35] = 0;
  	    for (x=0;x<3;x++) {
			/* creating a black outline */
			thumbDHGR(buf,x,y,0,255,'L');
			/* skip the middle pixels, and fill-in color */
			if (x!=1)thumbDHGR(buf,x,y+1,0,255,'L');
			thumbDHGR(buf,x,y+2,0,255,'L');
		}
		/* now do the middle pixels */
		if (mono == 1) {
			/* for monochrome the letters are always white */
			thumbDHGR(buf,1,y+1,15,255,'L');
		}
		else {
			/* for color the letters can be any color at all except for black */
  			if (backgroundcolor == 0)thumbDHGR(buf,1,y+1,15,255,'L');
  			else thumbDHGR(buf,1,y+1,(unsigned char)backgroundcolor,255,'L');
		}
  		cnt++;
	}
	fclose(fp);

    /* if we have created titled output, and we have already written a preview image
       we need to over-write it with a titled version */
	if (cnt!= 0 && preview != 0) save_to_bmp24();

    /* at this point we just return */
	return SUCCESS;
}




int main(int argc, char **argv)
{
	int16_t idx,jdx,kdx,palidx=5,previewidx=5,hgrpalidx=5,pseudopal=0,
	       status,basename=0,plainname=0;
	uint8_t c, ch, *wordptr, *ptr;
	char hgroptions[20];

    if (argc < 2) {
		pusage();
		return (1);
	}

	/* allocate our output buffers to support MS-DOS compilers
	   but does no harm for 32-bit compilers
	*/
	dhrbuf = hgrbuf = (uint8_t *)malloc(8192);
	if (NULL != hgrbuf) {
		dhrbuf = (uint8_t *)malloc(16384);
	}
	if (dhrbuf == NULL) {
		puts("No memory...");
		return (1);
	}

    /* initialize color space for color distance */
	setluma();

    /* automatic naming is used for a number of reasons */
    /* I make no attempt to test for a legal ProDOS file name length - that's up to the user */
    /* but short names should be used when possible for a number of reasons */

    /* HGR output - options accumulator for HGR long filename - not available in MS-DOS */
    /* this differentiates BIN files created for HGR from AUX,BIN file pairs used for alternate output of DHGR */
    /* and from each other so they can be compared */
    /* for HGR output the preview file is an approximation so far */
    hgroptions[0] = 0;

    usertextfile[0] = 0;

    /* getopts */
    if (argc > 2) {
    	for (idx = 2; idx < argc; idx++) {
			/* switch character is optional */
	   		wordptr = (uint8_t *)&argv[idx][0];
	   		ch = toupper(wordptr[0]);
	   		if (ch == '-') {
				wordptr = (uint8_t *)&argv[idx][1];
                ch = toupper(wordptr[0]);
			}

			if (cmpstr(wordptr,"debug") == SUCCESS) {
				debug = 1;
				continue;
			}

            /* set different Luma for color distance */
            jdx = 0;
			if (cmpstr(wordptr,"GIMP") == SUCCESS) jdx = 411;
			else if (cmpstr(wordptr,"MAGICK") == SUCCESS) jdx = 709;
			else if (cmpstr(wordptr,"HDMI") == SUCCESS) jdx = 240;
			if (jdx != 0) {
			   lumaREQ = jdx;
			   printf("Using LumaREQ %d\n", lumaREQ);
			   setluma();
			   continue;
		    }

			/* so-called "quick" commands */
			if (cmpstr(wordptr,"photo") == SUCCESS) {
				dither = FLOYDSTEINBERG;
				continue;
			}
			if (cmpstr(wordptr,"art") == SUCCESS) {
				threshold = 25;
				xmatrix = 2;
				continue;
			}
			if (cmpstr(wordptr,"both") == SUCCESS) {
				dither = FLOYDSTEINBERG;
				threshold = 15;
				xmatrix = 2;
				continue;
			}
			if (cmpstr(wordptr,"sprite") == SUCCESS) {
				outputtype = SPRITE_OUTPUT;
				continue;
			}

			if (cmpstr(wordptr,"BIN") == SUCCESS) {
				applesoft = 1;
				continue;
			}

			if (cmpstr(wordptr,"sum") == SUCCESS) {
				errorsum = 1;
				continue;
			}

			if (cmpstr(wordptr,"mono") == SUCCESS || cmpstr(wordptr,"reverse") == SUCCESS) {
				mono = 1;
				if (dither == 0) dither = FLOYDSTEINBERG;
				if (cmpstr(wordptr,"reverse") == SUCCESS) reverse = 1;
				continue;
			}

            /* DOS 3.3 header will be appended to Apple II Output */
			if (cmpstr(wordptr,"dos") == SUCCESS) {
				dosheader = 1;
				continue;
			}

			/* TGR long commands */
			/* to select alternate conversion palette 15 from tohgr, instead of HGR use TGR for HGR long commands */
			if (ch == 'T') {
				c = toupper(wordptr[1]);
				if (c == 'G') {
					c = toupper(wordptr[2]);
					if (c == 'R') {
	                	wordptr[0] = ch = 'H';
	                	palidx = hgrpalidx = 16;
	                	puts("HGR Option TGR: tohgr HGR color conversion palette");
					}
				}
			}


		    switch(ch) {
				case 'A': /* output AUX,BIN - default is A2FC */
				          applesoft = 1;
				          break;
				case 'B':
 				          c = wordptr[1];
 				          if (c == (uint8_t)0) break;

						  if (cmpstr("basename", (char *)&wordptr[0]) == SUCCESS ||
				              cmpstr("base", (char *)&wordptr[0]) == SUCCESS) {
							   basename = 1;
							   break;
						  }

						  /* background color 1-15 (0 by default) */
 				          c = PaintByNumbers((char *)&wordptr[1]);
 				          if (c!= (uint8_t)255) backgroundcolor = c;
				          break;

				case 'C': ch = toupper(wordptr[1]);
				          if (ch == 'P' || ch == 'V') {
							  paletteclip = 1;
							  break;
						  }
				          globalclip = 1;
				          break;

                case 'D': if (cmpstr("DL", (char *)&wordptr[0]) == SUCCESS) {
					          /* DLGR output */
					  		  loresoutput = 1;
					  		  break;
					  	  }

                          dither = FLOYDSTEINBERG;

                          if (ReadCustomDither((char *)&wordptr[1]) == SUCCESS) {
							  break;
						  }

						  ch = toupper(wordptr[1]);
						  if (ch == 'X') {
							  wordptr++;
							  serpentine = 1;
						  }

                		  jdx = atoi((char *)&wordptr[1]);
                		  if (jdx > 0 && jdx < 10) dither = jdx;
                		  else {
							  ch = toupper(wordptr[1]);
							  switch(ch) {
								  case 'F': dither = FLOYDSTEINBERG;break;
								  case 'J': dither = JARVIS;break;
								  case 'S': dither = STUCKI;
								            ch = toupper(wordptr[2]);
								            if (ch == 'I') dither = SIERRA;
								            else if (ch == '2') dither = SIERRATWO;
								            else if (ch == 'L') dither = SIERRALITE;
								            break;
								  case 'A': dither = ATKINSON;break;
								  case 'B': dither = BURKES;
								            ch = toupper(wordptr[2]);
								            if (ch == 'B') dither = 9;
								            break;
							  }
						  }
                          break;


				case 'E':
                          /* error diffusion default = E2 */
                          diffuse = 2;
                          jdx = atoi((char *)&wordptr[1]);
                          /* E4 */
                          if (jdx == 4) diffuse = 4;
                          break;

				case 'F': /* image fragment - off by default */
				          outputtype = SPRITE_OUTPUT;
				          ch = toupper(wordptr[1]);
				          if (ch == 'M') spritemask = 1;
				          break;

				case 'J':
						   /* scaling of larger sizes is pixel by pixel
						      when justification is selected */
						   justify = 1;
				           ch = toupper(wordptr[1]); /* justify */
						   switch(ch) {
							   case 'L': jxoffset = atoi((char *)&wordptr[2]);
							             break;
							   case 'T': jyoffset = atoi((char *)&wordptr[2]);
							             break;

						   }
						   break;

				case 'H':  /* HGR output - command option 'H' */
				           /* some options follow */
				           hgroutput = 1;
				           if (hgroptions[0] == (char)0){
							   /* if we are using Sheldon's HGR palette we use the TC suffix */
							   /* if we are using Sheldon's DHGR palette modified for HGR we use the C suffix */
							   if (hgrpalidx == 16)strcat(hgroptions,"TC");
							   else strcat(hgroptions,"C");
							   clearcolor = 3; /* set overlay color to violet */
						   }
				           /* default long file name for HGR color */
				           /* HGR long commands - can be followed by separate HGR short commands to over-ride fixed settings */
				           /* by default individual pixels are set */

				           /* hgrclean = X, hgrclip = Y, hgrsum = Z */
				           for (;;) {
							   jdx = strlen((char *)&wordptr[0]);
							   if (jdx < 6 || jdx > 9) break;
							   if (jdx == 8 || jdx == 9) {
								   if (jdx == 8) ptr = (char *)&wordptr[3];
								   else ptr = (char *)&wordptr[4];
								   if (cmpstr("clean", (char *)&ptr[0]) == SUCCESS) {
									    printf("HGR Option X: %s\n",(char *)&ptr[0]);
										globalclip = errorsum = 1;
										ptr[0] = 0;
										strcat(hgroptions,"X");
										jdx = 0;
								   }
							   }
							   if (jdx < 6 || jdx > 8) break;
							   jdx = strlen((char *)&wordptr[0]);
							   if (jdx == 7 || jdx == 8) {
								   if (jdx == 7) ptr = (char *)&wordptr[3];
								   else ptr = (char *)&wordptr[4];
								   if (cmpstr("clip", (char *)&ptr[0]) == SUCCESS) {
									    printf("HGR Option Y: %s\n",(char *)&ptr[0]);
										globalclip = 1;
										ptr[0] = 0;
										strcat(hgroptions,"Y");
										jdx = 0;
								   }
							   }
							   if (jdx < 6 || jdx > 8) break;
							   jdx = strlen((char *)&wordptr[0]);
							   if (jdx == 6 || jdx == 7) {
								   if (jdx == 6) ptr = (char *)&wordptr[3];
								   else ptr = (char *)&wordptr[4];
								   if (cmpstr("sum", (char *)&ptr[0]) == SUCCESS) {
									    printf("HGR Option Z: %s\n",(char *)&ptr[0]);
										errorsum = 1;
										ptr[0] = 0;
										strcat(hgroptions,"Z");
								   }
							   }
							   break;
						   }

						   jdx = strlen((char *)&wordptr[0]);
						   switch(jdx) {
							   /* long commands */
							   case 3:
								   if (cmpstr("hgr", (char *)&wordptr[0]) == SUCCESS) {
									   if (hgrcolortype == (char)0) hgrcolortype = 'B';
								   }
								   break;
							   case 4:
								   if (cmpstr("hgrs", (char *)&wordptr[0]) == SUCCESS) {
									   /* optionally single colored pixels are set */
									   if (hgrcolortype == (char)0) hgrcolortype = 'B';
									   doublecolors = 0;
									   puts("HGR Option S: single color pixels");
									   strcat(hgroptions,"S");
								   }
								   else if (cmpstr("hgrw", (char *)&wordptr[0]) == SUCCESS) {
									   /* optionally double colors are set with a double white overlay */
									   if (hgrcolortype == (char)0) hgrcolortype = 'B';
									   puts("HGR Option W: double color and white pixels");
									   doublecolors = 1;
									   doublewhite = 1;
									   strcat(hgroptions,"W");
								   }
								   else if (cmpstr("hgrb", (char *)&wordptr[0]) == SUCCESS) {
									   /* optionally double colors are set with a double black overlay */
									   if (hgrcolortype == (char)0) hgrcolortype = 'B';
									   puts("HGR Option B: double color and black pixels");
									   doublecolors = 1;
									   doubleblack = 1;
									   strcat(hgroptions,"B");
								   }
								   else if (cmpstr("hgro", (char *)&wordptr[0]) == SUCCESS) {
										/* set HGR output for orange and blue only */
										/* color type is not needed */
										/* no pixel options - individual pixels only */
										puts("HGR Option O: Orange and Blue Palette Only");
										grpal[3][0]   = grpal[3][1]   = grpal[3][2]   = 0;
										grpal[12][0]  = grpal[12][1]  = grpal[12][2]  = 0;
										hgrpaltype = 0x80;
										strcat(hgroptions,"O");
										hgrdither = 0;

									}
									else if (cmpstr("hgrg", (char *)&wordptr[0]) == SUCCESS) {
										/* set HGR output for green and violet only */
										/* color type is not needed */
										/* no pixel options - individual pixels only */
										clearcolor = 6; /* set overlay color to blue */
										puts("HGR Option G: Green and Violet Palette Only");
										grpal[6][0]  = grpal[6][1]  = grpal[6][2]  = 0;
										grpal[9][0]  = grpal[9][1]  = grpal[9][2]  = 0;
										hgrpaltype = 0;
										strcat(hgroptions,"G");
										hgrdither = 0;
									}
									else if (cmpstr("hgr2",(char *)&wordptr[0]) == SUCCESS) {
										puts("HGR alternate nearest color option");
										strcat(hgroptions,"A");
										hgrdither = 1;
									}
									break;
							   case 1:
							   case 2:
									/* short commands */
									ch = toupper(wordptr[1]);
									if (ch == 'O' || ch == 'G' || ch == 'B' || ch == 'V' || ch == (char)0) {
										/* this command sets color precedence for the palette bit
										   the default is 'O' orange

										   'HO' and 'HG' set strong precedence
										   'HB' and 'HV' set weak precedence
										   'H' by itself sets equal precedence

										   regardless of precedence both palettes will be used unless specifically disabled
										   by 'HGRO' or 'HGRG' which sets 4 color HGR output.

										*/
										if (ch == (char)0) {
											puts("HGR Precedence Over-ride: Equal");
										}
										else if (ch == 'B' || ch == 'V') {
											printf("HGR Precedence Over-ride: Weak %c\n",ch);
										}
										else {
											printf("HGR Precedence Over-ride: Strong %c\n",ch);
										}
										wordptr[1] = hgrcolortype = ch;
										wordptr[0] = toupper(wordptr[0]);
										strcat(hgroptions,(char *)&wordptr[0]);
								   }
							   }


							/* Low-resolution colors
							   0 (black),
							   3 (purple),
							   6 (medium blue),
							   9 (orange),
							   12 (light green) and
							   15 (white) are also available in high-resolution mode */
							/*

							/* disable the unused colors in the default palette */
							/* these will be propagated to any alternate palettes that are selected */
							grpal[1][0] = grpal[1][1] = grpal[1][2] = 0;
							grpal[2][0] = grpal[2][1] = grpal[2][2] = 0;
							grpal[4][0] = grpal[4][1] = grpal[4][2] = 0;
							grpal[5][0] = grpal[5][1] = grpal[5][2] = 0;
							grpal[7][0] = grpal[7][1] = grpal[7][2] = 0;
							grpal[8][0] = grpal[8][1] = grpal[8][2] = 0;
							grpal[10][0] = grpal[10][1] = grpal[10][2] = 0;
							grpal[11][0] = grpal[11][1] = grpal[11][2] = 0;
							grpal[13][0] = grpal[13][1] = grpal[13][2] = 0;
							grpal[14][0] = grpal[14][1] = grpal[14][2] = 0;
 				          	break;
                case 'L':
                          if (wordptr[1] == (char) 0 || cmpstr(wordptr,"lgr") == SUCCESS) {
	                          /* LGR output */
 	                         lores = loresoutput = 1;
 	                         break;
	 					  }

                          /* Luma */
                          jdx = atoi((char *)&wordptr[1]);
                          if (jdx == 601 || jdx == 709 || jdx == 240 || jdx == 911 || jdx == 411) {
							  lumaREQ = jdx;
							  printf("Using LumaREQ %d\n", lumaREQ);
							  setluma();
							  break;
						  }
						  break;

                case 'M': /* M2 - horizontal merge - S2 mode only */
                          /* by default every second pixel is skipped */
                          merge = 1;
                          break;

                case 'O': /* use an 8 bit overlay file - must be 140 x 192 */
                          /* transparent color must be set or default is 128,128,128 - color 5 */
 				          c = wordptr[1];
 				          if (c == (uint8_t)0) break;
 						  c = PaintByNumbers((char *)&wordptr[1]);
 				          if (c!= (uint8_t)255) {
 				        	clearcolor = c; break;
						  }
                          overlay = 1;
                		  strcpy(maskfile,(char *)&wordptr[1]);
                		  /* maskfile must have an extension or .bmp is assumed */
                		  /* this avoids typing extensions which I dislike doing */
                		  /* so I provide expected extensions. any questions? */
                	      kdx = 999;
                	      for (jdx=0;maskfile[jdx]!=0;jdx++) {
							  if (maskfile[jdx] == '.')kdx = jdx;
						  }
						  if (kdx == 999)strcat(maskfile,".bmp");
                		  break;

				case 'V': /* create preview file */
				          preview = 1;
				          if (wordptr[1] == 0) break;
				          if (cmpstr(wordptr,"vbmp") == SUCCESS) {
						      vbmp = 1;
							  break;
						  }

				case 'P':
				          if (cmpstr("plainname", (char *)&wordptr[0]) == SUCCESS ||
				              cmpstr("plain", (char *)&wordptr[0]) == SUCCESS) {
						 		plainname = 1;
						  		break;
						   }

						  /* palette settings */
				          c = toupper(wordptr[1]);
 				          /* check for palette names */
 				          if (c > 57) {
							c = 255;
							if (cmpstr("kegs32", (char *)&wordptr[1]) == SUCCESS ||
							    cmpstr("kegs", (char *)&wordptr[1]) == SUCCESS)c = previewidx = palidx = 0;
 				            else if (cmpstr("cider", (char *)&wordptr[1]) == SUCCESS ||
 				                     cmpstr("ciderpress", (char *)&wordptr[1]) == SUCCESS)c = previewidx = palidx = 1;
 				          	else if (cmpstr("old", (char *)&wordptr[1]) == SUCCESS)c = previewidx = palidx = 2;
 				          	else if (cmpstr("new", (char *)&wordptr[1]) == SUCCESS ||
 				          	         cmpstr("applewin", (char *)&wordptr[1]) == SUCCESS)c = previewidx = palidx = 3;
 				          	else if (cmpstr("wikipedia", (char *)&wordptr[1]) == SUCCESS ||
 				          	         cmpstr("wiki", (char *)&wordptr[1]) == SUCCESS)c = previewidx = palidx = 4;
 				          	/* Sheldon Simms tohgr and AppleWin NTSC */
 				          	else if (cmpstr("sheldon", (char *)&wordptr[1]) == SUCCESS ||
 				          	         cmpstr("todhr", (char *)&wordptr[1]) == SUCCESS ||
 				          	         cmpstr("ntsc", (char *)&wordptr[1]) == SUCCESS)c = previewidx = palidx = 5;
 				          	/* Jason Harper's Super Convert DHGR Palette */
 				          	else if (cmpstr("rgb", (char *)&wordptr[1]) == SUCCESS ||
						             cmpstr("super", (char *)&wordptr[1]) == SUCCESS ||
							         cmpstr("gs", (char *)&wordptr[1]) == SUCCESS) c = previewidx = palidx = 12;
							/* Jace DHGR Palette */
							else if (cmpstr("jace", (char *)&wordptr[1]) == SUCCESS ||
							         cmpstr("blurry", (char *)&wordptr[1]) == SUCCESS) c = previewidx = palidx = 13;
							/* Cybnernesto */
							else if (cmpstr("cybernesto", (char *)&wordptr[1]) == SUCCESS)c = previewidx = palidx = 14;
							else if (cmpstr("canvas", (char *)&wordptr[1]) == SUCCESS)c = 7;
 				          	else if (cmpstr("bmp", (char *)&wordptr[1]) == SUCCESS)c = 8;
 				          	else if (cmpstr("win16", (char *)&wordptr[1]) == SUCCESS)c = 8;
 				          	else if (cmpstr("xmp", (char *)&wordptr[1]) == SUCCESS)c = 9;
 				          	else if (cmpstr("win32", (char *)&wordptr[1]) == SUCCESS)c = 9;
 				          	else if (cmpstr("vga", (char *)&wordptr[1]) == SUCCESS)c = 10;
 				          	else if (cmpstr("pcx", (char *)&wordptr[1]) == SUCCESS)c = 11;
 				          	if (c!= 255) {
								if (ch == 'P') palidx = c;
							 	else previewidx = c;
 				        		break;
							}
						  }

				          jdx = GetUserPalette((char *)&wordptr[1]);
				          if (jdx == SUCCESS) {
							 if (ch == 'P') palidx = 6;
							 else previewidx = 6;
						  }
						  else {


				          	c = toupper(wordptr[1]);

				          	if (c == 'P') {
								/* pseudo palette */
								if (wordptr[2] > (char)47 && wordptr[2] < (char)58) {
									jdx = atoi((char *)&wordptr[2]);
									if ((jdx < 0 || jdx > 16) || jdx == 15) break;
									if (pseudocount < PSEUDOMAX) {
									     pseudolist[pseudocount] = jdx;
									     pseudocount++;
										 pseudopal = 1;
										 break;
									}
								}

							}

                            if (c == 'K' || c == 'C' || c == 'O' || c == 'N' || c == 'W' || c == 'S'||
				          	         c == 'R' || c == 'G' || c == 'E' || c == 'J' || c == 'V') {
							  jdx=0; /* Kegs */
							  switch(c) {
								  case 'R': /* RGB */
								  case 'G': jdx = 12; break; /* Apple II "G" (IIgs) - RGB display */
								  case 'J': jdx = 13; break; /* Jace NTSC Palette */
								  case 'V': jdx = 14; break; /* VBMP NTSC Palette */
								  case 'E':       /* Apple II "E" (IIe)  - composite display */
								  case 'S': jdx++;/* Sheldon Simms NTSC Palette */
								  case 'W': jdx++;/* Wikipedia NTSC */
								  case 'N': jdx++;/* New AppleWin */
								  case 'O': jdx++;/* Old AppleWin */
								  case 'C': jdx++;/* CiderPress */
							  }

						  	}
						  	else {
							 	if (c < 48 || c > 59) break;
				          	 	jdx = atoi((char *)&wordptr[1]);
						  	}
						  	/* palettes 0-5 are the original palettes */
						  	/* palette 6 is a user palette file */
						  	/* palettes 7-11 are legacy palettes */
						  	/* palette 12 is Super Convert RGB palette */
						  	/* palette 13 is Jace NTSC palette */
						  	/* palette 14 is Cybernesto's VBMP NTSC palette */
						  	/* palette 15 defaults to a Pseudo-Palette of the average RGB values
						  	   of Palette 5 (tohgr NTSC) and Palette 12 (Super Convert RGB) */
						  	/* palette 16 is tohgr's old NTSC colors which as of June 2014 are still used for HGR conversion */
				          	if (jdx > -1 && jdx < 17) {
							  	if (ch == 'P') palidx = jdx;
							  	else previewidx = jdx;
						  	}
						  }
				          break;
				case 'Q': quietmode = 0;
				          break;

				case 'R': /* reduced or increased color bleed
				             by percentage (for dithering only) */

						  jdx = atoi((char *)&wordptr[1]);
						  if ((jdx > 0 && jdx < 101) || (jdx < 0 && jdx > -101)) colorbleed = 100 + jdx;
						  break;

				case 'S': /* by default scaling is set to S1 - full scale (verbatim) */
				          /* so choosing option S without the S1 numeric modifier sets scaling to half-scale */
				          jdx = atoi((char *)&wordptr[1]);

				          if (jdx == 1) scale = 0; /* S1 full scale (verbatim) */
				          else scale = 1; /* S2 - double scaled */
				          break;
				case 'T': if (cmpstr("op", (char *)&wordptr[1]) == SUCCESS) {
					  		  /* LGR and DLGR mixed text and graphics */
					  		  loresoutput = appletop = 1;
					  		  break;
					  	  }
				          /* use ciderpress tags - off by default */
				          tags = 1;
				          break;
                case 'X': /* pattern setting for general purpose 2 x 2 cross-hatching */
                          xmatrix = 2;
                          if (threshold == 0) threshold = 25;
                          /* optional pattern setting for general purpose 2 x 2 cross-hatching */
                          jdx = atoi((char *)&wordptr[1]);
                          if (jdx == 1 || jdx == 3) xmatrix = jdx;
                          break;
                case 'Y': /* increase or decrease color - non-cross-hatched ouput */
                          /* this can eventually be replaced by a saturation adjustment or
                             a hue correction or something else */
                          ymatrix = 1;
                          jdx = atoi((char *)&wordptr[1]);
                          if (jdx == 2 || jdx == 3) ymatrix = jdx;
                          break;

				case 'Z': /* threshold setting for general purpose 2 x 2 cross-hatching */
				          /* and for brightening and darkening of colors */
				          threshold = 25;
				          if (xmatrix == 0)xmatrix = 2;
				          jdx = atoi((char *)&wordptr[1]);
				          /* allow up to 50% adjustment on RGB values */
				          /* surely that's enough */
				          if (jdx > 0 && jdx < 51) threshold = jdx;
				          break;

			}
		}
	}

	/* mutually exclusive commands are handled here */
	if (hgroutput == 1) {
		if (loresoutput == 1) {
			loresoutput = 0;
			puts("HGR output and Lo-Res output are mutually exclusive.\nLo-Res output cancelled!");
		}
		/*
		if (outputtype == SPRITE_OUTPUT) {
			outputtype = BIN_OUTPUT;
			puts("HGR output and Image Fragment output are mutually exclusive.\nImage Fragment output cancelled!");
		}
		*/
		if (mono == 1) {
			mono = 0;
			puts("HGR output and Monochrome output are mutually exclusive.\nMonochrome output cancelled!");
		}
	}
	else {
		hgrdither = 0;
	}

	if (mono == 1) {
		if (loresoutput == 1) {
			loresoutput = 0;
			puts("Monochrome output and Lo-Res output are mutually exclusive.\nLo-Res output cancelled!");
		}
		if (outputtype == SPRITE_OUTPUT) {
			mono = 0;
			puts("Image Fragment output and Monochrome output are mutually exclusive.\nMonochrome output cancelled!");
		}
	}

	if (loresoutput == 1) {
		overlay = 0;
		if (outputtype == SPRITE_OUTPUT) {
			outputtype = BIN_OUTPUT;
			puts("Lo-Res output and Image Fragment output are mutually exclusive.\nImage Fragment output cancelled!");
		}
	}

    /* embedding of image fragments or palette output only */
    if (outputtype != SPRITE_OUTPUT) {
		if (pseudopal == 0) quietmode = 1;
	}

    jdx = 999;
	strcpy(fname, argv[1]);
	for (idx = 0; fname[idx] != (uint8_t)0; idx++) {
		if (fname[idx] == '.') {
			jdx = idx;
		}
	}
    if (jdx != 999) fname[jdx] = (uint8_t)0;

    sprintf(bmpfile,"%s.bmp",fname);
    sprintf(dibfile,"%s.dib",fname);
#ifdef MSDOS
	tags = 0;
    sprintf(previewfile,"%s.pmp",fname);
    sprintf(scaledfile,"%s.smp",fname);
    sprintf(reformatfile,"%s.rmp",fname);
    sprintf(vbmpfile,"%s.vmp",fname);
#else
    sprintf(previewfile,"%s_Preview.bmp",fname);
    sprintf(scaledfile,"%s_Scaled.bmp",fname);
    sprintf(reformatfile,"%s_Reformat.bmp",fname);
    sprintf(vbmpfile,"%s_VBMP.bmp",fname);
#endif
    /* user titling file */
    sprintf(usertextfile,"%s.txt",fname);

    /* upper case basename for Apple II Output */
    for (idx = 0; fname[idx] != (uint8_t)0; idx++) {
		ch = toupper(fname[idx]);
		fname[idx] = ch;
	}
	strcpy(hgrwork,fname);

	if (basename == 1) {
		/* if they are using the same naming convention that I am */
	    /* optionally strip the resolution nomenclature from the input file's base name */
		idx = strlen(hgrwork);
		if (idx > 3) {
			/* in order below: 384 - 560 x 384
			                   280 - 280 x 192
			                   640 - 640 x 480
			                   400 - 640 x 400
			                   320 - 320 x 200
			                   140 - 140 x 192
			                   560 - 560 x 192

			                   LGR and DLGR only

			                   176 - 176 x 104
			                   160 - 160 x 80 and 160 x 96
			                   88  - 88 x 52
                               80  - 80 x 40 and 80 x 48
			                   48  - 80 x 48 and 40 x 48
			                   40  - 80 x 40 and 40 x 40
			*/
			if (hgrwork[idx-3] == '3' && hgrwork[idx-2] == '8' && hgrwork[idx-1] == '4') hgrwork[idx - 3] = 0;
			else if (hgrwork[idx-3] == '2' && hgrwork[idx-2] == '8' && hgrwork[idx-1] == '0') hgrwork[idx - 3] = 0;
			else if (hgrwork[idx-3] == '6' && hgrwork[idx-2] == '4' && hgrwork[idx-1] == '0') hgrwork[idx - 3] = 0;
			else if (hgrwork[idx-3] == '4' && hgrwork[idx-2] == '0' && hgrwork[idx-1] == '0') hgrwork[idx - 3] = 0;
			else if (hgrwork[idx-3] == '3' && hgrwork[idx-2] == '2' && hgrwork[idx-1] == '0') hgrwork[idx - 3] = 0;
			else if (hgrwork[idx-3] == '1' && hgrwork[idx-2] == '4' && hgrwork[idx-1] == '0') hgrwork[idx - 3] = 0;
			else if (hgrwork[idx-3] == '5' && hgrwork[idx-2] == '6' && hgrwork[idx-1] == '0') hgrwork[idx - 3] = 0;
			else if (hgrwork[idx-3] == '1' && hgrwork[idx-2] == '7' && hgrwork[idx-1] == '6') hgrwork[idx - 3] = 0;
			else if (hgrwork[idx-3] == '1' && hgrwork[idx-2] == '6' && hgrwork[idx-1] == '0') hgrwork[idx - 3] = 0;

			if (hgrwork[idx - 3] != (char)0) {
				/* LGR and DLGR only */
				if (hgrwork[idx-2] == '8' && hgrwork[idx-1] == '8') hgrwork[idx - 2] = 0;
				else if (hgrwork[idx-2] == '8' && hgrwork[idx-1] == '0') hgrwork[idx - 2] = 0;
				else if (hgrwork[idx-2] == '4' && hgrwork[idx-1] == '8') hgrwork[idx - 2] = 0;
				else if (hgrwork[idx-2] == '4' && hgrwork[idx-1] == '0') hgrwork[idx - 2] = 0;
			}
		}
	}

    /* CiderPress File Attribute Preservation Tags */
    if (tags == 1) {
		if (hgroutput == 0)
			sprintf(spritefile,"%s.DHR#062000",hgrwork);
		else
			sprintf(spritefile,"%s.RAG#062000",hgrwork);

		sprintf(fmask,"%s.DHM#062000",hgrwork);
		sprintf(mainfile,"%s.BIN#062000",hgrwork);
		sprintf(auxfile,"%s.AUX#062000",hgrwork);
		sprintf(a2fcfile,"%s.A2FC#062000",hgrwork);
		if (plainname == 0) {
		    sprintf(hgrcolor,"%s%s.BIN#062000",hgrwork,hgroptions);
			sprintf(hgrmono,"%sM.BIN#062000",hgrwork);
			if (mono == 1) {
				sprintf(a2fcfile,"%s.A2FM#062000",hgrwork);
				sprintf(mainfile,"%sM.BIN#062000",hgrwork);
				sprintf(auxfile,"%sM.AUX#062000",hgrwork);
			}
		}
		else {
			sprintf(hgrcolor,"%s.BIN#062000",hgrwork);
			sprintf(hgrmono,"%s.BIN#062000",hgrwork);
		}
	}
    else {
		/* tags are off by default */
		/* unadorned file names */
		if (hgroutput == 0)
			sprintf(spritefile,"%s.DHR",hgrwork);
		else
			sprintf(spritefile,"%s.RAG",hgrwork);

		sprintf(fmask,"%s.DHM",hgrwork);
		sprintf(mainfile,"%s.BIN",hgrwork);
		sprintf(auxfile,"%s.AUX",hgrwork);
#ifdef MSDOS
		if (plainname == 0 && mono == 1)
			sprintf(a2fcfile,"%s.2FM",hgrwork);
		else
		  	sprintf(a2fcfile,"%s.2FC",hgrwork);
		strcpy(hgrcolor,hgrwork);
		strcpy(hgrmono,hgrwork);
#else
		sprintf(a2fcfile,"%s.A2FC",hgrwork);

		if (plainname == 0) {
		    sprintf(hgrcolor,"%s%s.BIN",hgrwork,hgroptions);
			sprintf(hgrmono,"%sM.BIN",hgrwork);
			if (mono == 1) {
				sprintf(a2fcfile,"%s.A2FM",hgrwork);
				sprintf(mainfile,"%sM.BIN#062000",hgrwork);
				sprintf(auxfile,"%sM.AUX#062000",hgrwork);
			}
		}
		else {
			sprintf(hgrcolor,"%s.BIN",hgrwork);
			sprintf(hgrmono,"%s.BIN",hgrwork);
		}
#endif
	}

	if (mono == 1) {
		palidx = previewidx = 4;
		/* create a black and white palette */
		memset(&wikipedia[0][0],0,45);
	}
	else {
		/* create pseudo-palette for conversion */
		/* preview using pseudopalette is optional - v15 */
		if (pseudopal != 0) {
			BuildPseudoPalette(palidx);
			palidx = 15;
		}
	}

  	GetBuiltinPalette(palidx,previewidx,0);
    InitDoubleArrays();

    if (mono == 1) status = ConvertMono();
    else status = Convert();

    /* close mask file if any before exiting */
    if (NULL != fpmask) fclose(fpmask);

    free(dhrbuf);
    free(hgrbuf);

    if (status == INVALID) return (1);

	return SUCCESS;
}


