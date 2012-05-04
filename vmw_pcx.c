/* WARNING!  These functions only work at 320x200x8bpp right now */

/* It is easy to obtain the docs to make this load/save arbitrary */
/* PCX files.  However, I don't have the time nor the inclination */
/* To do it right now ;) */

/* Routines to Load/Save PCX graphics files. */

#include "svmwgraph.h"

#include <stdio.h>  /* For FILE I/O */
#include <string.h> /* For strncmp */
#include <fcntl.h>  /* for open()  */
#include <unistd.h> /* for lseek() */
#include <sys/stat.h> /* for file modes */


int vmwGetPCXInfo(char *FileName, int *xsize, int *ysize, int *type) {
    
    unsigned char pcx_header[128];
    int xmin,ymin,xmax,ymax,version=PCX_UNKNOWN,bpp,debug=1,pcx_fd;

          /* Open the file */                  
    pcx_fd=open(FileName,O_RDONLY);
    
    if (pcx_fd<0) {
       printf("ERROR!  File \"%s\" not found!\n",FileName);
       return VMW_ERROR_FILE;
    }
   
    lseek(pcx_fd,0,SEEK_SET);
    
    read(pcx_fd,&pcx_header,128);
   
    xmin=(pcx_header[5]<<8)+pcx_header[4];
    ymin=(pcx_header[7]<<8)+pcx_header[6];
   
    xmax=(pcx_header[9]<<8)+pcx_header[8];
    ymax=(pcx_header[11]<<8)+pcx_header[10];

    version=pcx_header[1];
    bpp=pcx_header[3];
   
    if (debug) {
	
       printf("Manufacturer: ");
       if (pcx_header[0]==10) printf("Zsoft\n");
       else printf("Unknown %i\n",pcx_header[0]);
   
       printf("Version: ");

       switch(version) {
        case 0: printf("2.5\n"); break;
        case 2: printf("2.8 w palette\n"); break;
        case 3: printf("2.8 w/o palette\n"); break;
        case 4: printf("Paintbrush for Windows\n"); break;
        case 5: printf("3.0+\n"); break;
        default: printf("Unknown %i\n",version);
       }
       printf("Encoding: ");
       if (pcx_header[2]==1) printf("RLE\n");
       else printf("Unknown %i\n",pcx_header[2]);
       
       printf("BitsPerPixelPerPlane: %i\n",bpp);
       printf("File goes from %i,%i to %i,%i\n",xmin,ymin,xmax,ymax);
   
       printf("Horizontal DPI: %i\n",(pcx_header[13]<<8)+pcx_header[12]);
       printf("Vertical   DPI: %i\n",(pcx_header[15]<<8)+pcx_header[14]);
       
       printf("Number of colored planes: %i\n",pcx_header[65]);
       printf("Bytes per line: %i\n",(pcx_header[67]<<8)+pcx_header[66]);
       printf("Palette Type: %i\n",(pcx_header[69]<<8)+pcx_header[68]);
       printf("Hscreen Size: %i\n",(pcx_header[71]<<8)+pcx_header[70]);
       printf("Vscreen Size: %i\n",(pcx_header[73]<<8)+pcx_header[72]);
       
    }
   
//   *xsize=(xmax-xmin+1);
//   *ysize=(ymax-ymin+1);
   *xsize=(xmax-xmin+1);
   *ysize=(ymax-ymin+1);

   if ((version==5) && (bpp==8) && (pcx_header[65]==3)) *type=PCX_24BIT;
   else if (version==5) *type=PCX_8BITPAL;
   else *type=PCX_UNKNOWN;

   close(pcx_fd);
   
   return 0;
}

int vmwLoadPCX(int x1,int y1,vmwVisual *target,
	       int LoadPal,int LoadPic,char *FileName,
	       vmwSVMWGraphState *graph_state)

