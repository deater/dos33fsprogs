#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>

#include <SDL/SDL.h>
#include <GL/gl.h>
#include <GL/glu.h>

#define TFV_PINK_TEXTURE		62
#define TOTAL_TEXTURES 63

    /* As much as I have memorized... */
#define PI 3.141592653589793238462643383279502884197169399

#define D2R(x) ((x*PI*2.0)/360.0)

static GLuint textures[TOTAL_TEXTURES];

#define UP_PRESSED           1
#define DOWN_PRESSED         2
#define LEFT_PRESSED         4
#define RIGHT_PRESSED        8
#define ACTION1_PRESSED     16
#define ACTION2_PRESSED     32
#define CONFIRM_PRESSED     64
#define CANCEL_PRESSED     128
#define PAN_LEFT_PRESSED   256
#define PAN_RIGHT_PRESSED  512
#define PAUSE_PRESSED     1024
#define MENU_PRESSED      2048


/* MODEL ->  We pretend we essentially have essentially 10 buttons */
/* Right now this reflects the Gravis-Gamepad I have.  Eventually */
/* I will add some sort of generic config utility for custom controls */

/* UP, DOWN, LEFT, RIGHT */
/* 1 (A or ACTION1)
 * 2 (Z or ACTION2)
 * 3 (ENTER or CONFIRM)
 * 4 (SPACE or CANCEL)
 * 5 (J or PAN_LEFT)
 * 6 (K or PAN_RIGHT)
 * 9 (P or PAUSE)
 *10 (ESCAPE or MENU)
*/


