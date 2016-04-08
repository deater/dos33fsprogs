#include <stdio.h>
#include <math.h>

/* http://wiki.kerbalspaceprogram.com/wiki/Tutorial:Advanced_Rocket_Design */

/* Also, high school physics (thanks Mr. Brennen) */


/* TODO: want 2d-vectors at least */

int main(int argc, char **argv) {

	double capsule_mass=1.0;

	double engine_isp=270.0;	/* s */
	double engine_mass=1.5;		/* tons */
	double engine_thrust=168.0;	/* kN */
	double fuel_flow_rate;

	double tank_mass=0.5;		/* tons */
	double fuel_mass=4.0;		/* tons */

	double gravity=9.8;		/* m/s^2 */

	double rocket_velocity=0.0;	/* m/s */
	double rocket_acceleration=0.0;	/* m/s^2 */
	double rocket_altitude=0.0;	/* m */

	double deltav,twr;
	double total_mass,empty_mass;

	double time=0.0;		/* s */

	total_mass=engine_mass+tank_mass+fuel_mass+capsule_mass;
	empty_mass=total_mass-fuel_mass;

	deltav=engine_isp*gravity*log(total_mass/empty_mass);

	twr=engine_thrust/(total_mass*gravity);

	fuel_flow_rate=(engine_thrust)/(engine_isp*gravity);

	printf("DeltaV=%lf m/s\n",deltav);
	printf("Thrust/weight=%lf\n",twr);
	printf("Fuel flow rate=%lf, time=%lfs\n",
		fuel_flow_rate,fuel_mass/fuel_flow_rate);

	for(time=0.0;time<500.0;time++) {
		printf("Time: %lf\n",time);
		printf("\tFuel left: %lf\n",fuel_mass);
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
		printf("\tRocket acceleration: %lf g\n",rocket_acceleration/gravity);
		printf("\tRocket velocity: %lf m/s\n",rocket_velocity);
		printf("\tRocket altitude: %lf m\n",rocket_altitude);
	}

	return 0;
}

/* Notes */

/* Once altitude above 100m stop drawing ground */
/* Once above 20k no more drag? */
/* Once above 2100m/s sideways, orbit? */
/* Once above 40k draw stars? */
/* Kerbal neutral 0-1G, smiles 1-2G, frowns > 2G or -velocity? */
