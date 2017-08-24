#include <stdio.h>
#include <math.h>


struct fixed_type {
	char i;
	unsigned char f;
};


void double_to_fixed(double d, struct fixed_type *f) {

	double temp;

	f->i=(int)d;

	temp=d-(f->i);

	temp*=256;

	f->f=temp;

	printf("%lf=%02x.%02x (%d/0x%x)\n",d,f->i,f->f,(int)temp,(int)temp);
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


	return 0;
}