int check_keyboard(char *alphanum,int reset) {
   
    SDL_Event event;
   
    static int keys_down=0;
    int momentary=0;
    int button,axis,jdirection;
   
    int keypressed;

    *alphanum=0;
   
    if (reset) {
       keys_down=0;
       return 1;
    }
        
    while ( SDL_PollEvent(&event) ) {
       
       if ( event.type == SDL_QUIT ) {
          keys_down|=MENU_PRESSED;
	  return 1;
       }

       if (event.type == SDL_VIDEORESIZE) {
	  printf("RESIZE\b");	  
       }
       
       if (event.type == SDL_JOYBUTTONDOWN) {
	  button=event.jbutton.button;
	  switch(button) {
	     case 0: momentary|=ACTION1_PRESSED;
	             keys_down|=ACTION1_PRESSED;
	             break;
	     case 1: momentary|=ACTION2_PRESSED;
	             keys_down|=ACTION2_PRESSED;
	             break;
	     case 2: momentary|=CONFIRM_PRESSED;
	             keys_down|=CONFIRM_PRESSED;
	             break;
	     case 3: momentary|=CANCEL_PRESSED;
	             keys_down|=CANCEL_PRESSED;
	             break;
	     case 4: momentary|=PAN_LEFT_PRESSED;
	             keys_down|=PAN_LEFT_PRESSED;
	             break;
	     case 5: momentary|=PAN_RIGHT_PRESSED;
	             keys_down|=PAN_RIGHT_PRESSED;
	             break;
	     case 8: momentary|=PAUSE_PRESSED;
	             keys_down|=PAUSE_PRESSED;
	             break;
	     case 9: momentary|=MENU_PRESSED;
	             keys_down|=MENU_PRESSED;
	             break;
	  }
	  //printf("Button: %i\n",button);
       }
       
       if (event.type == SDL_JOYAXISMOTION) {
	  axis=event.jaxis.axis;
	  jdirection=event.jaxis.value;
	  if (axis==0) {  /* X */
	     if (jdirection>20000) {
		keys_down|=RIGHT_PRESSED;
	     }
	     else if (jdirection<-20000) {
		keys_down|=LEFT_PRESSED;
	     }	     
	     else if ((jdirection>5000) || (jdirection<-5000)) {
		keys_down&=(~RIGHT_PRESSED);
		keys_down&=(~LEFT_PRESSED);
//			     printf("X: %i\n",jdirection);
	     }

	  }
	  if (axis==1) {  /* Y */
	     if (jdirection>20000) {
		keys_down|=DOWN_PRESSED;
	     }
	     else if (jdirection<-20000) {
		keys_down|=UP_PRESSED;
	     }
	     else if ((jdirection>5000) || (jdirection<-5000)) {
		keys_down&=(~UP_PRESSED);
		keys_down&=(~DOWN_PRESSED);
//			     printf("Y: %i\n",jdirection);
	     }
	     
	     
//	     printf("Y: %i\n",jdirection);
	  }
	  
       }
       
       
       if (event.type == SDL_JOYBUTTONUP) {
	  button=event.jbutton.button;
	  switch(button) {
	     case 0: keys_down&=(~ACTION1_PRESSED);
	             break;
	     case 1: keys_down&=(~ACTION2_PRESSED);
	             break;
	     case 2: keys_down&=(~CONFIRM_PRESSED);
	             break;
	     case 3: keys_down&=(~CANCEL_PRESSED);
	             break;
	     case 4: keys_down&=(~PAN_LEFT_PRESSED);
	             break;
	     case 5: keys_down&=(~PAN_RIGHT_PRESSED);
	             break;
	     case 8: keys_down&=(~PAUSE_PRESSED);
	             break;
	    case  9: keys_down&=(~MENU_PRESSED);
	             break;
	  }
	  //printf("Button: %i\n",button);
       }
       
       if (event.type == SDL_KEYUP) {
	  keypressed=event.key.keysym.sym;
	  
	  switch(keypressed) {
              case SDLK_UP: keys_down&=(~UP_PRESSED);	 
	                    break;
	      case SDLK_DOWN: keys_down&=(~DOWN_PRESSED);
	                    break;
	      case SDLK_RIGHT: keys_down&=(~RIGHT_PRESSED);
	                    break;
	     case SDLK_LEFT: keys_down&=(~LEFT_PRESSED);
	                    break;
	     case SDLK_ESCAPE: keys_down&=(~MENU_PRESSED); 
	                    break;
	     case SDLK_RETURN:  keys_down&=(~CONFIRM_PRESSED);
	      		    break;
	     case SDLK_SPACE: keys_down&=(~CANCEL_PRESSED);
	                    break;
	     
	   case 'a': case 'A': keys_down&=(~ACTION1_PRESSED); break;
	   case 'z': case 'Z': keys_down&=(~ACTION2_PRESSED); break;
	   case 'j': case 'J': keys_down&=(~PAN_LEFT_PRESSED); break;
	   case 'k': case 'K': keys_down&=(~PAN_RIGHT_PRESSED); break;
	   case 'p': case 'P': keys_down&=(~PAUSE_PRESSED); break;
	  }
       }
       
       if ( event.type == SDL_KEYDOWN ) {
	  keypressed=event.key.keysym.sym;
	   
	  switch (keypressed) {
	      
	   case 'a': case 'A':
	                     momentary|=ACTION1_PRESSED;
	                     keys_down|=ACTION1_PRESSED;
	                     break;
	     
	   case 'z': case 'Z':
	                     momentary|=ACTION2_PRESSED;
	                     keys_down|=ACTION2_PRESSED;
	                     break;  
	     
	   case SDLK_RETURN: momentary|=CONFIRM_PRESSED;
	                     keys_down|=CONFIRM_PRESSED;
	                     break;
	   case SDLK_SPACE:  momentary|=CANCEL_PRESSED;
	                     keys_down|=CANCEL_PRESSED;
	                     break;
	   case 'j': case 'J':
	                     momentary|=PAN_LEFT_PRESSED;
	                     keys_down|=PAN_LEFT_PRESSED;
	                     break;
	   case 'k': case 'K':
	                     momentary|=PAN_RIGHT_PRESSED;
	                     keys_down|=PAN_RIGHT_PRESSED;
	                     break;
	   case 'p': case 'P':
	                     momentary|=PAUSE_PRESSED;
	                     keys_down|=PAUSE_PRESSED;
	                     break;
	   case SDLK_ESCAPE: momentary|=MENU_PRESSED;
	                     keys_down|=MENU_PRESSED; 
	                     break;
	   
	   case SDLK_RIGHT:  momentary|=RIGHT_PRESSED;
                             keys_down|=RIGHT_PRESSED;	                     
                             break;
           case SDLK_LEFT:   momentary|=LEFT_PRESSED;
	                     keys_down|=LEFT_PRESSED;
                             break;
           case SDLK_UP:     
	                     momentary|=UP_PRESSED;
	                     keys_down|=UP_PRESSED;
	                     break;
	   case SDLK_DOWN:   momentary|=DOWN_PRESSED;
	                     keys_down|=DOWN_PRESSED;
                             break;
	     
	   default:  *alphanum=keypressed; break;
	  }
       }
    }
    return (momentary<<16)+keys_down;
}


