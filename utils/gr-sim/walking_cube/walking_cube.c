/* An Apple II lores version of the ZX Spectrim Tiratok Demo Walking Cube */

/* based on stepping_cube_ZX2.html javascript code */

/* deater -- Vince Weaver -- vince@deater.net -- 8 June 2026 */


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
	basic_plot(x,y);

}

#define canvasSizeX 32
#define canvasSizeY 48

//	const int canvasZoomX = 4 * (64/canvasSizeX);
//	const int canvasZoomY = 4 * (48/canvasSizeY);

static	int frame = 0;
static	double zxFrame;
static	const double framesForRender = 5.2;
static	const double slowDown = 1;

//static int palette[3][8]={
//		{0x000073,0x000073,0x00009D,0x0000E6,0x0073E6,0x009DE6,0x009DE6,0x009DE6},
//		{0x0000E6,0x0073E6,0x009DE6,0x00E6E6,0x73E6E6,0x9DE6E6,0xE6E6E6,0xE6E6E6},
//		{0x000000,0x730073,0x9D009D,0xE600E6,0xE67300,0xE69D00,0xE6E69D,0xE6E6E6},
//	};

static int apple2_palette[3][8]={

		/* Palette for dark floor tiles (to the back) */

		{0,	//0x000073,// dark blue
		 0,	//0x000073,// dark blue
		 2,	//0x00009D,// lighter blue
		 2,	//0x0000E6,// lighter blue
		 2,	//0x0073E6,// medium blue
		 6,	//0x009DE6,// light blue
		 6,	//0x009DE6,// light blue
		 6},	//0x009DE6},// light blue

		/* palette for close floor tiles (to the front) */

		{2,	//0x0000E6,// lighter blue
		 2,	//0x0073E6,// medium blue
		 6,	//0x009DE6,// light blue
		 6,	//0x00E6E6,// teal
		 7,	//0x73E6E6,// light teal
		 7,	//0x9DE6E6,// really light teal
		 15,	//0xE6E6E6,// grey
		 15},	//0xE6E6E6},// grey

		/* palette for the cube? */
		{0,	//0x000000,// black
		 1,	//0x730073,// magenta
		 3,	//0x9D009D,// lighter magenta
		 11,	//0xE600E6,// even lighter magenta
		 9,	//0xE67300,// orange
		 13,	//0xE69D00,// yellow
		 13,	//0xE6E69D,// yellow
		 15},	//0xE6E6E6},// grey
	};


static int paletteZX[] = {
		0,	// 0x000000, black
		1,	// 0x9D009D, magenta
		2,	// 0x9D00E6, purple
		3,	// 0xE600E6, light magenta?
		11,	// 0xE6739D, rose?
		9,	// 0xE69D73, light orange?
		13,	// 0xE6E69D, yellow
		15,	// 0xE6E6E6, grey
		14,	// 0x9DE6E6, light teal
		7,	// 0x73E6E6, medium teal
		6,	// 0x00E6E6, dark teal
		2,	// 0x009DE6, medium blue
		2,	// 0x0073E6, dark medium blue
		2,	// 0x0000E6, blue
		0,	// 0x00009D, darker blue
		0,	// 0x000073 darkest blue
	};

/* used to shade the tiles based on distance */
static int backShade[] = {
		0,0,0,0,
		1,1,1,1,
		2,2,2,2,
		3,3,3,3,
		4,4,4,4,
		5,5,5,5,5,5,
		6,6,6,6,6,6,
		6,6,
	};

/* directions for the cube to take */
static int dirListId = 0;
static int dirList[] = {
	0,0,0,3,
	3,2,2,1,
	0,0,0,1,
	2,1,1,2,

	2,1,1,1,
	1,1,1,1,
	1,1,1,1,
	1,1,1,1,
	1,
};

/* hard-coded lighting */

