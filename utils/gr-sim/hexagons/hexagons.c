/* An Apple II lores version of the ZX Spectrim Tiratok Demo Rombs */

/* hexagon code */

/* based on rombs_zx_48.html javascript code */

/* deater -- Vince Weaver -- vince@deater.net -- 11 June 2026 */

/* RIP Sally */

#include <stdio.h>
#include <unistd.h>

#include "gr-sim.h"

#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

static void framebuffer_putpixel(unsigned int x, unsigned int y,
	unsigned char color) {

	color_equals(color);
	basic_plot(x+4,y);

}

#define canvasSizeX 32
#define canvasSizeY 48

#define renderFrames	8

double jsInterval = 20 * renderFrames;

#define shadowSize 12

#define alphaMax	96

int alphaHalf = alphaMax / 2;

double viewZoom = 1;

int chunksSizeX = 256 / canvasSizeX;
int chunksSizeY = 192 / canvasSizeY;

double maxY = canvasSizeY + shadowSize;

int buffer[canvasSizeY+shadowSize][canvasSizeX];

void init(void) {

	int x,y;

	//init buff

	for(y=0; y<canvasSizeY+shadowSize; y++) {
		for(x=0; x<canvasSizeX; x++) {
			buffer[y][x] = 0;
		}
	}

#if 0
	// zx colors list
	var colorList = [
		['#000073','#00009D','#0000E6','#0073E6','#009DE6','#00E6E6','#9DE6E6','#E6E6E6'],
		['#730000','#9D0000','#E60000','#E67300','#E69D00','#E69D9D','#E6E673','#E6E6E6'],
		['#730073','#73009D','#7300E6','#9D00E6','#E600E6','#E673E6','#E69DE6','#E6E6E6'],
		['#007300','#007300','#007300','#007373','#009D73','#00E673','#9DE69D','#E6E6E6'],
		['#808080','#808080','#808080','#808080','#808080','#808080','#808080','#808080'],
	];
	var colorSize = colorList[0].length;

	var parseAlpha0 = 0;
	var parseAlpha1 = - Math.round(alphaMax / 6);
	var parseAlpha2 = Math.round(alphaMax / 6);
	var parseMap = {};
	parseMap[0xFF0000] = {pal:0, alpha:parseAlpha0};
	parseMap[0x800000] = {pal:0, alpha:parseAlpha1};
	parseMap[0xFF8080] = {pal:0, alpha:parseAlpha2};
	parseMap[0xFF00FF] = {pal:1, alpha:parseAlpha0};
	parseMap[0x800080] = {pal:1, alpha:parseAlpha1};
	parseMap[0xFF80FF] = {pal:1, alpha:parseAlpha2};
	parseMap[0x00FF00] = {pal:2, alpha:parseAlpha0};
	parseMap[0x008000] = {pal:2, alpha:parseAlpha1};
	parseMap[0xFFFFFF] = {pal:2, alpha:parseAlpha2};
	parseMap[0x0000FF] = {pal:3, alpha:parseAlpha0};
	parseMap[0x000080] = {pal:3, alpha:parseAlpha1};
	parseMap[0x8080FF] = {pal:3, alpha:parseAlpha2};
	parseMap[0x808080] = {pal:0, alpha:parseAlpha0};

#endif
}

	//console.log(maxY);

	int frame = 0;
	double alphaCalc = 0;
	double alpha = 0;

	double ax = 0.0;
	double ay = 0.0;

	/* urgh y0() is the bessel function? */
	double xx0 = 0;
	double yy0 = 0;

	//info
	double valMin = 9999999;
	double valMax = 0;

//	canvas;
//	var ctx;

//	var mapCanvas;
//	var mapCanvasCtx;
//	var tCanvas;
//	var tCanvasCtx;
//	var tImgData;
//	var texture = new Image();
//	texture.src = 'data:image/png;base64,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';
//	texture.onload = function() {
//		mapCanvas = document.getElementById('mapCanvas');
//		mapCanvasCtx = mapCanvas.getContext('2d');
//		mapCanvasCtx.imageSmoothingEnabled = false;
//		tCanvas = document.getElementById('tCanvas');
//		tCanvasCtx = tCanvas.getContext('2d');
//		tCanvasCtx.drawImage(
//			texture,
//			0, 0, texture.width, texture.height,
//			0, 0, texture.width, texture.height
//		);
//		tImgData = tCanvasCtx.getImageData(0, 0, texture.width, texture.height);
//		canvas = document.getElementById('canvas');
//		canvas.style = 'zoom:' + (window.location.hash == '#preview' ? 1 : 2);
//		ctx = canvas.getContext('2d');
//		setInterval(renderFrame, jsInterval);
#if 0
		//calc zx texture
		var textureCode = '';
		for (var y = 0; y < 64; y++) {
			for (var x = 0; x < 256; x++) {
				var tAdr = 4 * (y * 256 + x);
				var color = 65536*tImgData.data[tAdr] + 256*tImgData.data[tAdr+1] + tImgData.data[tAdr+2];
				var xbyte = color == 0 ? 0 : 64 * parseMap[color].pal + parseMap[color].alpha + 1;
				textureCode += "\tDB\t" + xbyte + "\r\n";
			}
		}
		document.getElementById('textarea-texture').innerHTML = textureCode;

		var zxPage = [];
		for (var y = 0; y < 64; y++) {
			for (var x = 0; x < 256; x++) {
			}
		}
	}
