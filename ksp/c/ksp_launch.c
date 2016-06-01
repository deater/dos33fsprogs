#include <stdio.h>
#include <math.h>

/* http://wiki.kerbalspaceprogram.com/wiki/Tutorial:Advanced_Rocket_Design */

/* Also, high school physics (thanks Mr. Brennen) */

#define PI 3.14159265358979323846264338327

#if 0
static double sin_degrees(double degrees) {

	return sin(degrees*PI/180);
}

static double cos_degrees(double degrees) {
	return cos(degrees*PI/180);
}
#endif


static double vector_magnitude(double a,double b) {
	return sqrt(a*a+b*b);
}

static void home(void) {
	printf("%c[2J%c[1;1H",27,27);
}

static void htabvtab(int x,int y) {
	printf("%c[%d;%dH",27,y,x);
}

#define KERBIN_RADIUS	600000.0

#if 0
int autopilot(double fuel_left, double altitude, double *angle) {

	if (fuel_left>25.0) {
		*angle=45.0;
		return 1;
	}

	if (altitude>KERBIN_RADIUS+40000) {
		*angle=100.0; /* actually want tanegent to surface */
		return 1;
	}

	return 0;

}
#endif

static void draw_ship(int stage, int thrusting, int rotation) {

	if (stage) {
		if (rotation==0) {
			printf("\033[1;40;37m"
				"\033[7;40H_"
				"\033[8;39H/O\\"
				"\033[9;38H/___\\"
				"\033[10;38H| R |"
				"\033[11;38H|___|"
				"\033[12;39H/_\\");
			if (thrusting) printf("\033[13;39H\\|/");
		}
		if (rotation==16) {
			printf("\033[1;40;37m");
			if (thrusting) {
				printf(
					"\033[8;35H_ ____  _"
					"\033[9;34H- |    |- |-"
					"\033[10;33H|O |R   |  |--"
					"\033[11;34H-_|____|-_|-"
				);
			}
		}
		if (rotation==32) {
			if (thrusting) printf("\033[7;39H/|\\");
			printf(
				"\033[1;40;37m"
				"\033[8;39H\\-/"
				"\033[9;38H|   |"
				"\033[10;38H| R |"
				"\033[11;38H\\---/"
				"\033[12;39H\\O/"
				"\033[7;40H_"
				);


		}
		if (rotation==48) {
			printf("\033[1;40;37m");
			if (thrusting) {
				printf(
					"\033[8;35H_ ____  _"
					"\033[9;34H- |    |- |-"
					"\033[10;33H|O |R   |  |--"
					"\033[11;34H-_|____|-_|-"
				);
			}
			else {
				printf(
					"\033[8;35H_ ____  _"
					"\033[9;34H- |    |- |"
					"\033[10;33H|O |R   |  |"
					"\033[11;34H-_|____|-_|"
				);
			}
		}

		if (rotation==56) {
			printf("\033[1;40;37m");
			printf(
				"\033[7;37H_"
				"\033[8;36H/o/\\"
				"\033[9;36H|/R \\"
				"\033[10;37H\\   \\"
				"\033[11;38H\\  /_"
				"\033[12;39H\\/|/\\"
				"\033[13;41H--"
				);

		}

	}

#if 0
      40,10=middle, so want 40,7
_______________
       _       |
      /O\      |
     /___\     |
     | R |     |
     |___|     |
      /_\      |
      \|/      |
---------------|
_______________
               |
   _ ____  _   |
  - |    |- |- |
 |O |R   |  |--|
  -_|____|-_|- |
               |
               |
---------------|
_______________
               |
   _ ____  _   |
  - |    |- |- |
 |O |R   |  |--|
  -_|____|-_|- |
               |
               |
---------------|
_______________
     _         |
    /o/\       |
    |/R \      |
     \   \     |
      \  /_    |
       \/|/\   |
          --   |
---------------|


#endif
#if 0
	htabvtab(20,9);
	if (angle<0.392) printf("^");
	else if (angle<1.178) printf("/");
	else if (angle<1.963) printf(">");
	else if (angle<2.748) printf("\\");
	else if (angle<3.534) printf("V");
	else if (angle<4.320) printf("/");
	else if (angle<5.105) printf("<");
	else if (angle<5.890) printf("\\");
	else printf("^");
#endif
}


