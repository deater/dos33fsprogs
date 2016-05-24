#include <stdio.h>
#include <math.h>

/* http://wiki.kerbalspaceprogram.com/wiki/Tutorial:Advanced_Rocket_Design */

/* Also, high school physics (thanks Mr. Brennen) */


void home(void) {
	printf("%c[2J%c[1;1H",27,27);
}

void htabvtab(int x,int y) {
	printf("%c[%d;%dH",27,y,x);
}


/* TODO: want 2d-vectors at least */

int main(int argc, char **argv) {

	double angle=0;

	double capsule_mass=1.0;

	double engine_isp=270.0;	/* s */
	double engine_mass=1.5;		/* tons */
	double engine_thrust=168.0;	/* kN */
	double fuel_flow_rate;

	double tank_mass=0.5;		/* tons */
	double fuel_mass=4.0;		/* tons */
	double total_fuel=fuel_mass;

	double gravity=9.8;		/* m/s^2 */

	double rocket_velocity=0.0;	/* m/s */
	double rocket_acceleration=0.0;	/* m/s^2 */
	double rocket_altitude=0.0;	/* m */

	double deltav,twr;
	double total_mass,empty_mass;

	double time=0.0;		/* s */

	int stage=1;

	char input;

	total_mass=engine_mass+tank_mass+fuel_mass+capsule_mass;
	empty_mass=total_mass-fuel_mass;

	deltav=engine_isp*gravity*log(total_mass/empty_mass);

	twr=engine_thrust/(total_mass*gravity);

	fuel_flow_rate=(engine_thrust)/(engine_isp*gravity);

	printf("DeltaV=%lf m/s\n",deltav);
	printf("Thrust/weight=%lf\n",twr);
	printf("Fuel flow rate=%lf, time=%lfs\n",
		fuel_flow_rate,fuel_mass/fuel_flow_rate);

	while(1) {
		if (fuel_mass<0.1) {
			fuel_mass=0.0;
			rocket_acceleration=-gravity;
			rocket_velocity=rocket_velocity+rocket_acceleration*1.0;
			rocket_altitude=rocket_altitude+
				(rocket_velocity*1.0)+
				0.5*rocket_acceleration+1.0*1.0;
			if (rocket_altitude<0.0) {
				printf("CRASH!\n");
				break;
			}
		}
		else {
			rocket_acceleration=(engine_thrust/total_mass)-gravity;
			rocket_velocity=rocket_velocity+rocket_acceleration*1.0;
			rocket_altitude=rocket_altitude+
				(rocket_velocity*1.0)+
				0.5*rocket_acceleration+1.0*1.0;
			fuel_mass=fuel_mass-fuel_flow_rate;
			total_mass=engine_mass+tank_mass+fuel_mass+capsule_mass;
		}

		home();

		htabvtab(1,21);

		printf("Time: %lf\n",time);
		printf("ALT: %lf m\n",rocket_altitude);
		printf("VEL: %lf m/s\tStage: %d\n",rocket_velocity,stage);
		printf("ACCEL: %lf g\tFuel: %lf%%\n",
			rocket_acceleration/gravity,
			fuel_mass*100.0/total_fuel);

		htabvtab(30,21);
		printf("ZURGTROYD");

		htabvtab(30,20);
		if ((angle>90) && (angle<270)) printf("SCREAM");
		else if (rocket_velocity>100) printf("SMILE");
		else if (rocket_acceleration<0) printf("FROWN");
		else printf("NEUTRAL");



		scanf("%c",&input);

		time+=1.0;
	}

	return 0;
}

/* Notes */

/* Once altitude above 100m stop drawing ground */
/* Once above 20k no more drag? */
/* Once above 2100m/s sideways, orbit? */
/* Once above 40k draw stars? */
/* Kerbal neutral 0-1G, smiles 1-2G, frowns > 2G or -velocity? */
