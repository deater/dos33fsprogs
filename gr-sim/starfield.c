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
	struct fixed_type z;
	int color;
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

static void fixed_add(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {
        int carry;
        short sum;

        sum=(short)(x->f)+(short)(y->f);

        if (sum>=256) carry=1;
        else carry=0;

        z->f=sum&0xff;

        z->i=x->i+y->i+carry;
}

static double fixed_to_double(struct fixed_type *f) {

	double d;

        d=f->i;
        d+=((double)(f->f))/256.0;

//      printf("(%02x.%02x)=%lf\n",f->i,f->f,*d);

	return d;
}


static struct star_type stars[NUMSTARS];

static	int random_table[256];
static	int random_pointer=0;

static void random_star(int i) {

		/* -128 to 128 */

		/* Should we xor? */
		stars[i].x.i=random_table[random_pointer++];
		if (random_pointer>255) random_pointer=0;

		stars[i].x.f=random_table[random_pointer++];
		if (random_pointer>255) random_pointer=0;

		stars[i].y.i=random_table[random_pointer++];
		if (random_pointer>255) random_pointer=0;
		stars[i].y.f=random_table[random_pointer++];
		if (random_pointer>255) random_pointer=0;

//		double_to_fixed( (drand48()-0.5)*spreadx,&stars[i].x);
//		double_to_fixed( (drand48()-0.5)*spready,&stars[i].y);

		/* 0.1 to 16 */
		stars[i].z.i=random_table[random_pointer++]/16;
		if (random_pointer>255) random_pointer=0;
		stars[i].z.f=0x1;

//		double_to_fixed( ((drand48())*spreadz)+0.1,&stars[i].z);
//		print_fixed(&stars[i].x);
//		printf(",");
//		print_fixed(&stars[i].y);
//		printf(",");
//		print_fixed(&stars[i].z);
//		printf("\n");


//	double_to_fixed((drand48()-0.5)*spreadx,&stars[i].x);
//	double_to_fixed((drand48()-0.5)*spready,&stars[i].y);
//	stars[i].z.i=spreadz;

}

int main(int argc, char **argv) {

	int ch,i;

//	int spreadx=256;
//	int spready=256;
	int spreadz=16;
	struct fixed_type speedz;

	for(i=0;i<256;i++) {
		random_table[i]=rand()%256;
		printf("%d\n",random_table[i]);
	}

	double_to_fixed(-0.25,&speedz);

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
			if (stars[i].z.i<(spreadz/3)) stars[i].color=15;
			else if (stars[i].z.i<(spreadz*2/3)) stars[i].color=13;
			else stars[i].color=5;

		}

		/* draw stars */
		for(i=0;i<NUMSTARS;i++) {
			int tempx,tempy;
			double dx,dy;

			dx=fixed_to_double(&stars[i].x)/
				fixed_to_double(&stars[i].z);

			tempx=dx+20;

			dy=fixed_to_double(&stars[i].y)/
				fixed_to_double(&stars[i].z);

			tempy=dy+20;

			if ((tempx<0) || (tempy<0) || (tempx>=40) ||
				(tempy>=40)) {

				random_star(i);
			}
			else {
				color_equals(stars[i].color);
				basic_plot(tempx,tempy);
			}

		}

		/* Move stars */
		for(i=0;i<NUMSTARS;i++) {
			fixed_add(&stars[i].z,&speedz,&stars[i].z);
		}

		grsim_update();
		ch=grsim_input();
		if (ch=='q') exit(0);
		usleep(10000);
	}

	return 0;
}