static int mapLight[32][32] = {
//0 1 2 3  4 5 6 7  8 9 1011 12131415 16171819 20212223 24252627 28293031
{ 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0}, //0
{ 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0}, //1
{ 0,0,0,0, 0,0,0,0, 0,0,0,0, 1,1,1,1, 1,1,1,1, 0,0,0,0, 0,0,0,0, 0,0,0,0}, //2
{ 0,0,0,0, 0,0,0,0, 0,0,1,1, 1,1,1,1, 1,1,1,1, 1,1,0,0, 0,0,0,0, 0,0,0,0}, //3
{ 0,0,0,0, 0,0,0,0, 1,1,1,1, 1,2,2,2, 2,2,2,1, 1,1,1,1, 0,0,0,0, 0,0,0,0}, //4
{ 0,0,0,0, 0,0,0,1, 1,1,2,2, 2,2,2,2, 2,2,2,2, 2,2,1,1, 1,0,0,0, 0,0,0,0}, //5
{ 0,0,0,0, 0,0,1,1, 1,2,2,2, 2,3,3,3, 3,3,3,2, 2,2,2,1, 1,1,0,0, 0,0,0,0}, //6
{ 0,0,0,0, 0,1,1,1, 2,2,2,3, 3,3,3,3, 3,3,3,3, 3,2,2,2, 1,1,1,0, 0,0,0,0}, //7
{ 0,0,0,0, 1,1,1,2, 2,3,3,3, 3,4,4,4, 4,4,4,3, 3,3,3,2, 2,1,1,1, 0,0,0,0}, //8
{ 0,0,0,0, 1,1,2,2, 3,3,3,4, 4,4,4,4, 4,4,4,4, 4,3,3,3, 2,2,1,1, 0,0,0,0}, //9
{ 0,0,0,1, 1,2,2,2, 3,3,4,4, 4,4,5,5, 5,5,4,4, 4,4,3,3, 2,2,2,1, 1,0,0,0}, //10
{ 0,0,0,1, 1,2,2,3, 3,4,4,4, 5,5,5,5, 5,5,5,5, 4,4,4,3, 3,2,2,1, 1,0,0,0}, //11
{ 0,0,1,1, 1,2,2,3, 3,4,4,5, 5,5,6,6, 6,6,5,5, 5,4,4,3, 3,2,2,1, 1,1,0,0}, //12
{ 0,0,1,1, 2,2,3,3, 4,4,4,5, 5,6,6,6, 6,6,6,5, 5,4,4,4, 3,3,2,2, 1,1,0,0}, //13
{ 0,0,1,1, 2,2,3,3, 4,4,5,5, 6,6,6,7, 7,6,6,6, 5,5,4,4, 3,3,2,2, 1,1,0,0}, //14
{ 0,0,1,1, 2,2,3,3, 4,4,5,5, 6,6,7,7, 7,7,6,6, 5,5,4,4, 3,3,2,2, 1,1,0,0}, //15
{ 0,0,1,1, 2,2,3,3, 4,4,5,5, 6,6,7,7, 7,7,6,6, 5,5,4,4, 3,3,2,2, 1,1,0,0}, //16
{ 0,0,1,1, 2,2,3,3, 4,4,5,5, 6,6,6,7, 7,6,6,6, 5,5,4,4, 3,3,2,2, 1,1,0,0}, //17
{ 0,0,1,1, 2,2,3,3, 4,4,4,5, 5,6,6,6, 6,6,6,5, 5,4,4,4, 3,3,2,2, 1,1,0,0}, //18
{ 0,0,1,1, 1,2,2,3, 3,4,4,5, 5,5,6,6, 6,6,5,5, 5,4,4,3, 3,2,2,1, 1,1,0,0}, //19
{ 0,0,0,1, 1,2,2,3, 3,4,4,4, 5,5,5,5, 5,5,5,5, 4,4,4,3, 3,2,2,1, 1,0,0,0}, //20
{ 0,0,0,1, 1,2,2,2, 3,3,4,4, 4,4,5,5, 5,5,4,4, 4,4,3,3, 2,2,2,1, 1,0,0,0}, //21
{ 0,0,0,0, 1,1,2,2, 3,3,3,4, 4,4,4,4, 4,4,4,4, 4,3,3,3, 2,2,1,1, 0,0,0,0}, //22
{ 0,0,0,0, 1,1,1,2, 2,3,3,3, 3,4,4,4, 4,4,4,3, 3,3,3,2, 2,1,1,1, 0,0,0,0}, //23
{ 0,0,0,0, 0,1,1,1, 2,2,2,3, 3,3,3,3, 3,3,3,3, 3,2,2,2, 1,1,1,0, 0,0,0,0}, //24
{ 0,0,0,0, 0,0,1,1, 1,2,2,2, 2,3,3,3, 3,3,3,2, 2,2,2,1, 1,1,0,0, 0,0,0,0}, //25
{ 0,0,0,0, 0,0,0,1, 1,1,2,2, 2,2,2,2, 2,2,2,2, 2,2,1,1, 1,0,0,0, 0,0,0,0}, //26
{ 0,0,0,0, 0,0,0,0, 1,1,1,1, 1,2,2,2, 2,2,2,1, 1,1,1,1, 0,0,0,0, 0,0,0,0}, //27
{ 0,0,0,0, 0,0,0,0, 0,0,1,1, 1,1,1,1, 1,1,1,1, 1,1,0,0, 0,0,0,0, 0,0,0,0}, //28
{ 0,0,0,0, 0,0,0,0, 0,0,0,0, 1,1,1,1, 1,1,1,1, 0,0,0,0, 0,0,0,0, 0,0,0,0}, //29
{ 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0}, //30
{ 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0}, //31
};


/* screen buffers */
static int screenBuff[canvasSizeY][canvasSizeX];
//int screenBuffMask[128][128];
//int screenBuffShadow[128][128];

#define mapSizeX	63
#define mapSizeY	63

static double map[mapSizeX][mapSizeY];

#define	drogMax		2

#define cubePolygonsLength	6
#define cubePolygonsRotLength	6