{

    int pcx_fd,x,y,i,numacross,xsize,ysize,xmin,ymin;
    unsigned int r,g,b;
    int bpp,planes,bpl,xmax,ymax,version;
    unsigned char pcx_header[128];
    unsigned char temp_byte;
   
       /* Open the file */                  
    pcx_fd=open(FileName,O_RDONLY);
    
    if (pcx_fd<0) {
       printf("ERROR!  File \"%s\" not found!\n",FileName);
       return VMW_ERROR_FILE;
    }
   


    /*************** DECODE THE HEADER *************************/
    read(pcx_fd,&pcx_header,128);
   
    xmin=(pcx_header[5]<<8)+pcx_header[4];
    ymin=(pcx_header[7]<<8)+pcx_header[6];
   
    xmax=(pcx_header[9]<<8)+pcx_header[8];
    ymax=(pcx_header[11]<<8)+pcx_header[10];

    version=pcx_header[1];
    bpp=pcx_header[3];
    planes=pcx_header[65];
    bpl=(pcx_header[67]<<8)+pcx_header[66];

    xsize=((xmax-xmin)+1);
    ysize=((ymax-ymin)+1);
   
    /* Possibly add some sanity checking in the header at some point... */
    /* Or actually even get the proper VALUES from the header.  Some day... */
    
    if (LoadPic) {

       
       unsigned char *pointer=target->memory;
       
       x=0; y=0;
   
       while (x<xsize*ysize) {
          read(pcx_fd,&temp_byte,1);
          if (0xc0 == (temp_byte&0xc0)) {
	     numacross=temp_byte&0x3f;
	     read(pcx_fd,&temp_byte,1);
//	     y++;  if (y%2) temp_byte=0xff;
//	     temp_byte=0xff;
//	     printf("%i pixels of %i\n",numacross,temp_byte);
	     for(i=0;i<numacross;i++) {
		*pointer=temp_byte;
		pointer++;
		x++;
	     }

		  
	     //printf("Color=%i Across=%i\n",temp_byte,numacross);
	     //vmwDrawHLine(x,y,numacross,temp_byte,target);
	     //x+=numacross;
          }
          else {
	     //vmwPutPixel(x,y,temp_byte,target);
	     //printf("%i, %i Color=%i\n",x,y,temp_byte);

	     *pointer=temp_byte;
//	     if (temp_byte!=0) printf("COLOR=%i\n",temp_byte);
	     pointer++;
	     x++;
          }
	   /* why is this needed? */
//          if (x%xsize==0) {
//	     pointer++;
//	  }
	  
	     //printf("WARNING!  X=%i\n",x);
//	     x=0;
//	     y++;
  //        }
       }
    }
   
       /*Load Palette*/
    if (LoadPal) {
    
       lseek(pcx_fd,-769,SEEK_END);
   
       read(pcx_fd,&temp_byte,1);
       if (temp_byte!=12) {
	  printf("Error!  No palette found!\n");
       }
       else
	    
       for(i=0;i<255;i++) { 
          read(pcx_fd,&temp_byte,1);
	  r=temp_byte;
	  read(pcx_fd,&temp_byte,1);
	  g=temp_byte;
	  read(pcx_fd,&temp_byte,1);
	  b=temp_byte;
	  vmwLoadPalette(graph_state,
			 r,
			 g,
			 b,i);
	 // printf("%i: 0x%x %x %x\n",i,r,g,b);
       }
       vmwFlushPalette(graph_state);
    }
   
    close(pcx_fd);
    return 0;
}

int vmwSavePCX(int x1,int y1,int xsize,int ysize,
	       vmwVisual *source,
	       int num_colors,
	       vmw24BitPal *palette,
	       char *FileName) {
   
   
    int pcx_fd,x,y,oldcolor,color,numacross,i;
    unsigned char *pcx_header;
    unsigned char temp_byte;
   
       
    pcx_fd=open(FileName,O_WRONLY|O_CREAT|O_TRUNC,S_IRUSR|S_IWUSR);
    if (pcx_fd<0) {
       printf("Error opening \"%s\" for writing!\n",FileName);
       return VMW_ERROR_FILE;
    }
   
    pcx_header=calloc(1,128);
       /* Faked from a proper 320x200x256 pcx created with TheGIMP */
       /* and read with 'od -t x1 -N 128' */
       /* Values verified from PCGPE .pcx documentation */
    pcx_header[0]=0x0a;  /* Manufacturer ID-- A=ZSoft .pcx */
    pcx_header[1]=0x05;  /* Version # */
    pcx_header[2]=0x01;  /* Encoding.  1=RLE */
    pcx_header[3]=0x08;  /* Bits Per Pixel */
    pcx_header[8]=0x3f;  /* 4-11 Window.  XminXmin YminYmin XmaxXmax YmaxYmax*/
    pcx_header[9]=0x01;  /* Little Endian, so 0000 0000 013f 00c7= 319x199 */  
    pcx_header[10]=0xc7; /* " */
    pcx_header[12]=0x2c; /* Horizontal DPI */
    pcx_header[13]=0x01; /* " .. so 0x12c=300dpi */
    pcx_header[14]=0x2c; /* Vertical DPI */
    pcx_header[15]=0x01; /* " .. so 0x12c=300dpi */
    pcx_header[65]=0x01; /* Number of color planes */
    pcx_header[66]=0x40; /* bytes per line. */
    pcx_header[67]=0x01; /* "" .. so 0x140=320 */
    pcx_header[68]=0x01; /* Color Palette */
   
       /* 128 byte PCX Header */
    write(pcx_fd,pcx_header,128);

       /* All we support right now */
    xsize=320;
    ysize=200;
   
    y=y1;
    x=x1;
    numacross=1;
   
       /* Set up initial conditions */
    oldcolor=vmwGetPixel(x,y,source);
   
    while (y<y1+ysize) {
       color=vmwGetPixel(x,y,source);
       if ( (color==oldcolor)&&(numacross<63)&&(x<(x1+xsize-1)) ) numacross++;
       else { /* This pixel not the same color as previous */
//	  printf("G: %i,%i N=%i C=%i\n",x,y,numacross,color);
	  if ((numacross==1) && (oldcolor<192)) {
	     write(pcx_fd,&oldcolor,1);
	  }
	  else {
	     temp_byte=numacross+192;
	     write(pcx_fd,&temp_byte,1);
	     write(pcx_fd,&oldcolor,1);
             numacross=1;
	  }
       }
       oldcolor=color;
       x++;
       if (x>=x1+xsize) {
          x=0;
          y++;
          numacross=1;
//	  printf("%i %i %i\n",x,y,numacross);
//	  fflush(stdout);
       }
    }
   
    /* Urgh obscure */
    temp_byte=12;
    write(pcx_fd,&temp_byte,1);
   
           /* Write num_colors r,g,b */
    for(i=0;i<256;i++) {
       temp_byte=palette[i].r;
       write(pcx_fd,&temp_byte,1);
       temp_byte=palette[i].g;
       write(pcx_fd,&temp_byte,1);
       temp_byte=palette[i].b;
       write(pcx_fd,&temp_byte,1);
    }

    close(pcx_fd);
    return 0;
}
