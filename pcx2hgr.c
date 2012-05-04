/* Converts 280x160 8-bit PCX file with correct palette to Apple II HGR */

#include <stdio.h>    /* For FILE I/O */
#include <string.h>   /* For strncmp */
#include <fcntl.h>    /* for open()  */
#include <unistd.h>   /* for lseek() */
#include <sys/stat.h> /* for file modes */


#define PCX_UNKNOWN    0
#define PCX_8BIT       1
#define PCX_24BIT      2

int debug=1;

static int vmwGetPCXInfo(char *filename, int *xsize, int *ysize, int *type) {
    
    unsigned char pcx_header[128];
    int xmin,ymin,xmax,ymax,version=PCX_UNKNOWN,bpp,debug=1,pcx_fd;
    int result;

          /* Open the file */                  
    pcx_fd=open(filename,O_RDONLY);
    
    if (pcx_fd<0) {
       fprintf(stderr,"ERROR!  File \"%s\" not found!\n",filename);
       return -1;
    }
   
    lseek(pcx_fd,0,SEEK_SET);
    
    result=read(pcx_fd,&pcx_header,128);
    if (result<0) {
       fprintf(stderr,"Error!  Could not read header from file %s\n",filename);
       return -1;
    }

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
   
   *xsize=(xmax-xmin+1);
   *ysize=(ymax-ymin+1);

   if ((version==5) && (bpp==8) && (pcx_header[65]==3)) *type=PCX_24BIT;
   else if (version==5) *type=PCX_8BIT;
   else *type=PCX_UNKNOWN;

   close(pcx_fd);
   
   return 0;
}

static int vmwLoadPCX(char *filename, unsigned char *framebuffer)  {

    int pcx_fd;
    /*
    int x,y,i,numacross,xsize,ysize,xmin,ymin;
    unsigned int r,g,b;
    int bpp,planes,bpl,xmax,ymax,version;
    unsigned char pcx_header[128];
    unsigned char temp_byte;
    */

       /* Open the file */                  
    pcx_fd=open(filename,O_RDONLY);
    
    if (pcx_fd<0) {
       fprintf(stderr,"ERROR!  File \"%s\" not found!\n",filename);
       return -1;
    }
   
#if 0

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
#endif   
    close(pcx_fd);

    return 0;
}


int main(int argc, char **argv) {

  int xsize=0,ysize=0,type;
  unsigned char *framebuffer;

  vmwGetPCXInfo("vince.pcx",&xsize,&ysize,&type);

  framebuffer=calloc(xsize*ysize,sizeof(unsigned char));
  if (framebuffer==NULL) {
     fprintf(stderr,"Error allocating memory!\n");
     return -1;
  }

  vmwLoadPCX("vince.pcx",framebuffer);

  return 0;

}