/* vertices for the six sides of the cube */
static int cubePolygons[cubePolygonsLength][5] = {
	{0,1,2,3,0},
	{5,4,7,6,0},
	{1,5,6,2,0},
	{4,0,3,7,0},
	{0,4,5,1,0},
	{2,6,7,3,0}
};

static int drog;	// ????

static double mapDx = 8;
static double mapDz = 8;
static double mapAngle = 0;

static double rotAngleCubeDir;
static double rotAngleCubeX = 0;
static double rotAngleCubeY = 0;
static double rotAngleCubeZ = 0;
static double cubeDx = 0;
static double cubeDz = 0;

static int phase = 0;
static double phaseCubeDz = 0;
static double phaseBgDz = 0;

#define	mapAnglePhase2Max	104 //112

static int getNextDir(void) {
	dirListId++;
	return dirList[dirListId];
}

#define	cubeSz 10 //40;

struct coord_type {
	double x,y,z;
	double xx,yy,zz;
	double px,py;
	double l,lx,ly;
};

#define cubePointsLength	9

struct coord_type cubePoints[cubePointsLength] = {
	{x:-cubeSz, y:cubeSz, z:cubeSz},
	{x:cubeSz, y:cubeSz, z:cubeSz},
	{x:cubeSz, y:-cubeSz, z:cubeSz},
	{x:-cubeSz, y:-cubeSz, z:cubeSz},
	{x:-cubeSz, y:cubeSz, z:-cubeSz},
	{x:cubeSz, y:cubeSz, z:-cubeSz},
	{x:cubeSz, y:-cubeSz, z:-cubeSz},
	{x:-cubeSz, y:-cubeSz, z:-cubeSz},
	{x:0, y:0, z:0},
};

const double cubeAngleMax = 64;
const double cubeAngleStep = 12 / slowDown;
const double cubeStep = 4 / slowDown;
const double mapStep = 3.2 / slowDown;

const double cubeStep2 = 30 * cubeStep / 80;
const double mapStep2 = 30 * mapStep / 80;


static void init(void) {

	int x,y;

	/* generate map */
	for(y=0; y<mapSizeY; y++) {
		for(x=0; x<mapSizeX; x++) {
			//map[y][x] = (floor(x/16)+floor(y/16))%2==0 ? 0 : 1;

			map[y][x] = ((x/16)+(y/16))%2==0 ? 0 : 1;
		}
	}

	/* init data */

	drog = 0;

	rotAngleCubeDir = dirList[dirListId];
	rotAngleCubeX = 0;
	rotAngleCubeY = 0;
	rotAngleCubeZ = 0;
	cubeDx = 0;
	cubeDz = 0;

	phase = 0;
	phaseCubeDz = 0;
	phaseBgDz = 0;

	/* init lighting */

//	var mapLight = [];
//	var canvasLight = document.getElementById('canvas-light');
//	var ctxLight = canvasLight.getContext('2d');
//	var imgLight = document.getElementById('img-light');
//	ctxLight.drawImage(imgLight, 0, 0);
//	var lightData = ctxLight.getImageData(0,0,32,32).data;

//	int addr;

//	for (y=0; y<32; y++) {
//		for (x=0; x<32; x++) {
//			addr = 4*(y*32+x);
//			var color = lightData[adr];
//			mapLight[y][x] = mapLightArr[color];
//		}
//	}


}


//	function start() {
//		document.getElementById('canvas-zx').onclick = function(){};
//		setInterval(renderFrame, 20*framesForRender/slowDown);
//	}



void rotate3d(struct coord_type *result,
	struct coord_type point,
	double alphaX, double alphaY, double alphaZ) {

	double a,x,y,z;

	// rotate X
	a = M_PI * alphaX / 128.0;
	y = round(point.y * cos(a)) + round(point.z * sin(a));
	z = -round(point.y * sin(a)) + round(point.z * cos(a));
	point.y = y;
	point.z = z;
	// rotate Y
	a = M_PI * alphaY / 128.0;
	x = round(point.x * cos(a)) + round(point.z * sin(a));
	z = -round(point.x * sin(a)) + round(point.z * cos(a));
	point.x = x;
	point.z = z;
	// rotate Z
	a = M_PI * alphaZ / 128.0;
	x = round(point.x * cos(a)) + round(point.y * sin(a));
	y = -round(point.x * sin(a)) + round(point.y * cos(a));
	point.x = x;
	point.y = y;

	result->x=point.x;
	result->y=point.y;
	result->z=point.z;

}

static double minCx = 9999;
static double minCy = 9999;
static double minCz = 9999;
static double maxCx = 0;
static double maxCy = 0;
static double maxCz = 0;

static double minLx = 9999;
static double maxLx = 0;
static double minLy = 9999;
static double maxLy = 0;

static double minNx = 9999;
static double maxNx = 0;
static double minNy = 9999;
static double maxNy = 0;


