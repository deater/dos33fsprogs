/* ---------------------------------------------------------------------
Bmp2DHR (C) Copyright Bill Buckels 2014.
All Rights Reserved.

Module Name - Description
-------------------------

tomthumb.h - header file for b2d.h (main program header)

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
/* ------------------------------------------------------------------------
Written by   : Bill Buckels
               Based on a font by Brian Swetland and Robey Pointer

Date Ported  : July 2014
               1.0 First Release - cc65
               cross-development environment for current cc65 snapshot
               includes Windows, Linux, and Mac OSX
Licence      : You may use this program for whatever you wish as long
               as you agree that Bill Buckels has no warranty or
               liability obligations whatsoever from said use.
------------------------------------------------------------------------ */

/*

The "Tom Thumb" Font (below) was originally developed as a Palm Pilot
font by developer Brian Swetland, and "fine-tuned" as a derivative
work by Robey Pointer, robeypointer@gmail.com:

http://robey.lag.net/2010/01/23/tiny-monospace-font.html */

/*

The Tom Thumb Font is a derivative work partially covered under the
following Copyright and Conditions of use:

** Copyright 1999 Brian J. Swetland
** Copyright 1999 Vassilii Khachaturov
** Portions (of vt100.c/vt100.h) copyright Dan Marks
**
** All rights reserved.
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions
** are met:
** 1. Redistributions of source code must retain the above copyright
**    notice, this list of conditions, and the following disclaimer.
** 2. Redistributions in binary form must reproduce the above copyright
**    notice, this list of conditions, and the following disclaimer in the
**    documentation and/or other materials provided with the distribution.
** 3. The name of the authors may not be used to endorse or promote products
**    derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
** IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
** OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
** IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
** INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
** NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
** THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

/* the following version of the Tom Thumb Font was entirely
   hand-made by me in my programmer’s editor by simply looking at
   a bitmap of the font characters and counting pixels.

   Licence: You may use this program for whatever you wish as long
            as you agree that Bill Buckels has no warranty or
            liability obligations whatsoever from said use.
*/

#ifndef TOMTHUMB_H
#define TOMTHUMB_H 1