#endif

double speed = 0.65;

void renderFrame(void) {

	int x,y,shadow;

#if 0
	//draw map
	mapCanvasCtx.drawImage(
			texture,
			0, 0, texture.width, texture.height,
			0, 0, texture.width*3, texture.height*3
		);

	// rotate
	//alphaCalc = (alphaCalc + 1) & 255;
#endif
	alphaCalc++;

	alpha = round(alphaHalf * cos(M_PI * alphaCalc / 96));

	// move x,y
	ax += 3;
	ay += 2;
	xx0 = round(56 * cos(M_PI * ax / 128)); //56
	yy0 = round(64 * sin(M_PI * ay / 128));

	//alpha = 64; xx0 = 0; yy0 = 0; //debug

	double minSx = 9999;
	double maxSx = 0;
	double minSy = 9999;
	double maxSy = 0;

	double centerY = 18; //maxYY/2;
	double zRast = 34;

	double sx,sy,tx,ty;

	for(y=0; y<maxY; y++) {
		for (x=0; x<canvasSizeX; x++) {

			sx = round(3.25 * zRast *
				(x - canvasSizeX/2) / (y + zRast));
			sy = round(3.5 * zRast *
				(y - centerY) / (y + zRast));

			minSx = fmin(minSx, sx);
			maxSx = fmax(maxSx, sx);
			minSy = fmin(minSy, sy);
			maxSy = fmax(maxSy, sy);

			tx = round(sx * cos(M_PI * alpha / alphaHalf)) -
				round(sy * sin(M_PI * alpha / alphaHalf));
			ty = round(sx * sin(M_PI * alpha / alphaHalf)) +
				round(sy * cos(M_PI * alpha / alphaHalf));

			tx = 255 & (int)(xx0 + tx);
			ty = 63 & (int)(yy0 + ty);
#if 0
			// show map projection
			mapCanvasCtx.fillStyle = y > shadowSize ? "#a0a0a0" : "#ffffff";
			mapCanvasCtx.fillRect(3*tx,3*ty,3,3);

			// mapping
			var tAdr = 4 * (ty * 256 + tx);
			var color = 65536*tImgData.data[tAdr] + 256*tImgData.data[tAdr+1] + tImgData.data[tAdr+2];
			if (color != 0 && parseMap[color] != undefined) {
				double LightMlt = 7;
				double LightMax = 7;

				var pal = parseMap[color].pal;
				//var pal = 0; //debug
				val = LightMax - round(fabs(LightMlt *
					sin(M_PI * (alpha +
					parseMap[color].alpha) / alphaHalf)));
				valMin = fmin(valMin, val);
				valMax = fmax(valMax, val);

				// set color
				buffer[y][x] = colorList[pal][6];
				for(shadow=1; shadow < shadowSize; shadow++) {

					if (buffer[y + shadow] != undefined) {
						buffer[y + shadow][x] = colorList[pal][Math.round(val)];
					}
					double sub = 0.3;

					if (val - sub >= 0) {
						val -= sub;
					}
				}
			} else {
				if (buffer[y + shadowSize] != undefined) {
					buffer[y + shadowSize- 1][x] = '#000000';
					buffer[y + shadowSize][x] = '#000000';
				}
			}
#endif
		}
	}

	printf("valMin: %.1lf valMax: %.1lf\n",valMin,valMax);
	printf("sx: %.1lf .. %.1lf\n",minSx,maxSx);
	printf("sy: %.1lf .. %.1lf\n",minSy,maxSy);

	/* draw to framebuffer */
	for(y=0; y<canvasSizeY; y++) {
		for(x=0; x<canvasSizeX; x++) {
//			ctx.fillStyle = buffer[y + shadowSize][x];
//			ctx.fillRect(x * chunksSizeX, y * chunksSizeY, chunksSizeX, chunksSizeY);
//			mapCanvasCtx.fillStyle = buffer[y + shadowSize][x];
//			mapCanvasCtx.fillRect(3*(112+x), 3*y, 3, 3);

			framebuffer_putpixel(x, y, buffer[y+shadowSize][x]);

		}
	}
}



int main(int argc, char **argv) {

	int ch;

	// set_default_pal();

	frame=0;

	grsim_init();

	gr();

	clear_screens();
	clear_bottom_color(0,0);

	init();

	soft_switch(MIXCLR);

	while(1) {

	renderFrame();

	frame++;		// increment frame counter

#if 0
	static int framed=1;
	dump_framebuffer_gr(framed);
	framed++;
	if (framed==89) exit(1);
#endif

	grsim_update();

	usleep(100000);

	ch=grsim_input();
	if (ch=='q') return 0;
	if (ch==27) return 0;

	}

	return 0;

}