static void nextStep(void) {

		// next frame
	if (rotAngleCubeDir == 0) { //right
		rotAngleCubeZ -= cubeAngleStep;
		mapDx -= mapStep;
		cubeDx -= cubeStep;
		if (rotAngleCubeZ <= -cubeAngleMax) {
			rotAngleCubeDir = getNextDir();
			rotAngleCubeZ = 0;
			cubeDx = 0;
			drog = drogMax;

			mapDx += mapStep;
			nextStep();
                	return;
		}
        } else if (rotAngleCubeDir == 1) { //down
		rotAngleCubeX += cubeAngleStep;
		mapDz -=  mapStep;
		cubeDz -= cubeStep;
		if (rotAngleCubeX >= cubeAngleMax) {
			rotAngleCubeDir = getNextDir();
			rotAngleCubeX = 0;
			cubeDz = 0;
			drog = drogMax;

			mapDz += mapStep;
			nextStep();
			return;
		}
	} else if (rotAngleCubeDir == 2) { //left
		rotAngleCubeZ += cubeAngleStep;
		mapDx += mapStep;
		cubeDx += cubeStep;
		if (rotAngleCubeZ >= cubeAngleMax) {
			rotAngleCubeDir = getNextDir();
			rotAngleCubeZ = 0;
			cubeDx = 0;
			drog = drogMax;

			mapDx -= mapStep;
			nextStep();
			return;
		}
	} else if (rotAngleCubeDir == 3) { //up
		rotAngleCubeX -= cubeAngleStep;
		mapDz += mapStep;
		cubeDz += cubeStep;
		if (rotAngleCubeX <= -cubeAngleMax) {
			rotAngleCubeDir = getNextDir();
			rotAngleCubeX = 0;
			cubeDz = 0;
			drog = drogMax;

			mapDz -= mapStep;
			nextStep();
			return;
		}
	}
}

struct cubePolygonsRot_type {
	struct coord_type points[4];
	double x,y,z;
	struct coord_type centerPoints[4];
	struct coord_type nn;		// normal
	struct coord_type center;
};


//	qsort(&cubePolygonsRot[0],
//			cubePolygonsLength,
//			sizeof(struct cubePolygonsRot_type *),
//			compareSortPolygons);

int compareSortPolygons(const void *a1, const void *b1) {

	int comparison=0;

	struct cubePolygonsRot_type *a,*b;

	a=(struct cubePolygonsRot_type *)a1;
	b=(struct cubePolygonsRot_type *)b1;

//	printf("\ta->z: %.1f, b->z: %.1f\n",a->z,b->z);

	if (a->z > b->z) {
		comparison = 1;
	} else if (a->z < b->z) {
		comparison = -1;
	} else if (a->y > b->y) {
		comparison = -1;
	} else if (a->y < b->y) {
		comparison = 1;
	}

	return comparison;
}




/* for sort */
static int zxComparePY(const void *a1, const void *b1) {

	struct coord_type *a,*b;

	a=*(struct coord_type **)a1;
	b=*(struct coord_type **)b1;

//	printf("\ta->py %.1lf b->py %.1lf\n",a->py,b->py);

	if (a->py == b->py) {
		return 0;
	}
	return a->py > b->py ? 1 : -1;
}


