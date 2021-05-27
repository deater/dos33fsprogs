
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#include "gr-sim.h"
#include "tfv_zp.h"

#define XSIZE	40
#define YSIZE	48

static unsigned int frame=0;

static float c_w=XSIZE,c_h=YSIZE;
static float v_w=1.0,v_h=1.0,dd=1.0;

struct vector {
	float x,y,z;
} d;

static int canvas_to_viewport(int xx, int yy, struct vector *d) {

	d->x=xx*v_w/c_w;
	d->y=yy*v_h/c_h;
	d->z=dd;

	return 0;
}

#define NUM_SPHERES	3

struct sphere_type {
	struct vector center;
	float radius;
	int color;
} spheres[NUM_SPHERES] = {
{
	.center.x=0,
	.center.y=-1,
	.center.z=3,
	.radius=1,
	.color=1,
},
{
	.center.x=2,
	.center.y=0,
	.center.z=4,
	.radius=1,
	.color=2,
},
{
	.center.x=-2,
	.center.y=0,
	.center.z=4,
	.radius=1,
	.color=4,
}
};

float dot(struct vector *a, struct vector *b) {

	return a->x*b->x + a->y*b->y + a->z*b->z;

}

static int intersect_ray_sphere(
	struct vector *o, struct vector *d, int s,
	float *t1, float *t2) {

	float r=spheres[s].radius;
	struct vector c0;
	float a,b,c;
	float discriminant;

	c0.x=o->x-spheres[s].center.x;
	c0.y=o->y-spheres[s].center.y;
	c0.z=o->z-spheres[s].center.z;

	a=dot(d,d);
	b=2*dot(&c0,d);
	c=dot(&c0,&c0)-r*r;

	discriminant=b*b-4*a*c;
	if (discriminant<0) {
		*t1=INFINITY;
		*t2=INFINITY;
	}

	*t1=(-b+sqrt(discriminant))/(2*a);
	*t2=(-b-sqrt(discriminant))/(2*a);

	return 0;
}

static int trace_ray(struct vector *o, struct vector *d, int t_min, int t_max) {

	float closest_t=INFINITY;
	int closest_sphere=-1;
	int s;
	float t1,t2;

	for(s=0;s<NUM_SPHERES;s++) {
		intersect_ray_sphere(o,d,s,&t1,&t2);
		if ((t1>t_min) && (t1<t_max) && (t1<closest_t)) {
			closest_t=t1;
			closest_sphere=s;
		}
		if ((t2>t_min) && (t2<t_max) && (t2<closest_t)) {
			closest_t=t2;
			closest_sphere=s;
		}

	}

	if (closest_sphere==-1) {
		return 15;
	}
	return spheres[closest_sphere].color;
}

int main(int argc, char **argv) {

	int ch;
	int xx,yy,color;
	struct vector d,o;

	o.x=0;
	o.y=0;
	o.z=0;


	grsim_init();

	gr();

	clear_screens();

	ram[DRAW_PAGE]=0;

	frame=0;

	for(xx=-c_w/2;xx<c_w/2;xx++) {
		for(yy=-c_h/2;yy<c_h/2;yy++) {
			canvas_to_viewport(xx,yy,&d);
			color=trace_ray(&o,&d,1,100000);
			color_equals(color);
			plot((c_w/2)+xx,47-((c_h/2)+yy));
		}
	}

	grsim_update();

	while(1) {

		usleep(60000);

		ch=grsim_input();
		if (ch=='q') return 0;
		if (ch==27) return 0;
	}

	return 0;
}