static void LoadPinkTexture(int x,int y,int which_one,int transparent,
		 int repeat_type) {

	static GLubyte *texture;
	int i;

	texture=calloc(64*64*4,sizeof(GLubyte));

	for(i=0;i<64*64;i++) {
		texture[(i*4)+0]=0xff;
		texture[(i*4)+1]=0x44;
		texture[(i*4)+2]=0xfd;
		texture[(i*4)+3]=0xff;

	}

	glBindTexture(GL_TEXTURE_2D,textures[which_one]);

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, repeat_type);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, repeat_type);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, x, y,
			0,GL_RGBA,GL_UNSIGNED_BYTE,texture);

}




static void reshape(int w,int h) {
	glViewport(0,0,(GLsizei)w,(GLsizei)h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60.0,(GLfloat)w/(GLfloat)h,1.0,100.0);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	//glTranslatef(0.0,0.0,-3.6);
}


static int generate_sphere(float radius, int latitudes, int longitudes, int texture) {

	/* The way I do this is brutally inefficient */
	/* I should optimize it later [ie, do everything in radians] */
	float delta_theta,delta_phi;
	float init_x1,init_y1,init_z1,x1,y1,z1;
	float init_x2,init_y2,init_z2,x2,y2,z2;
	int phi_prime,theta_prime;

	glBindTexture(GL_TEXTURE_2D,textures[texture]);

	delta_phi=180.0/(float)latitudes;
	delta_theta=360.0/(float)longitudes;

	for(phi_prime=0;phi_prime<latitudes;phi_prime++) {
		theta_prime=0;
		glBegin(GL_QUAD_STRIP);

		init_x1=radius*sin(D2R(phi_prime*delta_phi))*cos(D2R(theta_prime*delta_theta));
		init_y1=radius*sin(D2R(phi_prime*delta_phi))*sin(D2R(theta_prime*delta_theta));
		init_z1=radius*cos(D2R(phi_prime*delta_phi));

		glNormal3f(init_x1/radius,init_y1/radius,init_z1/radius);
		glTexCoord2f( (theta_prime*delta_theta)/360.0, (phi_prime*delta_phi)/360.0);
		glVertex3f(init_x1,init_y1,init_z1);

		init_x2=radius*sin(D2R((phi_prime+1)*delta_phi))*cos(D2R(theta_prime*delta_theta));
		init_y2=radius*sin(D2R((phi_prime+1)*delta_phi))*sin(D2R(theta_prime*delta_theta));
		init_z2=radius*cos(D2R((phi_prime+1)*delta_phi));

//		printf("%.2f %.2f %.2f : %.2f %.2f %.2f\n",radius,phi_prime*delta_phi,theta_prime*delta_theta,normalx,normaly,normalz);

		glNormal3f(init_x2/radius,init_y2/radius,init_z2/radius);
		glTexCoord2f( (theta_prime*delta_theta)/360.0, ((phi_prime+1)*delta_phi)/360.0);
		glVertex3f(init_x2,init_y2,init_z2);

		for(theta_prime=1;theta_prime<longitudes;theta_prime++) {
			x1=radius*sin(D2R(phi_prime*delta_phi))*cos(D2R(theta_prime*delta_theta));
			y1=radius*sin(D2R(phi_prime*delta_phi))*sin(D2R(theta_prime*delta_theta));
			z1=radius*cos(D2R(phi_prime*delta_phi));

			glNormal3f(x1/radius,y1/radius,z1/radius);
			glTexCoord2f( (theta_prime*delta_theta)/360.0, (phi_prime*delta_phi)/360.0);
			glVertex3f(x1,y1,z1);

			x2=radius*sin(D2R((phi_prime+1)*delta_phi))*cos(D2R(theta_prime*delta_theta));
			y2=radius*sin(D2R((phi_prime+1)*delta_phi))*sin(D2R(theta_prime*delta_theta));
			z2=radius*cos(D2R((phi_prime+1)*delta_phi));

			glNormal3f(x2/radius,y2/radius,z2/radius);
			glTexCoord2f( (theta_prime*delta_theta)/360.0, ((phi_prime+1)*delta_phi)/360.0);
			glVertex3f(x2,y2,z2);
		}

		glNormal3f(init_x1/radius,init_y1/radius,init_z1/radius);
		glTexCoord2f( (theta_prime*delta_theta)/360.0, (phi_prime*delta_phi)/360.0);
		glVertex3f(init_x1,init_y1,init_z1);

		glNormal3f(init_x1/radius,init_y1/radius,init_z1/radius);
		glTexCoord2f( (theta_prime*delta_theta)/360.0, (phi_prime*delta_phi)/360.0);
		glVertex3f(init_x2,init_y2,init_z2);
		glEnd();
	}

	return 0;
}



