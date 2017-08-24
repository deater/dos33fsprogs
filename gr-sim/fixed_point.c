#include <stdio.h>
#include <math.h>


struct fixed_type {
	char i;
	unsigned char f;
};


void double_to_fixed(double d, struct fixed_type *f) {

	int temp;

	temp=d*256;

	f->i=(temp>>8)&0xff;

	f->f=temp&0xff;

	printf("%lf=%02x.%02x\n",d,f->i,f->f);
}

void fixed_to_double(struct fixed_type *f, double *d) {

	*d=f->i;
	*d+=((double)(f->f))/256.0;

	printf("(%02x.%02x)=%lf\n",f->i,f->f,*d);

}

void fixed_add(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {
	int carry;
	short sum;

	sum=(short)(x->f)+(short)(y->f);

	if (sum>=256) carry=1;
	else carry=0;

	z->f=sum&0xff;

	z->i=x->i+y->i+carry;
}

void fixed_mul(struct fixed_type *x, struct fixed_type *y, struct fixed_type *z) {

	int a,b,c;

	a=((x->i)<<8)+(x->f);
	b=((y->i)<<8)+(y->f);

	c=a*b;
	printf("%x %x %x\n",a,b,c);

	c>>=8;

	z->i=(c>>8);
	z->f=(c&0xff);
}


int main(int argc, char **argv) {

	struct fixed_type f,fa,fb,fc;
	double d,c;

	double_to_fixed(4.25,&f);
	fixed_to_double(&f,&d);

	double_to_fixed(3.14159265358979,&f);
	fixed_to_double(&f,&d);

	double_to_fixed(127.333333333,&f);
	fixed_to_double(&f,&d);

	double_to_fixed(50.9,&f);
	fixed_to_double(&f,&d);


	double_to_fixed(2.75,&fa);
	double_to_fixed(12.75,&fb);
	fixed_add(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);

	double_to_fixed(-1.25,&fa);
	double_to_fixed(-1.75,&fb);
	fixed_add(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);

	double_to_fixed(2.5,&fa);
	double_to_fixed(2.5,&fb);
	fixed_mul(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);

	double_to_fixed(-1.1,&fa);
	double_to_fixed(-1.1,&fb);
	fixed_mul(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);


	double_to_fixed(-2.0,&fa);
	double_to_fixed(5.0,&fb);
	fixed_mul(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);

	double_to_fixed(13.2,&fa);
	double_to_fixed(-0.5,&fb);
	fixed_mul(&fa,&fb,&fc);
	fixed_to_double(&fc,&c);

	return 0;
}
