#include <stdio.h>
#include <math.h>

static int debug=0;

static void make_coord_line(int frame,int x,int y,int destx,int desty) {

	int status, xh,xl, yh,yl;
	double theta,dx,dy;
	int dxi,dyi,dxh,dxl,dyh,dyl;
	int closestx,closesty,distance,closest;

	// status frame    x/x    y/y    dx/dx dy/dy destx desty/radius
	status=0;
	xl=0; xh=x;
	yl=0; yh=y;

	if ((destx-x)!=0) {
		theta=atan2((desty-y),(destx-x));
		dx=cos(theta);
		dy=sin(theta);
	}
	else {
		if (debug) printf("; VERTICAL\n");
		theta=0;
		dx=0;
		dy=1;
	}

	dxi=dx*256;
	dyi=dy*256;

	dxh=(dxi>>8)&0xff;
	dxl=dxi&0xff;

	dyh=(dyi>>8)&0xff;
	dyl=dyi&0xff;

	if (debug) {
		printf("; theta=%lf dx=%lf dy=%lf\n",theta,dx,dy);
		printf(";           dxh=%d dxl=%d\n",dxh,dxl);
		printf(";           dyh=%d dyl=%d\n",dyh,dyl);
	}

	{ int i,blahx,blahy;
		blahx=xh*256;
		blahy=yh*256;
		closest=1000000;
		closestx=0;
		closesty=0;

		for (i=0;i<200;i++) {
			distance=sqrt((blahx/256-destx)*(blahx/256-destx)+
					(blahy/256-desty)*(blahy/256-desty));
			if (distance<closest) {
				closestx=blahx/256;
				closesty=blahy/256;
				closest=distance;
			}

			blahx+=dxi;
			blahy+=dyi;

		}
		if (debug) printf("; Found closest at %d %d\n",closestx,closesty);


	}
	printf(".byte $%02X, %d, %d,$%02X, %d,$%02X, "
			"$%02x,$%02X, $%02x,$%02X, %d,%d\n",
			status,frame,xh,xl,yh,yl,
			dxh&0xff,dxl&0xff,
			dyh&0xff,dyl&0xff,
			closestx,closesty);

}

double func(double x,
		double x1,double x2,
		double ystart,double height) {

	double center_x,width;
	double top;

	center_x=(x1+x2)/2;
	width=fabs(x1-x2);

	top=ystart-height;

	return top+(ystart-top)*(x-center_x)*(x-center_x)/((width/2)*(width/2));

}


static void make_coord_parab(int frame,int x,int y,int destx,int height) {

	int status;
//	int closestx,closesty,distance,closest;

	int i;
	double last,last2,diff=0;
	double urgh=-3.5, zurgh=0.1,current;
	int u,z;
	int direction;

	if (x>destx) direction=-1;
	else direction=1;

	last=0,last2=0;

	if (debug) printf("; x=%d destx=%d y=%d height=%d\n",
			x,destx,y,height);
	if (debug) printf("; center_x=%d width=%d top=%d\n",
		(x+destx)/2,
		(x-destx),
		y-height);

	for(i=x;i!=destx;i+=direction) {
		current=func(i,x,destx,y,height);
		if (debug) printf("; %d %lf -- %lf %lf\n",i,current,
			current-last,last2-(current-last));
		diff=(current-last)-last2;
		last2=current-last;
		last=current;
	}

	urgh=func(x+direction,x,destx,y,height)-func(x,x,destx,y,height);
	zurgh=diff;

	u=urgh*256; z=zurgh*256;

	if (debug) printf("; $%02X $%02X, $%02X $%02X\n",(u>>8)&0xff,u&0xff,
		(z>>8)&0xff,z&0xff);

#if 0
	{ int i,blahx,blahy;
		blahx=xh*256;
		blahy=yh*256;
		closest=1000000;
		closestx=0;
		closesty=0;

		for (i=0;i<200;i++) {
			distance=sqrt((blahx/256-destx)*(blahx/256-destx)+
					(blahy/256-desty)*(blahy/256-desty));
			if (distance<closest) {
				closestx=blahx/256;
				closesty=blahy/256;
				closest=distance;
			}

			blahx+=dxi;
			blahy+=dyi;

		}
		printf("; Found closest at %d %d\n",closestx,closesty);


	}
#endif
	status=0;
	printf(".byte $%02X, %d, %d,$%02X, %d,$%02X, "
			"$%02x,$%02X, $%02x,$%02X, %d,%d\n",
			status,frame,
			x,direction&0xff,y,0x00,
			(u>>8)&0xff,u&0xff,
			(z>>8)&0xff,z&0xff,
			destx,255);

}


int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *ptr;

	int x,y;
	int type, frame;
	int destx, desty;

	while(1) {
		ptr=fgets(string,BUFSIZ,stdin);
		if (ptr==NULL) break;

		if (string[0]=='#') continue;

		sscanf(string,"%d %d %d %d %d %d",
			&type,&frame,&x,&y,&destx,&desty);

		if (type==0) {
			make_coord_line(frame,x,y,destx,desty);
		}
		else if (type==1) {
			make_coord_parab(frame,x,y,destx,desty);
		}
		else {
			fprintf(stderr,"Error, unknown type %d\n",type);
		}

	}

	printf(".byte $FE\n");

	return 0;
}


//	10,10	100,100		slope=90/90=1
//
//
//
//
//
//