static int draw_pink_sphere(int xsize, int ysize) {

	char key_alpha;
	int keyspressed;
	double camerax=0,cameray=10,cameraz=20,camera_direction=0;
	int rotation=0;

	GLfloat light_position[]={50.0,50.0,100.0,0.0};
	GLfloat lmodel_ambient[]={0.8,0.8,0.8,1.0};
	GLfloat white_light[]={1.0,1.0,1.0,1.0};

	printf("ENTERING DRAW PINK SPHERE\n"); fflush(stdout);

	/* Init screen and keyboard */
	reshape(xsize,ysize);
	check_keyboard(&key_alpha,1);

	printf("ABOUT TO ENTER MAIN LOOP\n"); fflush(stdout);

	while (1) {

		/* Check for input events */
		keyspressed=check_keyboard(&key_alpha,0);


		if (keyspressed&MENU_PRESSED) {
			return 0;
		}

		if (keyspressed&PAN_LEFT_PRESSED) {
			camera_direction-=(2.0*PI)/16.0;
			if (camera_direction<0.0) camera_direction+=2.0*PI;
			camerax=10.0*sin(camera_direction);
			cameray=10.0*cos(camera_direction);
			rotation--;
			if (rotation<0) rotation+=16;
			printf("ROT=%d %.2lf\n",rotation,camera_direction);

		}

		if (keyspressed&PAN_RIGHT_PRESSED) {
			camera_direction+=(2.0*PI)/16.0;
			if (camera_direction>2.0*PI) camera_direction-=2.0*PI;
			camerax=10.0*sin(camera_direction);
			cameray=10.0*cos(camera_direction);
			rotation++;
			if (rotation>15) rotation-=16;
			printf("ROT=%d %.2lf\n",rotation,camera_direction);
		}

		if (keyspressed&UP_PRESSED) {
			cameraz+=0.5;
		}

		if (keyspressed&DOWN_PRESSED) {
			cameraz-=0.5;
		}

		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		glLoadIdentity();
		gluLookAt(camerax,cameray,cameraz,
			0.0,0.0,0.0,
			0.0,0.0,1.0);

		glLightfv(GL_LIGHT0, GL_POSITION, light_position);

		glLightfv(GL_LIGHT0, GL_DIFFUSE, white_light);
		glLightfv(GL_LIGHT0, GL_SPECULAR,white_light);

		glLightModelfv(GL_LIGHT_MODEL_AMBIENT, lmodel_ambient);

		glEnable(GL_LIGHTING);
		glEnable(GL_LIGHT0);

		{
			GLfloat default_a[]={0.6,0.6,0.6,1.0};
			GLfloat default_d[]={0.8,0.8,0.8,1.0};
			GLfloat default_s[]={0.0,0.0,0.0,1.0};
			GLfloat default_e[]={0.0,0.0,0.0,1.0};

			glMaterialfv(GL_FRONT,GL_AMBIENT,default_a);
			glMaterialfv(GL_FRONT,GL_DIFFUSE,default_d);
			glMaterialfv(GL_FRONT,GL_SPECULAR,default_s);
			glMaterialfv(GL_FRONT,GL_EMISSION,default_e);
		}

		glBegin(GL_QUADS);
			glVertex3f(-5,-5,0);
			glVertex3f(5,-5,0);
			glVertex3f(5,5,0);
			glVertex3f(-5,5,0);

			glVertex3f(-5,5,0);
			glVertex3f(5,5,0);
			glVertex3f(5,5,5);
			glVertex3f(-5,5,5);

			glVertex3f(-5,-5,0);
			glVertex3f(-5,5,0);
			glVertex3f(-5,5,5);
			glVertex3f(-5,-5,5);
		glEnd();

		glEnable(GL_TEXTURE_2D);

		glPushMatrix();

		glTranslatef(0,0,6.5);
		glRotatef(90,0,1,0);

		glPushMatrix();
		glRotatef(270,0,0,1);
		generate_sphere(2,20,20,TFV_PINK_TEXTURE);
		glPopMatrix();

		glPopMatrix();

		/* Flush it out to the device */
		glFlush();
		SDL_GL_SwapBuffers();

		glDisable(GL_LIGHTING);
		glDisable(GL_TEXTURE_2D);

		/* Emulate low frame-rates */
		usleep(100000);
	}

	return 1;
}