void zxDrawPolygon(
	struct coord_type points0,
	struct coord_type points1,
	struct coord_type points2,
	struct coord_type centerPoints0,
	struct coord_type centerPoints1,
	struct coord_type centerPoints2,
	struct coord_type nn) {

	int i,x,y;

	struct coord_type *points[3]={&points0,&points1,&points2};
	struct coord_type *centerPoints[3]=
		{&centerPoints0,&centerPoints1,&centerPoints2};

	if (nn.z > 0) {
		return;
	}

	//calc lights
	minNx = fmin(minNx, nn.x);
	maxNx = fmax(maxNx, nn.x);
	minNy = fmin(minNy, nn.y);
	maxNy = fmax(maxNy, nn.y);

	double globL;

	globL = mapLight[31&(10+(int)nn.y)][31&(16+(int)nn.x)];

	struct coord_type nadd;

	for(i=0; i<3; i++) {
		points[i]->l = mapLight[31&(10+(int)nn.y)][31&(16+(int)nn.x)];
		//lights method 3
		nadd.x=floor((centerPoints[i]->x+nn.x)/2);
		nadd.y=floor((centerPoints[i]->y+nn.y)/2);
		nadd.z=floor((centerPoints[i]->z+nn.z)/2);
		points[i]->lx = nadd.x;
		points[i]->ly = nadd.y;
		points[i]->l +=
			floor(mapLight[31&(10+
				(int)nadd.y)][31&(16+(int)nadd.x)]/2);
		points[i]->l = points[i]->l <= 7 ? points[i]->l : 7;
		minLx = fmin(minLx, nadd.x);
		maxLx = fmax(maxLx, nadd.x);
		minLy = fmin(minLy, nadd.y);
		maxLy = fmax(maxLy, nadd.y);
	}

	// draw polygon
	//points.sort(zxComparePY);

//	printf("Before\n");
//	for(i=0;i<3;i++) printf("%d px %.1lf py %.1lf\n",i,
//		points[i]->px,points[i]->py);

	qsort(&points[0],3,sizeof(struct coord_type *),zxComparePY);

//	printf("After\n");
//	for(i=0;i<3;i++) printf("%d px %.1lf py %.1lf\n",i,
//		points[i]->px,points[i]->py);

	struct coord_type zxPoints[4];

	for(i=0; i<3; i++) {
		zxPoints[i].px = points[i]->px; //floor(16+(points[i].px-128)/8);
		zxPoints[i].py = points[i]->py; //floor(24+(points[i].py-96)/4);
		zxPoints[i].l = points[i]->l;
		zxPoints[i].lx = points[i]->lx;
		zxPoints[i].ly = points[i]->ly;
	}

//	var leftX = [];
//	var rightX = [];
//	var leftLLL = [];
//	var rightLLL = [];

	/* size??? running is as high as 34? */

#define LSIZE	64

	double leftX[LSIZE],rightX[LSIZE];
	struct coord_type leftLLL[LSIZE],rightLLL[LSIZE];

	i=0;
	for(y=zxPoints[0].py; y<=zxPoints[1].py; y++) {
		leftX[i] = zxPoints[0].px + round( (y-zxPoints[0].py) *
				(zxPoints[1].px-zxPoints[0].px) /
				(zxPoints[1].py-zxPoints[0].py) );

		leftLLL[i].lx=zxPoints[0].lx +
				round( (y-zxPoints[0].py) *
					(zxPoints[1].lx-zxPoints[0].lx) /
					(zxPoints[1].py-zxPoints[0].py) );
		leftLLL[i].ly=zxPoints[0].ly +
				round( (y-zxPoints[0].py) *
					(zxPoints[1].ly-zxPoints[0].ly) /
					(zxPoints[1].py-zxPoints[0].py) );
		i++;
	}
	for(y=zxPoints[1].py; y<zxPoints[2].py; y++) {
		leftX[i] = zxPoints[1].px +
				round( (y-zxPoints[1].py) *
					(zxPoints[2].px-zxPoints[1].px) /
					(zxPoints[2].py-zxPoints[1].py) );
		leftLLL[i].lx=zxPoints[1].lx +
				round( (y-zxPoints[1].py) *
					(zxPoints[2].lx-zxPoints[1].lx) /
					(zxPoints[2].py-zxPoints[1].py) );
		leftLLL[i].ly=zxPoints[1].ly +
				round( (y-zxPoints[1].py) *
					(zxPoints[2].ly-zxPoints[1].ly) /
					(zxPoints[2].py-zxPoints[1].py) );
		i++;
	}

	static int old_i=0;

	if (i>old_i) {
		old_i=i;
		printf("\tfinal i: %d\n",i);
		if (i>LSIZE) {
			fprintf(stderr,"i too big!\n");
			exit(1);
		}
	}

	i=0;
	for(y=zxPoints[0].py; y <= zxPoints[2].py; y++) {
		rightX[i] = zxPoints[0].px +
				round( (y-zxPoints[0].py) *
					(zxPoints[2].px-zxPoints[0].px) /
					(zxPoints[2].py-zxPoints[0].py) );
		rightLLL[i].lx=zxPoints[0].lx +
				round( (y-zxPoints[0].py) *
					(zxPoints[2].lx-zxPoints[0].lx) /
					(zxPoints[2].py-zxPoints[0].py) );
		rightLLL[i].ly=zxPoints[0].ly +
				round( (y-zxPoints[0].py) *
					(zxPoints[2].ly-zxPoints[0].ly) /
					(zxPoints[2].py-zxPoints[0].py) );
		i++;
	}

	if (i>old_i) {
		old_i=i;
		printf("\tfinal i: %d\n",i);
		if (i>LSIZE) {
			fprintf(stderr,"i too big!\n");
			exit(1);
		}
	}

	//draw
	i = 0;
	double dx = 0,lx,ly,L;
	for (y = zxPoints[0].py; y <= zxPoints[2].py; y++) {

		if ( isnan(rightX[i]) || isnan(leftX[i])) continue;

//		if (rightX[i] != undefined && leftX[i] != undefined) {
		dx = fabs(rightX[i] - leftX[i]);

		if (rightX[i] >= leftX[i]) {
			for (x=leftX[i]; x<=rightX[i]; x++) {
				lx = leftLLL[i].lx + (x-leftX[i]) *
					(rightLLL[i].lx - leftLLL[i].lx) / dx;
				ly = leftLLL[i].ly + (x-leftX[i]) *
					(rightLLL[i].ly - leftLLL[i].ly) / dx;

				L = round(globL/1.5 +
					mapLight[31&(9+(int)ly)][31&(16+(int)lx)]/1.5);
				L = fmax(round(globL/1.5),
					round(mapLight[31&(9+(int)ly)][31&(16+(int)lx)]/1));
				L = round(globL/3 +
					mapLight[31&(9+(int)ly)][31&(16+(int)lx)]);
				L = L <= 7 ? L : 7;
				L = L > 1 ? L : 1;

				screenBuff[y][x] = paletteZX[(int)floor(L)];
				//screenBuffMask[y][x] = 1;


			}
		} else {
			for(x=rightX[i]; x<=leftX[i]; x++) {
				lx = rightLLL[i].lx + (x-rightX[i]) * (leftLLL[i].lx - rightLLL[i].lx) / dx;
				ly = rightLLL[i].ly + (x-rightX[i]) * (leftLLL[i].ly - rightLLL[i].ly) / dx;

				L = round(globL/1.5 +
					mapLight[31&(9+(int)ly)][31&(16+(int)lx)]/1.5);
				L = fmax(round(globL/1.5),
					round(mapLight[31&(9+(int)ly)][31&(16+(int)lx)]/1));
				L = round(globL/3 + mapLight[31&(9+(int)ly)][31&(16+(int)lx)]);
				L = L <= 7 ? L : 7;
				L = L > 1 ? L : 1;

				screenBuff[y][x] = paletteZX[(int)floor(L)];
				//screenBuffMask[y][x] = 1;
			}
		}
		i++;
	} // y

}



