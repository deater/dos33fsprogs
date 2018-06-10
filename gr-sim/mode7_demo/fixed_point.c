#include <stdio.h>
#include <math.h>


struct fixed_type {
	char i;
	unsigned char f;
};


static void double_to_fixed(double d, struct fixed_type *f) {

	int temp;

	temp=d*256;

	f->i=(temp>>8)&0xff;

	f->f=temp&0xff;


}

static void print_fixed(struct fixed_type *f) {

	printf("0x%02X,0x%02X",f->i,f->f);
}

static void fixed_to_double(struct fixed_type *f, double *d) {

	*d=f->i;
	*d+=((double)(f->f))/256.0;

//	printf("(%02x.%02x)=%lf\n",f->i,f->f,*d);

}

static void fixed_add(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {
	int carry;
	short sum;

	sum=(short)(x->f)+(short)(y->f);

	if (sum>=256) carry=1;
	else carry=0;

	z->f=sum&0xff;

	z->i=x->i+y->i+carry;
}

static void fixed_mul(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {

	int a,b,c;

	a=((x->i)<<8)+(x->f);
	b=((y->i)<<8)+(y->f);

	c=a*b;
//	printf("%x %x %x\n",a,b,c);

	c>>=8;

	z->i=(c>>8);
	z->f=(c&0xff);
}


int main(int argc, char **argv) {

	struct fixed_type f,fa,fb,fc;
	double d,c;
	int i;

	printf("Testing positive:\n");

	printf("\tConverting 4.25 to fixed: ");
	double_to_fixed(4.25,&f);
	fixed_to_double(&f,&d);
	print_fixed(&f);
	printf(" %lf\n",d);

	printf("\tConverting 3.14159265358979 to fixed: ");
	double_to_fixed(3.14159265358979,&f);
	fixed_to_double(&f,&d);
	print_fixed(&f);
	printf(" %lf\n",d);

	printf("\tConverting 127.333333333 to fixed: ");
	double_to_fixed(127.333333333,&f);
	fixed_to_double(&f,&d);
	print_fixed(&f);
	printf(" %lf\n",d);

	printf("\tConverting 50.9 to fixed: ");
	double_to_fixed(50.9,&f);
	fixed_to_double(&f,&d);
	print_fixed(&f);
	printf(" %lf\n",d);

	printf("Testing negative:\n");

	printf("\tConverting -4.25 to fixed: ");
	double_to_fixed(-4.25,&f);
	fixed_to_double(&f,&d);
	print_fixed(&f);
	printf(" %lf\n",d);

	printf("\tConverting -3.14159265358979 to fixed: ");
	double_to_fixed(-3.14159265358979,&f);
	fixed_to_double(&f,&d);
	print_fixed(&f);
	printf(" %lf\n",d);

	printf("\tConverting -127.333333333 to fixed: ");
	double_to_fixed(-127.333333333,&f);
	fixed_to_double(&f,&d);
	print_fixed(&f);
	printf(" %lf\n",d);

	printf("\tConverting -50.9 to fixed: ");
	double_to_fixed(-50.9,&f);
	fixed_to_double(&f,&d);
	print_fixed(&f);
	printf(" %lf\n",d);

	printf("Testing addition:\n");

	printf("\t2.75 + 12.75 = %lf, ",2.75+12.75);
	double_to_fixed(2.75,&fa);
	double_to_fixed(12.75,&fb);
	fixed_add(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);
	print_fixed(&fc);
	printf(" %lf\n",c);

	printf("\t-1.25 + -1.75 = %lf, ",-1.25 + -1.75);
	double_to_fixed(-1.25,&fa);
	double_to_fixed(-1.75,&fb);
	fixed_add(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);
	print_fixed(&fc);
	printf(" %lf\n",c);

	printf("\t5.0 + -4.1 = %lf, ",5.0 + -4.1);
	double_to_fixed(5.0,&fa);
	double_to_fixed(-4.1,&fb);
	fixed_add(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);
	print_fixed(&fc);
	printf(" %lf\n",c);

	printf("Testing multiplication:\n");

	printf("\t2.5 * 2.5 = %lf, ",2.5 * 2.5);
	double_to_fixed(2.5,&fa);
	double_to_fixed(2.5,&fb);
	fixed_mul(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);
	print_fixed(&fc);
	printf(" %lf\n",c);

	printf("\t-1.1 * -1.1 = %lf, ",-1.1 * -1.1);
	double_to_fixed(-1.1,&fa);
	double_to_fixed(-1.1,&fb);
	fixed_mul(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);
	print_fixed(&fc);
	printf(" %lf\n",c);

	printf("\t-2 * 5 = %lf, ",-2.0 * 5.0);
	double_to_fixed(-2.0,&fa);
	double_to_fixed(5.0,&fb);
	fixed_mul(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);
	print_fixed(&fc);
	printf(" %lf\n",c);

	printf("\t13.2 * -0.5 = %lf, ",13.2 * -0.5);
	double_to_fixed(13.2,&fa);
	double_to_fixed(-0.5,&fb);
	fixed_mul(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);
	print_fixed(&fc);
	printf(" %lf\n",c);

	int sin_steps=64;

	printf("Sine table %d steps\n",sin_steps);
	for(i=0;i<sin_steps;i++) {
		d=sin((double)i/sin_steps*3.1415926535897932384*2.0);
		double_to_fixed(d,&fa);
		print_fixed(&fa);
		printf("// %lf\n",d);
	}

	double space_z=0.5;
	double coach_z;
	double horizon=-2.0;

	printf("horizontal_scale_lookup_20:\n");
	for(space_z=0.5;space_z<7.5;space_z+=1.0) {
		printf("{");
		for(i=8;i<40;i+=2) {
			coach_z=space_z/((double)i-horizon);
			double_to_fixed(coach_z,&fa);
			if (fa.i!=0) {
				printf("CRITICAL ERROR TOP NOT 0\n");
			}
			printf("0x%02X,",fa.f);

		}
		printf("},\n");
	}

	printf("horizontal_scale_lookup_40:\n");
	for(space_z=0.5;space_z<7.5;space_z+=1.0) {
		printf("{");
		for(i=8;i<40;i+=1) {
			coach_z=space_z/((double)i-horizon);
			double_to_fixed(coach_z,&fa);
			if (fa.i!=0) {
				printf("CRITICAL ERROR TOP NOT 0\n");
			}
			printf("0x%02X,",fa.f);

		}
		printf("},\n");
	}

	for(coach_z=-1.0;coach_z<1.0;coach_z+=0.1) {
		double_to_fixed(coach_z,&fa);
		printf("%lf\t%02X,%02X\n",coach_z,fa.i,fa.f);
	}

	return 0;
}
