/* by @a1k0n */

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

// CORDIC algorithm to find magnitude of |x,y| by rotating the x,y vector onto
// the x axis. This also brings vector (x2,y2) along for the ride, and writes
// back to x2 -- this is used to rotate the lighting vector from the normal of
// the torus surface towards the camera, and thus determine the lighting amount.
// We only need to keep one of the two lighting normal coordinates.
int length_cordic(int16_t x, int16_t y, int16_t *x2_, int16_t y2) {

  int16_t x2 = *x2_;

//printf("before: x=0x%hx y=0x%hx x2=0x%hx y2=0x%hx\n",x,y,x2,y2);

  if (x < 0) { // start in right half-plane
    x = -x;
    x2 = -x2;
  }

//printf("after: x=0x%hx y=0x%hx x2=0x%hx y2=0x%hx\n",x,y,x2,y2);

  for (int i = 0; i < 8; i++) {
    int16_t t = x;
    int16_t t2 = x2;
    if (y < 0) {
      x -= y >> i;
      y += t >> i;
      x2 -= y2 >> i;
      y2 += t2 >> i;
    } else {
      x += y >> i;
      y -= t >> i;
      x2 += y2 >> i;
      y2 -= t2 >> i;
    }
	//printf("(%d) x=0x%hx y=0x%hx x2=0x%hx y2=0x%hx\n",i,x,y,x2,y2);
  }
  // divide by 0.625 as a cheap approximation to the 0.607 scaling factor factor
  // introduced by this algorithm (see https://en.wikipedia.org/wiki/CORDIC)
  *x2_ = (x2 >> 1) + (x2 >> 3);
  return (x >> 1) + (x >> 3);
}