static void LoadTextures(void) {

#define _BSD_SOURCE 1

#if (BYTE_ORDER==BIG_ENDIAN)
	printf("We are big_endian\n");
	glPixelStorei(GL_UNPACK_SWAP_BYTES,1);
#endif

	glPixelStorei(GL_UNPACK_ALIGNMENT,1);

	glGenTextures(TOTAL_TEXTURES,textures);

	LoadPinkTexture(64,64,TFV_PINK_TEXTURE,0,GL_REPEAT);

}

static void init_gl(void) {

#if (BYTE_ORDER==BIG_ENDIAN)
	glPixelStorei(GL_UNPACK_SWAP_BYTES,1);
#endif
	glPixelStorei(GL_UNPACK_ALIGNMENT,1);
	glClearColor(0.0,0.0,0.0,0.0);
	glClearDepth(1.0);
	glShadeModel(GL_SMOOTH);
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

	LoadTextures();
}


int main(int argc, char **argv) {

	int mode;
	int fullscreen=0;
	int xsize,ysize;

	xsize=640; ysize=480;

	/* Initialize SDL */
	if ( SDL_Init(SDL_INIT_VIDEO|SDL_INIT_JOYSTICK)<0) {
		printf("Error trying to init SDL: %s\n",SDL_GetError());
		return -1;
	}

	if (fullscreen) mode=SDL_OPENGL | SDL_FULLSCREEN;
	else mode=SDL_OPENGL;

	/* Create the OpenGL screen */
	if ( SDL_SetVideoMode(xsize, ysize, 0, mode) == NULL ) {
		printf("Unable to create OpenGL screen: %s\n", SDL_GetError());
		SDL_Quit();
		return -2;
	}

	SDL_WM_SetCaption("Guinea Pig Adventure...",NULL);

	/* Setup OpenGL screen */
	init_gl();

	reshape(xsize,ysize);

	draw_pink_sphere(xsize,ysize);

	/* Quit */
	SDL_Quit();

	return 0;
}
