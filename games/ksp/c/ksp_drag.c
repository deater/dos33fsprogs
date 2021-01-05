#include <stdio.h>
#include <math.h>

int main(int argc, char **argv) {

	double v0=0;
	double g=9.8;
	double mass=700;
	double coeff=0.5;
	double area=3.0*1000.0;
	double density=0.1;
	double time=0.0;
	double a=0.0;
	double altitude=20000.0;
	double deltat=1.0;
	double pressure,pressure0=101325.0;
	double temperature=273.0;
	double v_dir;
	double ga,da;
	double terminal_velocity;

#define KERBIN_RADIUS	600000.0

	while(1) {

		terminal_velocity=sqrt( (2*mass*g)/(density*area*coeff));

		if (v0>0) v_dir=-1; else v_dir=1;
		ga=-g;
		da=v_dir*(1.0/(2.0*mass))*coeff*density*area*v0*v0;

		a=ga+da;

//		v0=v0+(a*deltat);
		v0=-terminal_velocity;
		altitude=altitude+(v0*deltat);
		time+=deltat;

		pressure=pressure0*exp(-(altitude)/5600);
                density=pressure/(287*temperature);

		g=9.8/(
                        ((altitude+KERBIN_RADIUS)/KERBIN_RADIUS)*
                        ((altitude+KERBIN_RADIUS)/KERBIN_RADIUS));


		printf("t=%lf ga=%lf da=%lf a=%lf v=%lf y=%lf tv=%lf\n",time,ga,da,a,v0,altitude,
			terminal_velocity);
		if ((altitude<0) || (altitude>21000)) break;
	}

	return 0;
}
