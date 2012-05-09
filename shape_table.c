/* Creates an AppleSoft BASIC shape table                    */
/* See the AppleSoft manual for info on how this works       */
/* Other online info (I'm looking at you, atariarchives.org) */
/* is inaccurate                                             */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_SIZE 8192 /* not really, but anything larger would be crazy */

static unsigned char table[MAX_SIZE];
  
void set_offset(current_shape,current_offset) {

  table[2+(current_shape*2)]=current_offset&0xff;
  table[2+(current_shape*2)+1]=(current_offset>>8)&0xff;
}

#define LOC_A 0
#define LOC_B 1
#define LOC_C 2

static void warn_if_zero(unsigned char byte, int line) {

     /* Check to see if we're accidentally ignoring bytes */
     if (byte==0) {
       fprintf(stderr,"Warning, all-0 byte will be ignored on line %d!\n",
	       line);
     }
	    
     if ((byte&0xf8)==0) {
       fprintf(stderr,"Warning, ignoring C and B due to 0 on line %d!\n",
	       line);
     }

}

void print_usage(char *exe) {
   printf("Usage:\t%s [-h] [-a] [-b]\n\n",exe);
   printf("\t-h\tprint this help message\n");
   printf("\t-a\toutput shape table in applesoft BASIC format\n");
   printf("\t-b\toutput shape table in binary format for BLOADing\n");
   printf("\n");
   exit(1);
}

int main(int argc, char **argv) {

  char string[BUFSIZ];
  char *result;
  int table_size=0;
  int num_shapes=0;
  int current_offset=0,current_shape=0;
  int i,line=1;

  int command=0,sub_pointer;

  int output_binary=0;

  if (argc<2) {
     output_binary=0;
  }

  else {
     if (argv[1][0]=='-') {

        switch(argv[1][1]) {

           case 'h': print_usage(argv[0]);
           case 'b': output_binary=1;
	             break;
           case 'a': output_binary=0;
                     break;
           default:  printf("Unknown options %s\n",argv[1]);
                     print_usage(argv[0]);
	}
     }
  }

  while(1) {
    result=fgets(string,BUFSIZ,stdin);
    if (result==NULL) break;
    line++;

    /* skip comments and blank lines */
    if ((string[0]=='#') || (string[0]=='\n')) continue;

    sscanf(string,"%d",&num_shapes);
    break;

  }

  //fprintf(stderr,"Num shapes: %d\n",num_shapes);

  table[0]=num_shapes;
  table[1]=0;

  current_shape=0;
  current_offset=2+2*(num_shapes);

  for(current_shape=0;current_shape<num_shapes;current_shape++) {

     set_offset(current_shape,current_offset);

     /* Find START */

     while(1) {
        result=fgets(string,BUFSIZ,stdin);
        if (result==NULL) break;
	line++;

        /* skip comments and blank lines */
        if ((string[0]=='#') || (string[0]=='\n')) continue;

        if (strstr(string,"START")) break;

     }


     /* READ DATA */

     sub_pointer=LOC_A;
     while(1) {
        result=fgets(string,BUFSIZ,stdin);
        if (result==NULL) break;
	line++;

        /* skip comments and blank lines */
        if ((string[0]=='#') || (string[0]=='\n')) continue;

        if (strstr(string,"STOP")) break;


        /* yes, this is inefficient... */

        if (strstr(string,"NUP")) command=0;
        else if (strstr(string,"NRT")) command=1;
        else if (strstr(string,"NDN")) command=2;
        else if (strstr(string,"NLT")) command=3;
        else if (strstr(string,"UP")) command=4;
        else if (strstr(string,"RT")) command=5;
        else if (strstr(string,"DN")) command=6;
        else if (strstr(string,"LT")) command=7;
        else fprintf(stderr,"Unknown command %s",string);

	if (sub_pointer==LOC_A) {
           table[current_offset]=(command&0x7);
	   sub_pointer=LOC_B;
	}
	else if (sub_pointer==LOC_B) {
	   table[current_offset]|=((command&0x7)<<3);
	   sub_pointer=LOC_C;
	}
	else {
	  /* Try to fit in LOC_C.  This can only hold no-draw moves */
	  /* Also a LOC_C of 0 is ignored                           */
	  if ((command&0x4) || (command==0)) {

	    /* Write to LOC_A instead */

	    warn_if_zero(table[current_offset],line);

	     current_offset++;
	     table[current_offset]=(command&0x7);
	     sub_pointer=LOC_B;
	  }
	  else {
	    
	     /* write to LOC_C */
	     table[current_offset]|=((command&0x3)<<6);

	     warn_if_zero(table[current_offset],line);

	     current_offset++;
	     sub_pointer=LOC_A;
	  }

	}
     }
  
     if (sub_pointer!=LOC_A) current_offset++;

     table[current_offset]=0; current_offset++;
  
  }

  table_size=current_offset;

  if (output_binary) {
     unsigned char header[4];
     int offset=0x6000;
    
     header[0]=offset&0xff;
     header[1]=(offset>>8)&0xff;
     header[2]=table_size&0xff;
     header[3]=(table_size>>8)&0xff;

     fprintf(stderr,"Be sure to POKE 232,%d : POKE 233,%d\n"
	     "\tto let applesoft know the location of the table\n",
	     offset&0xff,(offset>>8)&0xff);

     fwrite(header,sizeof(unsigned char),4,stdout);

     fwrite(table,sizeof(unsigned char),table_size,stdout);
  }
  else {

     /* put near highmem */
     int address=0x1ff0-table_size;

     printf("10 HIMEM:%d\n",address);
     printf("20 POKE 232,%d:POKE 233,%d\n",(address&0xff),(address>>8)&0xff);
     printf("30 FOR L=%d TO %d: READ B:POKE L,B:NEXT L\n",
	    address,(address+table_size)-1);
     printf("35 HGR:ROT=0:SCALE=2\n");
     printf("40 FOR I=1 TO %d: XDRAW I AT I*10,100:NEXT I\n",
	    num_shapes);
     printf("90 END\n");

     for(i=0;i<current_offset;i++) {
        if(i%10==0) printf("%d DATA ",100+i/10);
        printf("%d",table[i]);
        if ((i%10==9)||(i==current_offset-1)) printf("\n");
        else printf(",");
     }
  }

  return 0;
}
