#include <stdio.h>
#include <sys/stat.h> /* struct stat */
#include <stdlib.h> /* exit() */
#include <fcntl.h>  /* open() */
#include <unistd.h> /* close() */

#include "version.h"

int main(int argc, char **argv) {
   
    int in_fd,out_fd,offset;

    unsigned char buffer[256];
    int result,file_size;
   
    struct stat file_info;
   
    if (argc!=4) {
       printf("MAKE_B version %s\b",VERSION);
       printf(" Usage: %s in_file out_file offset\n\n",argv[0]);
       printf("\tin_file  : input file\n");
       printf("\tout_file : output file\n");
       printf("\toffset   : offset which file should be loaded\n\n");
       exit(1);
    }
   
    if (stat(argv[1],&file_info)<0) {
       printf("Error!  %s not found!\n",argv[1]);
       exit(2);
    }
    file_size=(int)file_info.st_size;
   
    if ((in_fd=open(argv[1],O_RDONLY))<0) {
       printf("Error opening %s!\n",argv[1]);
       exit(3);
    }

    if ((out_fd=open(argv[2],O_WRONLY|O_CREAT,0666))<0) {
       printf("Error opening %s\n",argv[2]);
       exit(4);
    }
   
    offset=strtol(argv[3],NULL,0);
   
    buffer[0]=offset&0xff;
    buffer[1]=(offset>>8)&0xff;
    buffer[2]=file_size&0xff;
    buffer[3]=(file_size>>8)&0xff;
   
    write(out_fd,&buffer,4);
   
    while( (result=read(in_fd,&buffer,256))>0) {
       write(out_fd,&buffer,result);
    }
    
   
    close(in_fd);
    close(out_fd);
   
    return 0;
}