/* unsigned char tomthumb[96][6][3] */
unsigned char tomthumb[1728] = {
/* 32 */
0,0,0,
0,0,0,
0,0,0,
0,0,0,
0,0,0,
0,0,0,
/* ! */
0,1,0,
0,1,0,
0,1,0,
0,0,0,
0,1,0,
0,0,0,
/* " */
1,0,1,
1,0,1,
0,0,0,
0,0,0,
0,0,0,
0,0,0,
/* # */
1,0,1,
1,1,1,
1,0,1,
1,1,1,
1,0,1,
0,0,0,
/* $ */
0,1,1,
1,1,0,
0,1,1,
1,1,0,
0,1,0,
0,0,0,
/* % */
1,0,0,
0,0,1,
0,1,0,
1,0,0,
0,0,1,
0,0,0,
/* & */
1,1,0,
1,1,0,
1,1,1,
1,0,1,
0,1,1,
0,0,0,
/* ' */
0,1,0,
0,1,0,
0,0,0,
0,0,0,
0,0,0,
0,0,0,
/* ( */
0,0,1,
0,1,0,
0,1,0,
0,1,0,
0,0,1,
0,0,0,
/* ) */
1,0,0,
0,1,0,
0,1,0,
0,1,0,
1,0,0,
0,0,0,
/* * */
1,0,1,
0,1,0,
1,0,1,
0,0,0,
0,0,0,
0,0,0,
/* + */
0,0,0,
0,1,0,
1,1,1,
0,1,0,
0,0,0,
0,0,0,
/* , */
0,0,0,
0,0,0,
0,0,0,
0,1,0,
1,0,0,
0,0,0,
/* - */
0,0,0,
0,0,0,
1,1,1,
0,0,0,
0,0,0,
0,0,0,
/* . */
0,0,0,
0,0,0,
0,0,0,
0,0,0,
0,1,0,
0,0,0,
/* / */
0,0,1,
0,0,1,
0,1,0,
1,0,0,
1,0,0,
0,0,0,
/* 0 */
0,1,1,
1,0,1,
1,0,1,
1,0,1,
1,1,0,
0,0,0,
/* 1 */
0,1,0,
1,1,0,
0,1,0,
0,1,0,
0,1,0,
0,0,0,
/* 2 */
1,1,0,
0,0,1,
0,1,0,
1,0,0,
1,1,1,
0,0,0,
/* 3 */
1,1,0,
0,0,1,
0,1,0,
0,0,1,
1,1,0,
0,0,0,
/* 4 */
1,0,1,
1,0,1,
1,1,1,
0,0,1,
0,0,1,
0,0,0,
/* 5 */
1,1,1,
1,0,0,
1,1,0,
0,0,1,
1,1,0,
0,0,0,
/* 6 */
0,1,1,
1,0,0,
1,1,1,
1,0,1,
1,1,1,
0,0,0,
/* 7 */
1,1,1,
0,0,1,
0,1,0,
1,0,0,
1,0,0,
0,0,0,
/* 8 */
1,1,1,
1,0,1,
1,1,1,
1,0,1,
1,1,1,
0,0,0,
/* 9 */
1,1,1,
1,0,1,
1,1,1,
0,0,1,
1,1,0,
0,0,0,
/* : */
0,0,0,
0,1,0,
0,0,0,
0,1,0,
0,0,0,
0,0,0,
/* ; */
0,0,0,
0,1,0,
0,0,0,
0,1,0,
1,0,0,
0,0,0,
/* < */
0,0,1,
0,1,0,
1,0,0,
0,1,0,
0,0,1,
0,0,0,
/* = */
0,0,0,
1,1,1,
0,0,0,
1,1,1,
0,0,0,
0,0,0,
/* > */
1,0,0,
0,1,0,
0,0,1,
0,1,0,
1,0,0,
0,0,0,
/* ? */
1,1,1,
0,0,1,
0,1,0,
0,0,0,
0,1,0,
0,0,0,
/* @ */
0,1,0,
1,0,1,
1,1,1,
1,0,0,
0,1,1,
0,0,0,
/* A */
0,1,0,
1,0,1,
1,1,1,
1,0,1,
1,0,1,
0,0,0,
/* B */
1,1,0,
1,0,1,
1,1,0,
1,0,1,
1,1,0,
0,0,0,
/* C */
0,1,1,
1,0,0,
1,0,0,
1,0,0,
0,1,1,
0,0,0,
/* D */
1,1,0,
1,0,1,
1,0,1,
1,0,1,
1,1,0,
0,0,0,
/* E */
1,1,1,
1,0,0,
1,1,1,
1,0,0,
1,1,1,
0,0,0,
/* F */
1,1,1,
1,0,0,
1,1,1,
1,0,0,
1,0,0,
0,0,0,
/* G */
0,1,1,
1,0,0,
1,1,1,
1,0,1,
0,1,1,
0,0,0,
/* H */
1,0,1,
1,0,1,
1,1,1,
1,0,1,
1,0,1,
0,0,0,
/* I */
1,1,1,
0,1,0,
0,1,0,
0,1,0,
1,1,1,
0,0,0,
/* J */
0,0,1,
0,0,1,
0,0,1,
1,0,1,
0,1,0,
0,0,0,
/* K */
1,0,1,
1,0,1,
1,1,0,
1,0,1,
1,0,1,
0,0,0,
/* L */
1,0,0,
1,0,0,
1,0,0,
1,0,0,
1,1,1,
0,0,0,
/* M */
1,0,1,
1,1,1,
1,1,1,
1,0,1,
1,0,1,
0,0,0,
/* N */
1,0,1,
1,1,1,
1,1,1,
1,1,1,
1,0,1,
0,0,0,
/* O */
0,1,0,
1,0,1,
1,0,1,
1,0,1,
0,1,0,
0,0,0,
/* P */
1,1,0,
1,0,1,
1,1,0,
1,0,0,
1,0,0,
0,0,0,
/* Q */
0,1,0,
1,0,1,
1,0,1,
1,1,1,
0,1,1,
0,0,0,
/* R */
1,1,0,
1,0,1,
1,1,1,
1,1,0,
1,0,1,
0,0,0,
/* S */
0,1,1,
1,0,0,
0,1,0,
0,0,1,
1,1,0,
0,0,0,
/* T */
1,1,1,
0,1,0,
0,1,0,
0,1,0,
0,1,0,
0,0,0,
/* U */
1,0,1,
1,0,1,
1,0,1,
1,0,1,
0,1,1,
0,0,0,
/* V */
1,0,1,
1,0,1,
1,0,1,
0,1,0,
0,1,0,
0,0,0,
/* W */
1,0,1,
1,0,1,
1,1,1,
1,1,1,
1,0,1,
0,0,0,
/* X */
1,0,1,
1,0,1,
0,1,0,
1,0,1,
1,0,1,
0,0,0,
/* Y */
1,0,1,
1,0,1,
0,1,0,
0,1,0,
0,1,0,
0,0,0,
/* Z */
1,1,1,
0,0,1,
0,1,0,
1,0,0,
1,1,1,
0,0,0,
/* [ */
1,1,1,
1,0,0,
1,0,0,
1,0,0,
1,1,1,
0,0,0,
/* \ */
0,0,0,
1,0,0,
0,1,0,
0,0,1,
0,0,0,
0,0,0,
/* ] */
1,1,1,
0,0,1,
0,0,1,
0,0,1,
1,1,1,
0,0,0,
/* ^ */
0,1,0,
1,0,1,
0,0,0,
0,0,0,
0,0,0,
0,0,0,
/* _ */
0,0,0,
0,0,0,
0,0,0,
0,0,0,
1,1,1,
0,0,0,
/* ` */
1,0,0,
0,1,0,
0,0,0,
0,0,0,
0,0,0,
0,0,0,
/* a */
0,0,0,
1,1,0,
0,1,1,
1,0,1,
1,1,1,
0,0,0,
/* b */
1,0,0,
1,1,0,
1,0,1,
1,0,1,
1,1,0,
0,0,0,
/* c */
0,0,0,
0,1,1,
1,0,0,
1,0,0,
0,1,1,
0,0,0,
/* d */
0,0,1,
0,1,1,
1,0,1,
1,0,1,
0,1,1,
0,0,0,
/* e */
0,0,0,
0,1,1,
1,0,1,
1,1,0,
0,1,1,
0,0,0,
/* f */
0,0,1,
0,1,0,
1,1,1,
0,1,0,
0,1,0,
0,0,0,
/* g */
0,0,0,
0,1,1,
1,0,1,
1,1,1,
0,0,1,
0,1,0,
/* h */
1,0,0,
1,1,0,
1,0,1,
1,0,1,
1,0,1,
0,0,0,
/* i */
0,1,0,
0,0,0,
0,1,0,
0,1,0,
0,1,0,
0,0,0,
/* j */
0,0,1,
0,0,0,
0,0,1,
0,0,1,
1,0,1,
0,1,0,
/* k */
1,0,0,
1,0,1,
1,1,0,
1,1,0,
1,0,1,
0,0,0,
/* l */
1,1,0,
0,1,0,
0,1,0,
0,1,0,
1,1,1,
0,0,0,
/* m */
0,0,0,
1,1,1,
1,1,1,
1,1,1,
1,0,1,
0,0,0,
/* n */
0,0,0,
1,1,0,
1,0,1,
1,0,1,
1,0,1,
0,0,0,
/* o */
0,0,0,
0,1,0,
1,0,1,
1,0,1,
0,1,0,
0,0,0,
/* p */
0,0,0,
1,1,0,
1,0,1,
1,0,1,
1,1,0,
1,0,0,
/* q */
0,0,0,
0,1,1,
1,0,1,
1,0,1,
0,1,1,
0,0,1,
/* r */
0,0,0,
0,1,1,
1,0,0,
1,0,0,
1,0,0,
0,0,0,
/* s */
0,0,0,
0,1,1,
1,1,0,
0,1,1,
1,1,0,
0,0,0,
/* t */
0,1,0,
1,1,1,
0,1,0,
0,1,0,
0,1,1,
0,0,0,
/* u */
0,0,0,
1,0,1,
1,0,1,
1,0,1,
0,1,1,
0,0,0,
/* v */
0,0,0,
1,0,1,
1,0,1,
1,0,1,
0,1,0,
0,0,0,
/* w */
0,0,0,
1,0,1,
1,1,1,
1,1,1,
1,1,1,
0,0,0,
/* x */
0,0,0,
1,0,1,
0,1,0,
0,1,0,
1,0,1,
0,0,0,
/* y */
0,0,0,
1,0,1,
1,0,1,
0,1,1,
0,0,1,
0,1,0,
/* z */
0,0,0,
1,1,1,
0,1,1,
1,1,0,
1,1,1,
0,0,0,
/* { */
0,1,1,
0,1,0,
1,0,0,
0,1,0,
0,1,1,
0,0,0,
/* | */
0,1,0,
0,1,0,
0,0,0,
0,1,0,
0,1,0,
0,0,0,
/* } */
1,1,0,
0,1,0,
0,0,1,
0,1,0,
1,1,0,
0,0,0,
/* ~ */
0,1,1,
1,1,0,
0,0,0,
0,0,0,
0,0,0,
0,0,0,
/* ¦ */
1,1,1,
0,0,0,
1,1,1,
1,1,1,
1,1,1,
0,0,0};
#endif