int main(int argc, char **argv) {

	int ch;

	grsim_init();
	gr();

	// high-precision rotation directions, sines and cosines and their products

	int16_t sB = 0, cB = 16384;
	int16_t sA = 11583, cA = 11583;
	int16_t sAsB = 0, cAsB = 0;
	int16_t sAcB = 11583, cAcB = 11583;

	const int16_t r1i = 256;
	const int16_t r2i = 2*256;

	while(1) {

		// yes this is a multiply but dz is 5
		// so it's (sb + (sb<<2)) >> 6 effectively

		/* urgh math is done in 32-bit before casting to 16? */
		int16_t p0x = (sB + (sB<<2)) >> 6;
		int16_t p0y = (sAcB + (sAcB<<2)) >> 6;
		int16_t p0z = (- (cAcB +(cAcB<<2))) >> 6;



    int16_t yincC = (cA >> 6) + (cA >> 5);      // 12*cA >> 8;
    int16_t yincS = (sA >> 6) + (sA >> 5);      // 12*sA >> 8;
    int16_t xincX = (cB >> 7) + (cB >> 6);      // 6*cB >> 8;
    int16_t xincY = (sAsB >> 7) + (sAsB >> 6);  // 6*sAsB >> 8;
    int16_t xincZ = (cAsB >> 7) + (cAsB >> 6);  // 6*cAsB >> 8;
    int16_t ycA = -((cA >> 1) + (cA >> 4));     // -12 * yinc1 = -9*cA >> 4;
    int16_t ysA = -((sA >> 1) + (sA >> 4));     // -12 * yinc2 = -9*sA >> 4;

    for (int j = 0; j < 23; j++) {

      int16_t xsAsB = (sAsB >> 4) - sAsB;  // -40*xincY
      int16_t xcAsB = (cAsB >> 4) - cAsB;  // -40*xincZ;

      int16_t vxi14 = (cB >> 4) - cB - sB; // -40*xincX - sB;
      int16_t vyi14 = ycA - xsAsB - sAcB;
      int16_t vzi14 = ysA + xcAsB + cAcB;

      for (int i = 0; i < 79; i++) {

        int16_t t = 512;

        int16_t px = p0x + (vxi14 >> 5);
        int16_t py = p0y + (vyi14 >> 5);
        int16_t pz = p0z + (vzi14 >> 5);

        int16_t lx0 = sB >> 2;
        int16_t ly0 = (sAcB - cA) >> 2;
        int16_t lz0 = (-cAcB - sA) >> 2;
        for (;;) {
          int16_t t0, t1, t2, d;
          int16_t lx = lx0, ly = ly0, lz = lz0;

	//printf("lx0=0x%hx ly0=0x%hx lz0=0x%hx\n",lx0,ly0,lz0);
	//printf("px=0x%hx py=0x%hx lx=0x%hx ly=0x%hx\n",px,py,lx,ly);


          t0 = length_cordic(px, py, &lx, ly);

	//printf("after cord t0=0x%hx lx=0x%hx\n",t0,lx);

	t1 = t0 - r2i;

	//printf("t1=0x%hx\n",t1);


	//printf("pz=0x%hx t1=0x%hx lz=0x%hx lx=0x%hx\n",pz,t1,lz,lx);
	t2 = length_cordic(pz, t1, &lz, lx);

	//printf("after: t2=0x%hx lz=0x%hx\n",t2,lz);

          d = t2 - r1i;

	//printf("d=0x%hx\n",d);

          t += d;

	//printf("t=0x%hx\n",t);
		// 0 2 2 6 6 5 5 7  7 15 15 15
		// 2 2 6 6 5 5 7 7 15 15 15 15
	int color_hi[12]={0, 2, 2, 6, 6, 5, 5, 5, 7, 7, 15, 15 };
	int color_lo[12]={2, 2, 6, 6, 5, 5, 5, 7, 7, 15, 15, 15 };

	//printf("r1i=0x%hx r2i=0x%hx\n",r1i,r2i);
	//printf("sB=0x%hx sAcB=0x%hx cAcB=0x%x\n",sB,sAcB,cAcB);
	//printf("p0x=0x%hx p0y=0x%hx p0z=0x%x\n",p0x,p0y,p0z);
	//printf("cA=0x%hx yincC=0x%hx\n",cA,yincC);
	//printf("sA=0x%hx yincS=0x%hx\n",sA,yincS);
	//printf("cB=0x%hx xincX=0x%hx\n",cB,xincX);
	//printf("ycA=0x%hx\n",ycA);
	//printf("xsAsB=0x%hx sAsB=0x%hx\n",xsAsB,sAsB);
	//printf("vxi14=0x%hx\n",vxi14);
	//printf("lx0=0x%hx ly0=0x%hx lz0=0x%hx\n",lx0,ly0,lz0);
	//printf("t=0x%hx d=0x%hx\n",t,d);


          if (t > 8*256) {
//		printf("%d: t=0x%hx d=0x%hx 0\n",i,t,d);
		color_equals(0);
		plot(i/2,j*2);
		plot(i/2,(j*2)+1);
		break;
          } else if (d < 2) {
		int N = lz >> 9;
		if (N<0) N=0;
		if (N>11) N=11;

//		printf("%d,%d: N=%d t=0x%hx d=0x%hx\n",i,j,N,t,d);
//		exit(1);

		color_equals(color_hi[N]);
		plot(i/2,j*2);
		color_equals(color_lo[N]);
		plot(i/2,(j*2)+1);
		break;
          }


            // 11x1.14 fixed point 3x parallel multiply
            // only 16 bit registers needed; starts from highest bit to lowest
            // d is about 2..1100, so 11 bits are sufficient
            int16_t dx = 0, dy = 0, dz = 0;
            int16_t a = vxi14, b = vyi14, c = vzi14;

	//printf("a=0x%hx b=0x%hx c=0x%hx\n",a,b,c);
            while (d) {

              if (d&1024) {
                dx += a;
                dy += b;
                dz += c;
              }
              d = (d&1023) << 1;
              a >>= 1;
              b >>= 1;
              c >>= 1;
		//printf("after mask: a=0x%hx b=0x%hx c=0x%hx\n",a,b,c);
            }
            // we already shifted down 10 bits, so get the last four
		//printf("before: px=0x%hx py=0x%hx pz=0x%hx\n",px,py,pz);
		//printf("        dx=0x%hx dy=0x%hx dz=0x%hx\n",dx,dy,dz);

            px += dx >> 4;
            py += dy >> 4;
            pz += dz >> 4;
		//printf("after : px=0x%hx py=0x%hx pz=0x%hx\n",px,py,pz);
		//printf("        dx=0x%hx dy=0x%hx dz=0x%hx\n",dx,dy,dz);

        }
// i end
		vxi14 += xincX;
		vyi14 -= xincY;
	 	vzi14 += xincZ;
      }
// j end
	ycA += yincC;
	ysA += yincS;


    }

		// rotate sines, cosines, and products thereof
		// this animates the torus rotation about two axes

		cA-=(sA>>5); sA+=(cA>>5);
		cAsB-=(sAsB>>5); sAsB+=(cAsB>>5);
		cAcB-=(sAcB>>5); sAcB+=(cAcB>>5);

		cB-=(sB>>6); sB+=(cB>>6);
		cAcB-=(cAsB>>6); cAsB+=(cAcB>>6);
		sAcB-=(sAsB>>6); sAsB+=(sAcB>>6);

		ch=grsim_input();
		if (ch=='q') break;

		grsim_update();

		usleep(15000);
	}
}

