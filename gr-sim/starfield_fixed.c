#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "gr-sim.h"

#define NUMSTARS	16

struct fixed_type {
	char i;
	unsigned char f;
};


struct star_type {
	struct fixed_type x;
	struct fixed_type y;
	int z;
};

static void double_to_fixed(double d, struct fixed_type *f) {

        int temp;

        temp=d*256;

        f->i=(temp>>8)&0xff;

        f->f=temp&0xff;


}

#if 0
static void print_fixed(struct fixed_type *f) {

        printf("%02X.%02X",f->i,f->f);
}
#endif

#if 0
static void fixed_add(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {
        int carry;
        short sum;

        sum=(short)(x->f)+(short)(y->f);

        if (sum>=256) carry=1;
        else carry=0;

        z->f=sum&0xff;

        z->i=x->i+y->i+carry;
}
#endif

#if 0
static double fixed_to_double(struct fixed_type *f) {

	double d;

        d=f->i;
        d+=((double)(f->f))/256.0;

//      printf("(%02x.%02x)=%lf\n",f->i,f->f,*d);

	return d;
}
#endif

static struct star_type stars[NUMSTARS];

static int random_table[256];
static int random_pointer=0;

static int z_table[64];

static void random_star(int i) {

	/* -128 to 128 */

	/* Should we xor? */
	stars[i].x.i=random_table[random_pointer++];
	if (random_pointer>255) random_pointer=0;

//	stars[i].x.f=random_table[random_pointer++];
//	if (random_pointer>255) random_pointer=0;

	stars[i].y.i=random_table[random_pointer++];
	if (random_pointer>255) random_pointer=0;
//	stars[i].y.f=random_table[random_pointer++];
//	if (random_pointer>255) random_pointer=0;

//	double_to_fixed( (drand48()-0.5)*spreadx,&stars[i].x);
//	double_to_fixed( (drand48()-0.5)*spready,&stars[i].y);

	/* 0 to 63 corresponding to  */
	stars[i].z=random_table[random_pointer++]&0x3f;
	if (random_pointer>255) random_pointer=0;
//	if (stars[i].z>58) stars[i].z=0;

//	double_to_fixed( ((drand48())*spreadz)+0.1,&stars[i].z);
//	print_fixed(&stars[i].x);
//	printf(",");
//	print_fixed(&stars[i].y);
//	printf(",");
//	print_fixed(&stars[i].z);
//	printf("\n");


//	double_to_fixed((drand48()-0.5)*spreadx,&stars[i].x);
//	double_to_fixed((drand48()-0.5)*spready,&stars[i].y);
//	stars[i].z.i=spreadz;

}

static void fixed_mul(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {

        int a,b,c;

        a=((x->i)<<8)+(x->f);
        b=((y->i)<<8)+(y->f);

        c=a*b;
//      printf("%x %x %x\n",a,b,c);

        c>>=8;

        z->i=(c>>8);
        z->f=(c&0xff);
}


int main(int argc, char **argv) {

	int ch,i;

//	int spreadx=256;
//	int spready=256;
//	int spreadz=16;
//	struct fixed_type speedz;

	for(i=0;i<256;i++) {
		random_table[i]=rand()%256;
		printf("%d,",random_table[i]);
	}
	printf("\n");

	double g;
	struct fixed_type gf;
	int color;
	i=0;

	for(g=16.0;g>0;g-=0.25) {
		double_to_fixed(1.0/g,&gf);
		printf("%d %.2f: %.2f %2X %2X\n",i,g,1.0/g,
			gf.i,gf.f);
		z_table[i]=gf.f;
		i++;
	}
	printf("\n");


//	double_to_fixed(-0.25,&speedz);

	grsim_init();

	/* Should NUMSTARS be prime to help with randomness */

	for(i=0;i<NUMSTARS;i++) {
		random_star(i);
	}
	gr();

	while(1) {
		gr();

		/* Set color */
		for(i=0;i<NUMSTARS;i++) {


		}

		/* draw stars */
		for(i=0;i<NUMSTARS;i++) {

			struct fixed_type dx,dy,temp;

			temp.i=0;//z_table[stars[i].z];
			if ((stars[i].z==60)  || (stars[i].z==61)) {
				temp.i=1;
			}
			if (stars[i].z==62) {
				temp.i=2;
			}
			if (stars[i].z==63) {
				temp.i=4;
			}

			temp.f=z_table[stars[i].z];

			fixed_mul(&stars[i].x,&temp,&dx);

//			dx=fixed_to_double(&stars[i].x)/
//				fixed_to_double(&stars[i].z);

//			tempx=dx+20;

			dx.i+=20;

			fixed_mul(&stars[i].y,&temp,&dy);

//			dy=fixed_to_double(&stars[i].y)/
//				fixed_to_double(&stars[i].z);

//			tempy=dy+20;

			dy.i+=20;


			if (stars[i].z<16) color=5;
			else if (stars[i].z<32) color=13;
			else color=15;

			if ((dx.i<0) || (dy.i<0) || (dx.i>=40) ||
				(dy.i>=40)) {

				random_star(i);
			}
			else {
//				if (stars[i].z>58) {
//					printf("EEK! %2X.%2X\n",
//						stars[i].z,stars[i].z);
//				}
				color_equals(color);
				basic_plot(dx.i,dy.i);
			}

		}

		/* Move stars */
		for(i=0;i<NUMSTARS;i++) {
//			fixed_add(&stars[i].z,&speedz,&stars[i].z);
			stars[i].z++;
			if (stars[i].z>=64) random_star(i);
		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(10000);
	}

	return 0;
}
