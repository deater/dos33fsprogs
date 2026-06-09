/* An Apple II lores version of the ZX Spectrim Tiratok Demo Walking Cube */

/* based on stepping_cube_ZX2.html javascript code */

/* deater -- Vince Weaver -- vince@deater.net -- 8 June 2026 */


#include <stdio.h>
#include <unistd.h>

#include "gr-sim.h"

#include <stdio.h>
#include <unistd.h>
#include <math.h>

static void framebuffer_putpixel(unsigned int x, unsigned int y,
	unsigned char color) {

	color_equals(color);
	basic_plot(x,y);

}

#define canvasSizeX 32
#define canvasSizeY 48

	const int canvasZoomX = 4 * (64/canvasSizeX);
	const int canvasZoomY = 4 * (48/canvasSizeY);

	int frame = 0;
	double zxFrame;
	const double framesForRender = 5.2;
	const double slowDown = 1;

	int palette[3][8]={
		{0x000073,0x000073,0x00009D,0x0000E6,0x0073E6,0x009DE6,0x009DE6,0x009DE6},
		{0x0000E6,0x0073E6,0x009DE6,0x00E6E6,0x73E6E6,0x9DE6E6,0xE6E6E6,0xE6E6E6},
		{0x000000,0x730073,0x9D009D,0xE600E6,0xE67300,0xE69D00,0xE6E69D,0xE6E6E6},
	};

	int apple2_palette[3][8]={

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


	int paletteZX[] = {
		0x000000,0x9D009D,0x9D00E6,0xE600E6,0xE6739D,0xE69D73,0xE6E69D,0xE6E6E6,
		0x9DE6E6,0x73E6E6,0x00E6E6,0x009DE6,0x0073E6,0x0000E6,0x00009D,0x000073
	};

	int backShade[] = {
		0,0,0,0,
		1,1,1,1,
		2,2,2,2,
		3,3,3,3,
		4,4,4,4,
		5,5,5,5,5,5,
		6,6,6,6,6,6,
		6,6,
	};

	int dirListId = 0;
	int dirList[] = {
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

	int mapLightArr[256];
//		0x00: 0,
//		0x40: 1,
//		0x60: 2,
//		0x80: 3,
//		0xA0: 4,
//		0xC0: 5,
//		0xE0: 6,
//		0xFF: 7,
//	}

//	var mapLight = [];
//	var canvasLight = document.getElementById('canvas-light');
//	var ctxLight = canvasLight.getContext('2d');
//	var imgLight = document.getElementById('img-light');
//	ctxLight.drawImage(imgLight, 0, 0);
//	var lightData = ctxLight.getImageData(0,0,32,32).data;
//	for (var y = 0; y < 32; y++) {
//		mapLight[y] = [];
//		for (var x = 0; x < 32; x++) {
//			var adr = 4*(y*32+x);
//			var color = lightData[adr];
//			mapLight[y][x] = mapLightArr[color];
//		}
//	}

	/* scr buff */
	int screenBuff[canvasSizeY][canvasSizeX];
	int screenBuffMask[128][128];
	int screenBuffShadow[128][128];

#define mapSizeX	63
#define mapSizeY	63

	double map[mapSizeX][mapSizeY];

#define	drogMax		2

#define cubePolygonsLength	6
#define cubePolygonsRotLength	6

	int cubePolygons[cubePolygonsLength][5] = {
		{0,1,2,3,0},
		{5,4,7,6,0},
		{1,5,6,2,0},
		{4,0,3,7,0},
		{0,4,5,1,0},
		{2,6,7,3,0}
	};

	int drog;

	int mapDx = 8;
	int mapDz = 8;
	int mapAngle = 0;


	int rotAngleCubeDir;
	int rotAngleCubeX = 0;
	int rotAngleCubeY = 0;
	int rotAngleCubeZ = 0;
	int cubeDx = 0;
	int cubeDz = 0;

	int faze = 0;
	int fazeCubeDz = 0;
	int fazeBgDz = 0;

#define	mapAngleFaze2Max	104 //112

int getNextDir(void) {
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

	const int cubeAngleMax = 64;
	const double cubeAngleStep = 12 / slowDown;
	const double cubeStep = 4 / slowDown;
	const double mapStep = 3.2 / slowDown;

	const double cubeStep2 = 30 * cubeStep / 80;
	const double mapStep2 = 30 * mapStep / 80;

void init(void) {

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



	faze = 0;
	fazeCubeDz = 0;
	fazeBgDz = 0;


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
	a = M_PI * alphaX / 128;
	y = round(point.y * cos(a)) + round(point.z * sin(a));
	z = -round(point.y * sin(a)) + round(point.z * cos(a));
	point.y = y;
	point.z = z;
	// rotate Y
	a = M_PI * alphaY / 128;
	x = round(point.x * cos(a)) + round(point.z * sin(a));
	z = -round(point.x * sin(a)) + round(point.z * cos(a));
	point.x = x;
	point.z = z;
	// rotate Z
	a = M_PI * alphaZ / 128;
	x = round(point.x * cos(a)) + round(point.y * sin(a));
	y = -round(point.x * sin(a)) + round(point.y * cos(a));
	point.x = x;
	point.y = y;

	result->x=point.x;
	result->y=point.y;
	result->z=point.z;

}

	int minCx = 9999;
	int minCy = 9999;
	int minCz = 9999;
	int maxCx = 0;
	int maxCy = 0;
	int maxCz = 0;

	int minLx = 9999;
	int maxLx = 0;
	int minLy = 9999;
	int maxLy = 0;

	int minNx = 9999;
	int maxNx = 0;
	int minNy = 9999;
	int maxNy = 0;



void nextStep(void) {

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


#if 0
        function compareSortPolygons(a, b) {
            var comparison = 0;
            if (a.z > b.z) {
                comparison = 1;
            } else if (a.z < b.z) {
                comparison = -1;
            } else if (a.y > b.y) {
                comparison = -1;
            } else if (a.y < b.y) {
                comparison = 1;
            }
            return comparison;
        }
#endif

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

	if (nn.z > 0) {
		return;
	}

	//calc lights
	minNx = fmin(minNx, nn.x);
	maxNx = fmax(maxNx, nn.x);
	minNy = fmin(minNy, nn.y);
	maxNy = fmax(maxNy, nn.y);

#if 0
	globL = mapLight[31&(10+nn.y)][31&(16+nn.x)];

	for(i=0; i<3; i++) {
		points[i].l = mapLight[31&(10+nn.y)][31&(16+nn.x)];
		//lights method 3
		var nadd = {x:floor((centerPoints[i].x+nn.x)/2), y:floor((centerPoints[i].y+nn.y)/2), z:floor((centerPoints[i].z+nn.z)/2)};
		points[i].lx = nadd.x;
		points[i].ly = nadd.y;
		points[i].l += floor(mapLight[31&(10+nadd.y)][31&(16+nadd.x)]/2);
		points[i].l = points[i].l <= 7 ? points[i].l : 7;
		minLx = fmin(minLx, nadd.x);
		maxLx = fmax(maxLx, nadd.x);
		minLy = fmin(minLy, nadd.y);
		maxLy = fmax(maxLy, nadd.y);
	}

	// draw polygon
	points.sort(zxComparePY);
#endif

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

	double leftX[32],rightX[32];	/* size??? */
	struct coord_type leftLLL[32],rightLLL[32];

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

	//draw
	i = 0;
	double dx = 0,lx,ly,L;
	for (y = zxPoints[0].py; y <= zxPoints[2].py; y++) {

//		if (rightX[i] != undefined && leftX[i] != undefined) {
		dx = fabs(rightX[i] - leftX[i]);

		if (rightX[i] >= leftX[i]) {
			for (x=leftX[i]; x<=rightX[i]; x++) {
				lx = leftLLL[i].lx + (x-leftX[i]) *
					(rightLLL[i].lx - leftLLL[i].lx) / dx;
				ly = leftLLL[i].ly + (x-leftX[i]) *
					(rightLLL[i].ly - leftLLL[i].ly) / dx;
#if 0
				L = round(globL/1.5 + mapLight[31&(9+ly)][31&(16+lx)]/1.5);
				L = Math.max(round(globL/1.5), round(mapLight[31&(9+ly)][31&(16+lx)]/1));
				L = round(globL/3 + mapLight[31&(9+ly)][31&(16+lx)]);
				L = L <= 7 ? L : 7;
				L = L > 1 ? L : 1;
#endif
				screenBuff[y][x] = paletteZX[(int)floor(L)];
				screenBuffMask[y][x] = 1;


			}
		} else {
			for(x=rightX[i]; x<=leftX[i]; x++) {
				lx = rightLLL[i].lx + (x-rightX[i]) * (leftLLL[i].lx - rightLLL[i].lx) / dx;
				ly = rightLLL[i].ly + (x-rightX[i]) * (leftLLL[i].ly - rightLLL[i].ly) / dx;
#if 0
				L = round(globL/1.5 + mapLight[31&(9+ly)][31&(16+lx)]/1.5);
				L = fmax(round(globL/1.5), round(mapLight[31&(9+ly)][31&(16+lx)]/1));
				L = round(globL/3 + mapLight[31&(9+ly)][31&(16+lx)]);
				L = L <= 7 ? L : 7;
				L = L > 1 ? L : 1;
#endif
				screenBuff[y][x] = paletteZX[(int)floor(L)];
				screenBuffMask[y][x] = 1;
			}
		}
		i++;
	} // y

}



#if 0
void zxComparePY(a, b) {
	if (a.py == b.py) {
		return 0;
	}
	return a.py > b.py ? 1 : -1;
}


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

void calcNorm2(
	struct coord_type *result,
	struct coord_type centerPoints[4]) {

	result->x = floor((centerPoints[0].x + centerPoints[1].x +
			centerPoints[2].x + centerPoints[3].x) / 40*15);
	result->y = floor((centerPoints[0].y + centerPoints[1].y +
			centerPoints[2].y + centerPoints[3].y) / 40*15);
	result->z = floor((centerPoints[0].z + centerPoints[1].z +
			centerPoints[2].z + centerPoints[3].z) / 40*15);

}

double vec3ugol(
	struct coord_type a,
	struct coord_type b) {

	return ((a.x*b.x + a.y*b.y + a.z*b.z) /
		( sqrt(a.x*a.x + a.y*a.y + a.z*a.z) *
		  sqrt(b.x*b.x + b.y*b.y + b.z*b.z) ) );
}


void vec3sub(
	struct coord_type *result,
	struct coord_type a,
	struct coord_type b) {

	result->x=b.x-a.x;
	result->y=b.y-a.y;
	result->z=b.z-a.z;
}


	/* calc & render */
void renderFrame(void) {

	int minSx = 9999;
	int maxSx = 0;
	int minSy = 9999;
	int maxSy = 0;

	int y,x,i;

		// clear buff
	for(y=0; y<canvasSizeY; y++) {
		for(x=0; x<canvasSizeX; x++) {
			screenBuff[y][x] = 0;
			screenBuffMask[y][x] = 0;
			screenBuffShadow[y][x] = 0;
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

			ty = (mapSizeY - 1) & (int)floor(ty + mapDz + fazeBgDz);
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

	/* draw the cube */

	struct coord_type vec3;

//	struct rot_type {
//		double x,y,z;
//		double xx,yy,zz;
//	}

	struct coord_type cubePointsRot[cubePointsLength];

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
		cubePointsRot[i].z += fazeCubeDz;
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

	struct cubePolygonsRot_type {
		struct coord_type points[4];
		double x,y,z;
		struct coord_type centerPoints[4];
		struct coord_type nn;		// normal
		struct coord_type center;
	} cubePolygonsRot[cubePolygonsLength];

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



#if 0
        cubePolygonsRot.sort(compareSortPolygons);
#endif

	double rgb;
	int p;

		// draw polygons zx
	for(i=0; i<cubePolygonsRotLength; i++) {
		rgb = floor(i*255/(cubePolygonsRotLength-1));
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


        // draw buff zx
#if 0
	int buffDy = 0;
	if (drog > 0) {
		buffDy = ((drog % 2) == 0 ? -1 : +1);
	}
#endif
        for (y = 0; y < canvasSizeY; y++) {
            for (x = 0; x < canvasSizeX; x++) {
		framebuffer_putpixel(x,y,screenBuff[y][x]);

//                ctxZX.fillStyle = screenBuff[y+buffDy-2]!=undefined ? screenBuff[y+buffDy-2][x] : screenBuff[y][x];
  //              ctxZX.fillRect(x*canvasZoomX, y*canvasZoomY, canvasZoomX, canvasZoomY);
            }
        }

        // show info
#if 0
		document.getElementById('info').innerHTML = ''
			+ 'frameRendered: ' + frame + ', frameZX: ' + floor(framesForRender * frame) + '<br>'
			+ 'sx: ' + minSx + ' .. ' + maxSx + '<br>'
			+ 'sy: ' + minSy + ' .. ' + maxSy + '<br>'

			+ 'x: ' + minCx + ' .. ' + maxCx + '<br>'
			+ 'y: ' + minCy + ' .. ' + maxCy + '<br>'
			+ 'z: ' + minCz + ' .. ' + maxCz + '<br>'

			+ 'Lx: ' + minLx + ' .. ' + maxLx + '<br>'
			+ 'Ly: ' + minLx + ' .. ' + maxLy + '<br>'

			+ 'Nx: ' + minNx + ' .. ' + maxNx + '<br>'
			+ 'Ny: ' + minNx + ' .. ' + maxNy + '<br>'
			;

#endif

	printf("frame: %d\n",frame);

	frame++;
	zxFrame = (int)floor(framesForRender * frame);

        if (drog > 0) {
            drog--;
        }

	if (faze == 1) {
		mapAngle += 2;
		if (mapAngle >= mapAngleFaze2Max) {
			faze = 2;
		}
	} else if (faze == 2) {
		fazeCubeDz += cubeStep2;
		fazeBgDz += mapStep2;
	}

		// next faze
	if (zxFrame >= slowDown*208*2 && faze == 0) {
		faze = 1;
	}
	if (zxFrame >= slowDown*208*2+182 && faze == 0) {
		faze = 3;
	}
	if (zxFrame >= slowDown*208*4) {
		faze = 0;
		fazeCubeDz = 0;
		fazeBgDz = 0;
		mapAngle = 0;
		frame = 0;
//		isAudioStarted = 0;
//		document.getElementById('player').pause();
//		document.getElementById('player').currentTime = 0;
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

	usleep(20000);

	ch=grsim_input();
	if (ch=='q') return 0;
	if (ch==27) return 0;

	}

	return 0;

}