int main(int argc, char **argv) {

	FILE *logfile,*vlogfile;

	double angle=0;

	double capsule_mass=1.0;

	int rotation=0;

//	double engines=3;
	double engine_isp=270.0;	/* s */
//	double engine_mass=(1.5)*engines;		/* tons */
//	double engine_thrust=(168.0)*engines;	/* kN */
//	double fuel_flow_rate;

//	double tanks=6;
//	double tank_mass=(0.5)*tanks;		/* tons */
//	double fuel_mass=(4.0)*tanks;		/* tons */
//	double total_fuel=fuel_mass;
	double fuel_left=100.0;

	double gravity=-9.8;		/* m/s^2 */
	double gravity_x=0.0;
	double gravity_y=-9.8;
	double gravity_angle=0.0;
	/* Kerbin radius = 600km */


	double rocket_velocity=0.0;
	double rocket_velocity_x=0.0;	/* m/s */
	double rocket_velocity_y=0.0;	/* m/s */

	double rocket_acceleration_x=0.0;	/* m/s^2 */
	double rocket_acceleration_y=0.0;	/* m/s^2 */

	double rocket_x=0;
	double rocket_y=KERBIN_RADIUS+10;
	double rocket_altitude=KERBIN_RADIUS;	/* m */


	double v0_x,v0_y;

	double time=0.0;		/* s */
	double deltat=1.0;

	int bingo_fuel=0;
	double max_altitude=0.0;
	double height=0.0;

	/* atmospheric pressure */
	double pressure=101325;		/* Pascals */
	double pressure0=101325;
	double density=0;	/* kg/m^3 */
	double temperature=273;	/* K */
	double drag=0.0,drag_a=0.0;

	int orbit_map_view=0,current_quadrant=0;

	int parachutes_deployed=0;
	int parachutes=3;
	double terminal_velocity=0.0;
	double adjusted_altitude;

	int launched=1;
	int landed=0;
	int stage=2;

	int log_step=0;

	char input;

	int thrusting=1,i,j;

	int stages=3;
	int engines[3],stacks[3],tanks[3];
	double stage_empty_mass[3],stage_full_mass[3],total_mass[3],thrust[3];
	double fuel_mass[3],stage_fuel_total[3];
	double deltav[3],twr[3],fuel_flow[3];


	logfile=fopen("log.jgr","w");
	vlogfile=fopen("vlog.jgr","w");

	engines[0]=1; stacks[0]=1; tanks[0]=1;
	engines[1]=2; stacks[1]=2; tanks[1]=1;
	engines[2]=3; stacks[2]=3; tanks[2]=1;

	/* 1000 */
	for(i=0;i<stages;i++) {
		stage_empty_mass[i]=(engines[i]*1.5)+(stacks[i]*tanks[i]*0.5);
		if (i==0) stage_empty_mass[i]+=capsule_mass;/* tons */
		fuel_mass[i]=(stacks[i]*tanks[i]*4.0);
		stage_fuel_total[i]=fuel_mass[i];
		stage_full_mass[i]=stage_empty_mass[i]+fuel_mass[i];

		/* 1020 */
		total_mass[i]=0.0;
		for(j=i;j>=0;j--) {
			total_mass[i]+=stage_full_mass[j];
		}
		thrust[i]=engines[i]*168.0;	/* kN */
		deltav[i]=engine_isp*-gravity*log(total_mass[i]/(total_mass[i]-fuel_mass[i]));
		twr[i]=thrust[i]/(total_mass[i]*-gravity);
		fuel_flow[i]=(thrust[i])/(engine_isp*-gravity);
		printf("Stage %d\n",i+1);
		printf("\ttanks=%d engines=%d\n",stacks[i]*tanks[i],engines[i]);
		printf("\tstage mass=%lf total_mass=%lf\n",stage_full_mass[i],
			total_mass[i]);
		printf("\tdeltaV=%lf\n",deltav[i]);
		printf("\tTWR=%lf\n",twr[i]);

	}

//	printf("Fuel flow rate=%lf, time=%lfs\n",
//		fuel_flow_rate,fuel_mass/fuel_flow_rate);

	scanf("%c",&input);

	/* Initialize variables */

	/* 3000 */
	angle=0.0;
	rotation=0;
	gravity_x=0.0;
	gravity_y=-9.8;
	gravity_angle=0.0;
	rocket_velocity=0.0;
	rocket_velocity_x=0.0;
	rocket_velocity_y=0.0;
	rocket_acceleration_x=0.0;
	rocket_acceleration_y=0.0;

	/* 3016 */
	rocket_x=0.0;
	rocket_y=KERBIN_RADIUS+10.0;
	rocket_altitude=KERBIN_RADIUS+10.0;
	thrusting=0;
	time=0.0;
	bingo_fuel=0.0;
	max_altitude=0.0;
	parachutes_deployed=0;
	launched=0;
	current_quadrant=0;
	orbit_map_view=0;

	/* 3020 */
	home();
	/* init_graphics() */
	height=0;
	/* draw_launchpad() */
	/* draw_horizon() */
	/* draw_gantry() */
	draw_ship(stage,thrusting,rotation);

	/* Main Loop */
	/* 4000 */
	while(1) {

		/* 4002 */
		if (!launched) goto after_physics;

		/* 4003 */
		adjusted_altitude=rocket_altitude-KERBIN_RADIUS;
		if (adjusted_altitude>max_altitude) max_altitude=adjusted_altitude;

		/* 4004 */
		if (!orbit_map_view) {
			/* draw horizon if necessary */
			if (adjusted_altitude<1800) {
				/* draw_horizon() */
			}
			/* 4012 */
			/* check to see if need to change mode */
			if ((adjusted_altitude<40000) && (current_quadrant!=0)) {
				/* switch_to_surface() */
			}
			if ((adjusted_altitude>40000) && (current_quadrant!=1)) {
				/* switch_to_orbit() */
			}
		}

		/* 4018 */
		fuel_left=fuel_mass[stage]*100.0/stage_fuel_total[stage];

		/* 4020 */
		if (thrusting) {
			if (fuel_mass[stage]<0.1) {
				fuel_mass[stage]=0.0;
				bingo_fuel=1;
				rocket_acceleration_x=0;
				rocket_acceleration_y=0;

			}
			else {
				rocket_acceleration_x=(thrust[stage]/total_mass[stage])*sin(angle);
				rocket_acceleration_y=(thrust[stage]/total_mass[stage])*cos(angle);

				fuel_mass[stage]=fuel_mass[stage]-fuel_flow[stage];
				total_mass[stage]=total_mass[stage]-fuel_flow[stage];
			}
		}
		else {
			rocket_acceleration_x=0.0;
			rocket_acceleration_y=0.0;
		}

		/* 4060 */
		gravity_angle=atan(rocket_x/rocket_y);
		/* 4065 */
		if (rocket_y<0) gravity_angle+=PI;

		/* 4070 */
		gravity_y=cos(gravity_angle)*gravity;
		gravity_x=sin(gravity_angle)*gravity;

/* TODO */
		/* Adjust pressure */
		pressure=pressure0*exp(-(rocket_altitude-KERBIN_RADIUS)/5600);
		density=pressure/(287*temperature);
		/* 0.5*rho*v^2*d*A */
		/* d=coefficient of drag, A=surface area */
		/* d=1.05 for cube (wikipedia) */
		/* d=0.8 for long cylinder */
		/* d=0.5 for long cone */
		if (parachutes_deployed) {
			drag=0.5*density*rocket_velocity_y*rocket_velocity_y*1.5*1000.0*parachutes;
			/* sqrt ((2*m*g)/(rho*A*C)) */
			terminal_velocity=sqrt( (2*total_mass[stage]*1000.0*-gravity)/(density*(4+500.0*parachutes)*1.5));
		}
		else {
			drag=0.5*density*rocket_velocity_y*rocket_velocity_y*0.5*4.0;
			terminal_velocity=sqrt( (2*total_mass[stage]*1000.0*-gravity)/(density*4.0*0.5));
		}
		drag_a=drag/(total_mass[stage]*1000.0);
		if (rocket_velocity_y>0) drag_a=-drag_a;



		/* calculate velocity */
		v0_x=rocket_velocity_x;
		v0_y=rocket_velocity_y;


		/* If above atmosphere, no drag */
		if (rocket_altitude>KERBIN_RADIUS+70000) {
			/* v=v0+at */
			rocket_acceleration_y+=gravity_y;
			rocket_acceleration_x+=gravity_x;

			rocket_velocity_y=v0_y+rocket_acceleration_y*deltat;
			rocket_velocity_x=v0_x+rocket_acceleration_x*deltat;

		}
		/* In atmosphere and traveling upward or rocket firing */
		else if ((rocket_velocity_y>=0.0) || (rocket_acceleration_x>0) ||
			(rocket_acceleration_y>0)) {
			rocket_acceleration_y+=gravity_y;
			rocket_acceleration_x+=gravity_x;
			rocket_acceleration_y+=drag_a;

			/* v=v0+at */
			rocket_velocity_y=v0_y+rocket_acceleration_y*deltat;
			rocket_velocity_x=v0_x+rocket_acceleration_x*deltat;

		}
//		else if (!launched) {
//			rocket_velocity_y=0;
//			rocket_velocity_x=0;
//			rocket_velocity=vector_magnitude(rocket_velocity_x,rocket_velocity_y);
//		}
		else {
			rocket_velocity_y=-terminal_velocity;
			rocket_velocity_x=0;
		}
		rocket_velocity=vector_magnitude(rocket_velocity_x,rocket_velocity_y);

		/* 5012 */
		/* deltaX=1/2 (v+v0)t */
		/* could also use deltax=v0t+(1/2)*a*t*t */
		rocket_y=rocket_y+0.5*(v0_y+rocket_velocity_y)*deltat;
		rocket_x=rocket_x+0.5*(v0_x+rocket_velocity_x)*deltat;

		rocket_altitude=vector_magnitude(rocket_x,rocket_y);

		/* 5020 */

		if (rocket_altitude<KERBIN_RADIUS) {
			if (rocket_velocity<20.0) {
				landed=1;
				parachutes_deployed=0;
				rocket_velocity_x=0;
				rocket_velocity_y=0;
				printf("LANDED!\n");
			}
			else {
				printf("CRASHED!\n");
				/* show_crash() */
				break;
			}
		}

		/* 5030 */
		/* Adjust gravity */
		gravity=-9.8/(
			((rocket_altitude)/KERBIN_RADIUS)*
			((rocket_altitude)/KERBIN_RADIUS));

after_physics:

//		home();
		/* 5032 */
		htabvtab(1,21);

		printf("Time: %lfs\tStage: %d\t\t%s\n",time,3-stage,"Zurgtroyd");
		printf("ALT: %lf km\tAngle=%lf\n",(rocket_altitude-KERBIN_RADIUS)/1000.0,
				angle*(180.0/PI));
		printf("VEL: %lf m/s\tFuel: %lf%%\n",
			rocket_velocity,
			fuel_left);

#if 0
/* DEBUG */
		htabvtab(20,14);
		printf("pressure=%lf density=%lf drag=%lf drag_a=%lf tv=%lf\n",
			pressure,density,drag,drag_a,terminal_velocity);

		htabvtab(20,13);
		printf("grav angle=%lf\n",gravity_angle*180.0/PI);

		htabvtab(20,12);
		printf("x=%lf y=%lf\n",rocket_x,rocket_y);

		htabvtab(20,11);
		printf("vx=%lf vy=%lf ax=%lf ay=%lf\n",
			rocket_velocity_x,rocket_velocity_y,
			rocket_acceleration_x,rocket_acceleration_y);
		htabvtab(20,10);
		printf("angle=%lf\n",(angle*180)/PI);
/* end DEBUG */
#endif

		/* 5100 */
		if (bingo_fuel) {
			input='x';
		}
		else {
			scanf("%c",&input);
		}

		/* 5555 */
		/* if (!orbit_map_view) erase_old_ship() */

		/* 6060 */
		if (input=='q') {
			break;
		}
		if (input=='a') {
			rotation-=8;
			angle-=0.7853;
		}
		if (input=='d') {
			rotation+=8;
			angle+=0.7853;
		}
		/* 6063 */
		if (input=='c') {
			/* crash_ship() */
		}

		/* 6064 */
		if (input=='z') {
			/* no thrusting while fast-forwarding */
			if (deltat<1.5) thrusting=1;
		}
		if (input=='x') {
			thrusting=0;
			bingo_fuel=0;
		}

		if (input=='>') {
			/* no fast-forwarding while thrusting */
			if (!thrusting) deltat+=1.0;
		}
		if (input=='<') {
			deltat-=1.0;
			if (deltat<1.0) deltat=1.0;
		}

		if (input=='M') {
			if (orbit_map_view) {
				orbit_map_view=0;
				current_quadrant=-1;
				continue;
			}
			else {
				orbit_map_view=1;
				/* load_orbit_map() */
				/* skip drawing rocket */
			}
		}


		if (input==' ') {
			if (launched) {
				stage--;
				if ((stage<1) && (parachutes>0) && (!parachutes_deployed)) {
					parachutes_deployed=1;
					/* draw_parachutes() */
				}
				if (stage<0) stage=0;

			}
			else {
				/* 7500 */
				/* erase_gantry() */
				/* noise() */
				thrusting=1;
				launched=1;
				/* make_astronaut_smile() */
			}
		}

		/* 6075 */
		if (angle<0.0) angle+=2*PI;
		if (angle>=2*PI) angle=0.0;
		if (rotation==64) rotation=0;
		if (rotation==-8) rotation=56;

		if (!orbit_map_view) {
			htabvtab(30,19);
			if ((angle>90) && (angle<270)) printf("SCREAM");
			else if (rocket_velocity_y>100) printf("SMILE");
			else if (rocket_acceleration_y<0) printf("FROWN");
			else printf("NEUTRAL");
		}

		/* 6090 */
		/* re-draw ship */
		draw_ship(stage,thrusting,rotation);

		/* 6118 */
		time+=deltat;
		/* adjust_eyes() */

//		if (log_step==0) {
		if (0==0) {
			if (logfile) {
				fprintf(logfile,"%lf %lf\n",rocket_x/1000.0,rocket_y/1000.0);
			}
			if (vlogfile) {
				fprintf(vlogfile,
			"time=%.0lf altitude=%.0lf vel_y=%lf grav_y=%lf drag_a=%lf rock_ay=%lf\n",
			time,rocket_altitude-KERBIN_RADIUS,rocket_velocity_y,
			gravity_y,drag_a,rocket_acceleration_y);
				fprintf(vlogfile,
			"\tdensity=%lf vel_y^2=%lf drag=%lf\n",
			density,rocket_velocity_y*rocket_velocity_y,drag);
			}
		}
		log_step++;
		if (log_step>10) {
			log_step=0;
		}
	}

	if (logfile) fclose(logfile);
	if (vlogfile) fclose(vlogfile);

	(void)height;
	(void)max_altitude;
	(void)bingo_fuel;
	(void)current_quadrant;

	return 0;
}

/* Notes */

/* Once altitude above 100m stop drawing ground */
/* Once above 20k no more drag? */
/* Once above 2100m/s sideways, orbit? */
/* Once above 40k draw stars? */
/* Kerbal neutral 0-1G, smiles 1-2G, frowns > 2G or -velocity? */