#if 0
/* not used */
void calcNorm(points) {
		var ab = {
			x: points[1].x - points[0].x,
			y: points[1].y - points[0].y,
			z: points[1].z - points[0].z,
		};
		var ac = {
			x: points[2].x - points[0].x,
			y: points[2].y - points[0].y,
			z: points[2].z - points[0].z,
		}
		var n = {
			x: ab.y*ac.z - ac.y*ab.z,
			y: ab.x*ac.z - ac.x*ab.z,
			z: ab.x*ac.y - ac.x*ab.y,
		}
		return n;
}


#endif

static void calcNorm2(
	struct coord_type *result,
	struct coord_type centerPoints[4]) {

	result->x = floor((centerPoints[0].x + centerPoints[1].x +
			centerPoints[2].x + centerPoints[3].x) / 40*15);
	result->y = floor((centerPoints[0].y + centerPoints[1].y +
			centerPoints[2].y + centerPoints[3].y) / 40*15);
	result->z = floor((centerPoints[0].z + centerPoints[1].z +
			centerPoints[2].z + centerPoints[3].z) / 40*15);

}

#if 0

/* unused? */
double vec3ugol(
	struct coord_type a,
	struct coord_type b) {

	return ((a.x*b.x + a.y*b.y + a.z*b.z) /
		( sqrt(a.x*a.x + a.y*a.y + a.z*a.z) *
		  sqrt(b.x*b.x + b.y*b.y + b.z*b.z) ) );
}
#endif

static void vec3sub(
	struct coord_type *result,
	struct coord_type a,
	struct coord_type b) {

	result->x=b.x-a.x;
	result->y=b.y-a.y;
	result->z=b.z-a.z;
}


	/* calc & render */
void renderFrame(void) {

	double minSx = 9999;
	double maxSx = 0;
	double minSy = 9999;
	double maxSy = 0;

	int y,x,i;

		// clear buff
	for(y=0; y<canvasSizeY; y++) {
		for(x=0; x<canvasSizeX; x++) {
			screenBuff[y][x] = 0;
			//screenBuffMask[y][x] = 0;
			//screenBuffShadow[y][x] = 0;
		}
	}

	double my,mx,sx,sy,tx,ty;
	double color;

	/* Draw the tile floor */
	for (y=14; y<48; y++) {
		for (x=0; x <canvasSizeX; x++) {

			my = ((32 - y));
			mx = 1.0 * ((canvasSizeX/2.0 - x)-0.5);
			sx = floor(4.0*mx/(y/12.5));
			sy = floor(4.0*my/(y/12.5));

			//var rot = {};
			tx = floor(sx * cos(M_PI * mapAngle / 128)) -
				floor(sy * sin(M_PI * mapAngle / 128));
			ty = floor(sx * sin(M_PI * mapAngle / 128)) +
				floor(sy * cos(M_PI * mapAngle / 128));

			ty = (mapSizeY - 1) & (int)floor(ty + mapDz + phaseBgDz);
			tx = (mapSizeX - 1) & (int)floor(tx + mapDx);

			// if (screenBuff[y] != undefined && screenBuff[y][x] != undefined) {
			////var color = floor((y-12) / 4.5);
			// color = (int)floor((y-12)/4.5);
				color = backShade[y-14];
//				screenBuff[y][x]=(int)color;
				screenBuff[y][x] =
				apple2_palette[(int)map[(int)ty][(int)tx]][(int)color];
//					(int)map[(int)ty][(int)tx]
//						[(int)color]
//					 );
//			printf("%d %d: %d\n",x,y,(int)color);

//			printf("%d %d: %d,%d\n",x,y,(int)map[(int)ty][(int)tx],(int)color);

			//		palette[map[ty][tx].pal][color] != undefined
			//		? palette[map[ty][tx].pal][color]
			//		: palette[map[ty][tx].pal][0];
			//}

			minSx = fmin(minSx, sx);
			maxSx = fmax(maxSx, sx);
			minSy = fmin(minSy, sy);
			maxSy = fmax(maxSy, sy);
		}
	}

	/*****************/
	/* draw the cube */
	/*****************/
	struct coord_type vec3;
	struct coord_type cubePointsRot[cubePointsLength];

	memset(&cubePointsRot,
		0xff,sizeof(struct coord_type[cubePointsLength]));

        for(i=0; i<cubePointsLength; i++) {

		vec3.x=cubePoints[i].x;
		vec3.y=cubePoints[i].y;
		vec3.z=cubePoints[i].z;

		if (rotAngleCubeDir == 0) { //right
			vec3.x -= cubeSz;
		} else if (rotAngleCubeDir == 1) { //down
			vec3.z -= cubeSz;
		} else if (rotAngleCubeDir == 2) { //left
			vec3.x += cubeSz;
		} else if (rotAngleCubeDir == 3) { //up
			vec3.z += cubeSz;
		}

		vec3.y -= cubeSz;

		//cubePointsRot[i] =
		rotate3d(&cubePointsRot[i], vec3,
			rotAngleCubeX, rotAngleCubeY, rotAngleCubeZ);

		if (rotAngleCubeDir == 0) { //right
			cubePointsRot[i].x += cubeSz;
		} else if (rotAngleCubeDir == 1) { //down
			cubePointsRot[i].z += cubeSz;
		} else if (rotAngleCubeDir == 2) { //left
			cubePointsRot[i].x -= cubeSz;
		} else if (rotAngleCubeDir == 3) { //up
			cubePointsRot[i].z -= cubeSz;
		}
		cubePointsRot[i].y += cubeSz;

			// step add & rotate with bg
		cubePointsRot[i].z += cubeDz;
		cubePointsRot[i].x += cubeDx;
		cubePointsRot[i].z += phaseCubeDz;
//		cubePointsRot[i] =
		rotate3d(&cubePointsRot[i],cubePointsRot[i], 0, mapAngle, 0);

		cubePointsRot[i].xx = cubePointsRot[i].x;
		cubePointsRot[i].yy = cubePointsRot[i].y;
		cubePointsRot[i].zz = cubePointsRot[i].z;

		// move to scr cooords
		cubePointsRot[i].y += cubeSz + 12.5;

		// project
		double k = -64;
		cubePointsRot[i].px = floor(k * cubePointsRot[i].x /
						(k + cubePointsRot[i].z));
		cubePointsRot[i].py = floor(k * cubePointsRot[i].y /
						(k + cubePointsRot[i].z));
		cubePointsRot[i].px = floor(cubePointsRot[i].px / 2);

		//move to scr
		cubePointsRot[i].px += 16;
		cubePointsRot[i].py += 0;
	}

//        var cubePolygonsRot = [];


	struct cubePolygonsRot_type cubePolygonsRot[cubePolygonsLength];

	memset(&cubePolygonsRot,
		0xff,sizeof(struct coord_type[cubePointsLength]));

	for (i=0; i<cubePolygonsLength; i++) {

		cubePolygonsRot[i].points[0] =
					cubePointsRot[cubePolygons[i][0]];
		cubePolygonsRot[i].points[1] =
					cubePointsRot[cubePolygons[i][1]];
		cubePolygonsRot[i].points[2] =
					cubePointsRot[cubePolygons[i][2]];
		cubePolygonsRot[i].points[3] =
					cubePointsRot[cubePolygons[i][3]];


		cubePolygonsRot[i].z = round(cubePolygonsRot[i].points[0].z +
					cubePolygonsRot[i].points[1].z +
					cubePolygonsRot[i].points[2].z +
					cubePolygonsRot[i].points[3].z) / 4;
		cubePolygonsRot[i].y = round(cubePolygonsRot[i].points[0].y +
					cubePolygonsRot[i].points[1].y +
					cubePolygonsRot[i].points[2].y +
					cubePolygonsRot[i].points[3].y) / 4;
		cubePolygonsRot[i].center = cubePointsRot[8];


		vec3sub(&cubePolygonsRot[i].centerPoints[0],
				cubePolygonsRot[i].points[0],
				cubePolygonsRot[i].center);
		vec3sub(&cubePolygonsRot[i].centerPoints[1],
				cubePolygonsRot[i].points[1],
				cubePolygonsRot[i].center);
		vec3sub(&cubePolygonsRot[i].centerPoints[2],
				cubePolygonsRot[i].points[2],
				cubePolygonsRot[i].center);
		vec3sub(&cubePolygonsRot[i].centerPoints[3],
				cubePolygonsRot[i].points[3],
				cubePolygonsRot[i].center);
		calcNorm2(&cubePolygonsRot[i].nn,
					cubePolygonsRot[i].centerPoints);

	}

//	printf("Before\n");
//	for(i=0;i<cubePolygonsLength;i++) {
//		printf("%d: %.1lf %.1lf %.1lf\n",
//			i,cubePolygonsRot[i].x,
//			cubePolygonsRot[i].y,
//			cubePolygonsRot[i].z);
//	}



	qsort(&cubePolygonsRot[0],
			cubePolygonsLength,
			sizeof(struct cubePolygonsRot_type),
			compareSortPolygons);

//	printf("After\n");
//	for(i=0;i<cubePolygonsLength;i++) {
//		printf("%d: %.1lf %.1lf %.1lf\n",
//			i,cubePolygonsRot[i].x,
//			cubePolygonsRot[i].y,
//			cubePolygonsRot[i].z);
//	}

//	exit(1);

//        cubePolygonsRot.sort(compareSortPolygons);

//	double rgb;
	int p;

		// draw polygons zx
	for(i=0; i<cubePolygonsRotLength; i++) {
		//rgb = floor(i*255/(cubePolygonsRotLength-1));
            	//var fillStyle = 'rgb(' + rgb + ',' + rgb + ',' + rgb + ')';
		zxDrawPolygon(cubePolygonsRot[i].points[0],
				cubePolygonsRot[i].points[1],
				cubePolygonsRot[i].points[2],

				cubePolygonsRot[i].centerPoints[0],
				cubePolygonsRot[i].centerPoints[1],
				cubePolygonsRot[i].centerPoints[2],

				cubePolygonsRot[i].nn);

		zxDrawPolygon(cubePolygonsRot[i].points[2],
				cubePolygonsRot[i].points[3],
				cubePolygonsRot[i].points[0],

				cubePolygonsRot[i].centerPoints[2],
				cubePolygonsRot[i].centerPoints[3],
				cubePolygonsRot[i].centerPoints[0],

				cubePolygonsRot[i].nn);

		for(p=0; p<4; p++) {
			minCx = fmin(minCx, cubePolygonsRot[i].points[p].x);
			minCy = fmin(minCy, cubePolygonsRot[i].points[p].y);
			minCz = fmin(minCz, cubePolygonsRot[i].points[p].z);
			maxCx = fmax(maxCx, cubePolygonsRot[i].points[p].x);
			maxCy = fmax(maxCy, cubePolygonsRot[i].points[p].y);
			maxCz = fmax(maxCz, cubePolygonsRot[i].points[p].z);
		}

        }


        // draw out to graphics framebuffer

        for (y = 0; y < canvasSizeY; y++) {
            for (x = 0; x < canvasSizeX; x++) {
		framebuffer_putpixel(x,y,screenBuff[y][x]);
            }
        }

        // show info
	printf("frameRendered: %d\tframeZX: %d\n",
		frame,(int)floor(framesForRender * frame));
	printf("sx: %.1lf .. %.1lf\n",minSx,maxSx);
	printf("sy: %.1lf .. %.1lf\n",minSy,maxSy);
	printf("x:  %.1lf .. %.1lf\n",minCx,maxCx);
	printf("y:  %.1lf .. %.1lf\n",minCy,maxCy);
	printf("z:  %.1lf .. %.1lf\n",minCz,maxCz);
	printf("Lx:  %.1lf .. %.1lf\n",minLx,maxLx);
	printf("Ly:  %.1lf .. %.1lf\n",minLy,maxLy);
	printf("Nx:  %.1lf .. %.1lf\n",minNx,maxNx);
	printf("Ny:  %.1lf .. %.1lf\n",minNy,maxNy);

//	printf("frame: %d\n",frame);

	frame++;
	zxFrame = (int)floor(framesForRender * frame);

        if (drog > 0) {
            drog--;
        }

	if (phase == 1) {
		mapAngle += 2;
		if (mapAngle >= mapAnglePhase2Max) {
			phase = 2;
		}
	} else if (phase == 2) {
		phaseCubeDz += cubeStep2;
		phaseBgDz += mapStep2;
	}

		// next phase
	if (zxFrame >= slowDown*208*2 && phase == 0) {
		phase = 1;
	}
	if (zxFrame >= slowDown*208*2+182 && phase == 0) {
		phase = 3;
	}
	if (zxFrame >= slowDown*208*4) {
		phase = 0;
		phaseCubeDz = 0;
		phaseBgDz = 0;
		mapAngle = 0;
		frame = 0;
		dirListId = 0;
	}

	nextStep();
}





int main(int argc, char **argv) {

	int ch;

	// set_default_pal();

	frame=0;

	grsim_init();

	gr();

	clear_screens();

	init();

	soft_switch(MIXCLR);

	while(1) {

	renderFrame();

	frame++;		// increment frame counter

//	dump_framebuffer_gr();

	grsim_update();

	usleep(100000);

	ch=grsim_input();
	if (ch=='q') return 0;
	if (ch==27) return 0;

	}

	return 0;

}

