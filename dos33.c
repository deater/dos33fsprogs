#include <stdio.h>
#include <stdlib.h>   /* exit()    */
#include <string.h>   /* strncpy() */
#include <sys/stat.h> /* struct stat */
#include <fcntl.h>    /* O_RDONLY */
#include <unistd.h>   /* lseek() */
#include <ctype.h>    /* toupper() */

#define VERSION "0.4"

#include "dos33.h"

int ones_lookup[16]={
  /* 0x0 = 0000 */ 0,
  /* 0x1 = 0001 */ 1,
  /* 0x2 = 0010 */ 1,
  /* 0x3 = 0011 */ 2,
  /* 0x4 = 0100 */ 1,
  /* 0x5 = 0101 */ 2,
  /* 0x6 = 0110 */ 2,
  /* 0x7 = 0111 */ 3,
  /* 0x8 = 1000 */ 1,
  /* 0x9 = 1001 */ 2,
  /* 0xA = 1010 */ 2,
  /* 0xB = 1011 */ 3,
  /* 0xC = 1100 */ 2,
  /* 0xd = 1101 */ 3,
  /* 0xe = 1110 */ 3,
  /* 0xf = 1111 */ 4,
};

unsigned char dos33_file_type(int value) {
 
    unsigned char result;
   
    switch(value&0x7f){ 
       case 0x0: result='T'; break;
       case 0x1: result='I'; break;
       case 0x2: result='A'; break;
       case 0x4: result='B'; break;
       case 0x8: result='S'; break;
       case 0x10: result='R'; break;
       case 0x20: result='N'; break;
       case 0x40: result='L'; break;
       default: result='?'; break;
    }
    return result;
}


unsigned char dos33_char_to_type(char type,int lock) {
 
    unsigned char result,temp_type;
    
    temp_type=type;
       /* Covert to upper case */
    if (temp_type>='a') temp_type=temp_type-0x20;
   
    switch(temp_type) {    
       case 'T': result=0x0; break;
       case 'I': result=0x1; break;
       case 'A': result=0x2; break;
       case 'B': result=0x4; break;
       case 'S': result=0x8; break;
       case 'R': result=0x10; break;
       case 'N': result=0x20; break;
       case 'L': result=0x40; break;
       default: result=0x0;
    }
    if (lock) result|=0x80;
    return result;
}

    /* dos33 filenames have top bit set on ascii chars */
    /* and are padded with spaces */
char *dos33_filename_to_ascii(unsigned char *dest,unsigned char *src) {
 
    int i=0,last_nonspace=0;
   
    for(i=0;i<30;i++) if (src[i]!=0xA0) last_nonspace=i;
    
    for(i=0;i<last_nonspace+1;i++) {
       dest[i]=src[i]^0x80; /* toggle top bit */
    }
   
    dest[i]='\0';
    return dest;

}

int dos33_read_vtoc(int fd,unsigned char *buffer) {
       /* Seek to VTOC */
    lseek(fd,DISK_OFFSET(VTOC_TRACK,VTOC_SECTOR),SEEK_SET);
       /* read in VTOC */
    read(fd,buffer,BYTES_PER_SECTOR); 

    return 0;
}

int dos33_free_space(int fd, unsigned char *buffer) {
   
    unsigned char bitmap[4];
    int i,sectors_free=0;
 
       /* Read Vtoc */
    dos33_read_vtoc(fd,buffer);
      
    for(i=0;i<TRACKS_PER_DISK;i++) {
       bitmap[0]=buffer[VTOC_FREE_BITMAPS+(i*4)];
       bitmap[1]=buffer[VTOC_FREE_BITMAPS+(i*4)+1];
       
       sectors_free+=ones_lookup[bitmap[0]&0xf];
       sectors_free+=ones_lookup[(bitmap[0]>>4)&0xf];
       sectors_free+=ones_lookup[bitmap[1]&0xf];
       sectors_free+=ones_lookup[(bitmap[1]>>4)&0xf];
       
//       printf("%i: 0x%x 0x%x\n",i,bitmap[0],bitmap[1]);
       
       
    }
    
    return sectors_free*BYTES_PER_SECTOR;
}



int dos33_get_catalog_ts(int fd,unsigned char *buffer) {
    dos33_read_vtoc(fd,buffer);
    
    return TS_TO_INT(buffer[VTOC_CATALOG_T],buffer[VTOC_CATALOG_S]);
}

int dos33_find_next_file(int fd,int catalog_tsf,unsigned char *buffer) {

   
    int catalog_track,catalog_sector,catalog_file;
    int file_track,i;

    catalog_file=catalog_tsf>>16;
    catalog_track=(catalog_tsf>>8)&0xff;
    catalog_sector=(catalog_tsf&0xff);

catalog_loop:
   
       /* Read in Catalog Sector */
    lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);
   
    i=catalog_file;
    while(i<7) {
       
       file_track=buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)];
          /* 0xff means file deleted */
          /* 0x0 means empty */
       if ((file_track!=0xff) && (file_track!=0x0)){ 
	  return ((i<<16)+(catalog_track<<8)+catalog_sector);
       }
       i++;
    }
    catalog_track=buffer[CATALOG_NEXT_T];
    catalog_sector=buffer[CATALOG_NEXT_S];
    if (catalog_sector!=0) {
       catalog_file=0;
       goto catalog_loop;
    }
   
    return -1;
}

int dos33_print_file_info(int fd,int catalog_tsf,unsigned char *buffer) {

    int catalog_track,catalog_sector,catalog_file,i;
    char temp_string[BUFSIZ];
   
    catalog_file=catalog_tsf>>16;
    catalog_track=(catalog_tsf>>8)&0xff;
    catalog_sector=(catalog_tsf&0xff);


       /* Read in Catalog Sector */
    lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);

    if (buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TYPE]>0x7f) {
       printf("*");
    }
    else printf(" ");
   
    printf("%c",dos33_file_type(buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TYPE]));
    printf(" ");
    printf("%.3i ",buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE+FILE_SIZE_L)]+
	          (buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE+FILE_SIZE_H)]<<8));
     

    strncpy(temp_string,dos33_filename_to_ascii(temp_string,
		buffer+(CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE+FILE_NAME))),BUFSIZ);

    for(i=0;i<strlen(temp_string);i++) {
       if (temp_string[i]<0x20) printf("^%c",temp_string[i]+0x40);
       else printf("%c",temp_string[i]);
    }
   
	
   
    printf("\n");
   
    return 0;
}


int dos33_check_file_exists(int fd,char *filename,unsigned char *buffer) {
    
    int catalog_track=0,catalog_sector=0;
    int i,file_track;
    char file_name[31];
 
    dos33_read_vtoc(fd,buffer);
   
    catalog_track=buffer[VTOC_CATALOG_T];
    catalog_sector=buffer[VTOC_CATALOG_S];
    
repeat_catalog:
   
       /* Read in Catalog Sector */
    lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);
      
    for(i=0;i<7;i++) {
       file_track=buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)];
          /* 0xff means file deleted */
          /* 0x0 means empty */
       if ((file_track!=0xff) && (file_track!=0x0)){ 
	  
	  dos33_filename_to_ascii(file_name,
		buffer+(CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE+FILE_NAME)));

	  if (!strncmp(filename,file_name,30)) return ((i<<16)+(catalog_track<<8)+catalog_sector);
       }
       
    }
    catalog_track=buffer[CATALOG_NEXT_T];
    catalog_sector=buffer[CATALOG_NEXT_S];
   
    if (catalog_sector!=0) goto repeat_catalog;
    
    return -1;
}

int find_first_one(unsigned char byte) {
 
   int i=0;
   
   if (byte==0) return -1;
   
   while((byte& (0x1<<i))==0) {
       i++;
   }
   
   return i;
   
}


int dos33_free_sector(int fd,int track,int sector) {
 
      
    unsigned char vtoc[BYTES_PER_SECTOR];
   
       /* Seek to VTOC */
    lseek(fd,DISK_OFFSET(VTOC_TRACK,VTOC_SECTOR),SEEK_SET);
       /* read in VTOC */
    read(fd,&vtoc,BYTES_PER_SECTOR); 
   
       /* each bitmap is 32 bits.  With 16-sector tracks only first 16 used */
       /* 1 indicates free, 0 indicates used */
    if (sector<8) {
       vtoc[VTOC_FREE_BITMAPS+(track*4)+1]|=(0x1<<sector);
    }
    else {
       vtoc[VTOC_FREE_BITMAPS+(track*4)]|=(0x1<<(sector-8));
    }
   
       /* write modified VTOC back out */
    lseek(fd,DISK_OFFSET(VTOC_TRACK,VTOC_SECTOR),SEEK_SET);
    write(fd,&vtoc,BYTES_PER_SECTOR);
   
    return 0;
   
   
}

int dos33_allocate_sector(int fd) {
 
    int found_track=0,found_sector=0;
    unsigned char bitmap[4],buffer[BYTES_PER_SECTOR];
    int i,start_track,track_dir,byte;   
      
    dos33_read_vtoc(fd,buffer);
    
       /* Originally used to keep things near center of disk for speed */
       /* We can use to avoid fragmentation possibly */
    start_track=buffer[VTOC_LAST_ALLOC_T]%TRACKS_PER_DISK;
    track_dir=buffer[VTOC_ALLOC_DIRECT];
  
    if (track_dir==255) track_dir=-1;
   
    if ((track_dir!=1) && (track_dir!=-1))
       printf("ERROR!  Invalid track dir %i\n",track_dir);

    if (((start_track>VTOC_TRACK) && (track_dir!=1)) ||
        ((start_track<VTOC_TRACK) && (track_dir!=-1))) 
       printf("Warning! Non-optimal values for track dir t=%i d=%i!\n",
	      start_track,track_dir);
  
   
    i=start_track;

    do {
       
       for(byte=1;byte>-1;byte--) {
	  
          bitmap[byte]=buffer[VTOC_FREE_BITMAPS+(i*4)+byte];
          if (bitmap[byte]!=0x00) {
	     found_sector=find_first_one(bitmap[byte]);
	     found_track=i;
	        /* clear bit indicating in use */
	     buffer[VTOC_FREE_BITMAPS+(i*4)+byte]&=~(0x1<<found_sector);
	     found_sector+=(8*(1-byte));
	     goto found_one;
	  }
       } 
              
          /* Move to next track, handling overflows */
       i+=track_dir;
       if (i<0) {
	  i=VTOC_TRACK;
	  track_dir=1;
       }
       
       if (i>=TRACKS_PER_DISK) {
	  i=VTOC_TRACK;
	  track_dir=-1;
       }
       
    } while (i!=start_track);
   
    printf("No room left!\n");
    return -1;
   
found_one:
       /* store new track/direction info */ 
    buffer[VTOC_LAST_ALLOC_T]=found_track;
   
    if (found_track>VTOC_TRACK) buffer[VTOC_ALLOC_DIRECT]=1;
    else buffer[VTOC_ALLOC_DIRECT]=-1;
   
       /* Seek to VTOC */
    lseek(fd,DISK_OFFSET(VTOC_TRACK,VTOC_SECTOR),SEEK_SET);
       /* Write out VTOC */
    write(fd,&buffer,BYTES_PER_SECTOR);
    return ((found_track<<8)+found_sector);
}

int dos33_add_file(int fd,char type,char *filename,char *apple_filename,
		   unsigned char *buffer) {
   
    int free_space,file_size;
    struct stat file_info; 
    int size_in_sectors=0;
    int initial_ts_list=0,ts_list=0,i,data_ts,x,bytes_read=0,old_ts_list;
    int catalog_track,catalog_sector,sectors_used=0;
    int input_fd;

   /* FIXME */
   /* check type */
   /* and sanity check a/b filesize is set properly */
   
   

       /* Determine size of file to upload */
    if (stat(filename,&file_info)<0) {
       printf("Error!  %s not found!\n",filename);
       exit(3);
    }
    file_size=(int)file_info.st_size;
   
       /* Get free space on device */
    free_space=dos33_free_space(fd,buffer);

       /* Check for free space */
       /* Really, this is not enough.  */
       /* We need an extra sector for a T/S list every 122*256 bytes (~31k) */
    if (file_size>free_space) {
       printf("Error!  Not enough free space on disk image\n");
    }

       /* plus one because we need a sector for the tail */
    size_in_sectors=(file_size/BYTES_PER_SECTOR)+1;
    printf("Need to allocate %i data sectors\n",size_in_sectors);
   
        /* Open the local file */
    input_fd=open(filename,O_RDONLY);
    if (input_fd<0) {
       printf("Error! could not open %s\n",filename);
       return -1;
    }
      

   
    i=0;
    while (i<size_in_sectors) {
       
          /* Create new T/S list if necessary */
       if (i%TSL_MAX_NUMBER==0) {	  
	  old_ts_list=ts_list;

	     /* allocate a sector for the new list */
	  ts_list=dos33_allocate_sector(fd);
	  sectors_used++;
          if (ts_list<0) return -1;
	  
	     /* clear the t/s sector */
	  for(x=0;x<BYTES_PER_SECTOR;x++) buffer[x]=0;
	  lseek(fd,DISK_OFFSET((ts_list>>8)&0xff,ts_list&0xff),SEEK_SET);
	  write(fd,buffer,BYTES_PER_SECTOR);
	  
	  if (i==0) initial_ts_list=ts_list;
	  else {
	        /* we aren't the first t/s list so do special stuff */

	        /* load in the old t/s list */
             lseek(fd,DISK_OFFSET((old_ts_list>>8)&0xff,old_ts_list&0xff),SEEK_SET);
             read(fd,&buffer,BYTES_PER_SECTOR);	  	        
	     
	        /* point from old ts list to new one we just made */
	     buffer[TSL_NEXT_TRACK]=(ts_list>>8)&0xff;
	     buffer[TSL_NEXT_SECTOR]=(ts_list)&0xff;
	     
	        /* set offset into file */
	     buffer[TSL_OFFSET_H]=(((i-122)*256)>>8)&0xff;
	     buffer[TSL_OFFSET_L]=(((i-122)*256)&0xff);
	        
	        /* write out the old t/s list with updated info */
	     lseek(fd,DISK_OFFSET((old_ts_list>>8)&0xff,old_ts_list&0xff),SEEK_SET);
	     write(fd,buffer,BYTES_PER_SECTOR);
	  }
       }       
       
       
          /* allocate a sector */
       data_ts=dos33_allocate_sector(fd);
       sectors_used++;
       
       if (data_ts<0) return -1;
       
          /* clear sector */
       for(x=0;x<BYTES_PER_SECTOR;x++) buffer[x]=0;

          /* read from input */
       bytes_read=read(input_fd,buffer,BYTES_PER_SECTOR);
       
          /* write to disk image */
       lseek(fd,DISK_OFFSET((data_ts>>8)&0xff,data_ts&0xff),SEEK_SET);
       write(fd,buffer,BYTES_PER_SECTOR);
//       printf("Writing %i bytes to %i/%i\n",bytes_read,(data_ts>>8)&0xff,
//	       data_ts&0xff);
       

       
          /* add to T/s table */
       
          /* read in t/s list */
       lseek(fd,DISK_OFFSET((ts_list>>8)&0xff,ts_list&0xff),SEEK_SET);
       read(fd,buffer,BYTES_PER_SECTOR);
       
          /* point to new data sector */
       buffer[((i%TSL_MAX_NUMBER)*2)+TSL_LIST]=(data_ts>>8)&0xff;
       buffer[((i%TSL_MAX_NUMBER)*2)+TSL_LIST+1]=(data_ts&0xff);
       
          /* write t/s list back out */
       lseek(fd,DISK_OFFSET((ts_list>>8)&0xff,ts_list&0xff),SEEK_SET);
       write(fd,buffer,BYTES_PER_SECTOR);	  
       
       i++;   
    }
   
    /* Add new file to Catalog */
   
       /* read in vtoc */
    dos33_read_vtoc(fd,buffer);
   
    catalog_track=buffer[VTOC_CATALOG_T];
    catalog_sector=buffer[VTOC_CATALOG_S];    

continue_parsing_catalog:
   
          /* Read in Catalog Sector */
    lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);
   
       /* Find empty directory entry */
   i=0;
   while(i<7) {
      if ((buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)]==0xff) ||
	  (buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)]==0x00)) 
	 goto got_a_dentry;
      i++;
   }
   
   if ((catalog_track=0x11) && (catalog_sector==1)) {
      /* in theory can only have 105 files */
      /* if full, we have no recourse!     */
      /* can we allocate new catalog sectors and point to them?? */
      printf("Error!  No more room for files!\n");
      return -1;
   }

   catalog_track=buffer[CATALOG_NEXT_T];
   catalog_sector=buffer[CATALOG_NEXT_S];

   goto continue_parsing_catalog;
   
got_a_dentry:      
//     printf("Adding file at entry %i of catalog 0x%x:0x%x\n",
//	    i,catalog_track,catalog_sector);
   
       /* Point entry to initial t/s list */
    buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)]=(initial_ts_list>>8)&0xff;
    buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+1]=(initial_ts_list&0xff);
       /* set file type */
    buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_TYPE]=
        dos33_char_to_type(type,0);

//     printf("Pointing T/S to %x/%x\n",(initial_ts_list>>8)&0xff,initial_ts_list&0xff);

       /* copy over filename */
    for(x=0;x<strlen(apple_filename);x++) 
       buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_NAME+x]=
             apple_filename[x]^0x80;
   
       /* pad out the filename with spaces */
    for(x=strlen(apple_filename);x<FILE_NAME_SIZE;x++)
        buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_NAME+x]=' '^0x80;
   
       /* fill in filesize in sectors */
    buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_SIZE_L]=
        sectors_used&0xff;
    buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_SIZE_H]=
        (sectors_used>>8)&0xff;
   
       /* write out catalog sector */
    lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
    write(fd,buffer,BYTES_PER_SECTOR);   
   
    return 0;
}

int dos33_load_file(int fd,int fts,char *filename,unsigned char *buffer) {
 
    int output_fd;
    int catalog_file,catalog_track,catalog_sector;
    int file_type,file_size=-1,tsl_track,tsl_sector,data_t,data_s;
    unsigned char data_sector[BYTES_PER_SECTOR];
    int tsl_pointer=0,output_pointer=0;
   
    output_fd=open(filename,O_WRONLY|O_CREAT,0666);
    if (output_fd<0) {
       printf("Error! could not open %s for local save\n",filename);
       return -1;
    }

    catalog_file=fts>>16;
    catalog_track=(fts>>8)&0xff;
    catalog_sector=(fts&0xff);


       /* Read in Catalog Sector */
    lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);
   
    tsl_track=buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TS_LIST_T];
    tsl_sector=buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TS_LIST_S];
    file_type=dos33_file_type(buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TYPE]);
   
    printf("file_type: %c\n",file_type);

keep_savin:   
       /* Read in TSL Sector */
    lseek(fd,DISK_OFFSET(tsl_track,tsl_sector),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);

   
    while(tsl_pointer<TSL_MAX_NUMBER) {
    
       data_t=buffer[TSL_LIST+(tsl_pointer*TSL_ENTRY_SIZE)];
       data_s=buffer[TSL_LIST+(tsl_pointer*TSL_ENTRY_SIZE)+1];

       
       if ((data_s==0) && (data_t==0)) {
       }
       else {
          lseek(fd,DISK_OFFSET(data_t,data_s),SEEK_SET);
          read(fd,&data_sector,BYTES_PER_SECTOR);

	     /* Cheat and get real file size from file itself */
	  if (tsl_pointer==0) {
	     switch(file_type) {  
	        case 'A':
	        case 'I':
	           file_size=data_sector[0]+(data_sector[1]<<8)+2;
		   break;
	        case 'B':
		   file_size=data_sector[2]+(data_sector[3]<<8)+4;
		   break;
	        default:
	           file_size=-1;
	     }
	  }

	  
	  
          lseek(output_fd,output_pointer*BYTES_PER_SECTOR,SEEK_SET);
          write(output_fd,&data_sector,BYTES_PER_SECTOR);
       }
       output_pointer++;
       tsl_pointer++;
    }
    tsl_track=buffer[TSL_NEXT_TRACK];
    tsl_sector=buffer[TSL_NEXT_SECTOR];
    
    if ((tsl_track==0) && (tsl_sector==0)) {
    }
    else goto keep_savin;
   
       /* Correct the file size */
    if (file_size>=0) {    
       ftruncate(output_fd,file_size);
    }
   
    return 0;
   
}


int dos33_delete_file(int fd,int fsl,unsigned char *buffer) {
   
    int i;
    int catalog_track,catalog_sector,catalog_entry;
    int ts_track,ts_sector;

       /* unpack file/track/sector info */
    catalog_entry=fsl>>16;
    catalog_track=(fsl>>8)&0xff;
    catalog_sector=(fsl&0xff);

       /* Load in the catalog table for the file */
    lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);
   
       /* get pointer to t/s list */
    ts_track=buffer[CATALOG_FILE_LIST+catalog_entry*CATALOG_ENTRY_SIZE+
		    FILE_TS_LIST_T];
    ts_sector=buffer[CATALOG_FILE_LIST+catalog_entry*CATALOG_ENTRY_SIZE+
		     FILE_TS_LIST_S];
   
keep_deleting:
   

   
       /* load in the t/s list info */
    lseek(fd,DISK_OFFSET(ts_track,ts_sector),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);
      
      /* Free each sector listed by t/s list */
    for(i=0;i<TSL_MAX_NUMBER;i++) {
          /* If t/s = 0/0 then no need to clear */
       if ((buffer[TSL_LIST+2*i]==0) && (buffer[TSL_LIST+2*i+1]==0)) {
       }
       else {
          dos33_free_sector(fd,buffer[TSL_LIST+2*i],buffer[TSL_LIST+2*i+1]);
       }
    }

          /* free the t/s list */
    dos33_free_sector(fd,ts_track,ts_sector);
   
       /* Point to next t/s list */
    ts_track=buffer[TSL_NEXT_TRACK];
    ts_sector=buffer[TSL_NEXT_SECTOR];
   
       /* If more tsl lists, keep looping */
    if ((ts_track==0x0) && (ts_sector==0x0)) {
    }
    else {
       goto keep_deleting;        
    }
   
       /* Erase file from catalog entry */
   
       /* First reload proper catalog sector */
   lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
   read(fd,buffer,BYTES_PER_SECTOR);
      
      /* save track as last char of name, for undelete purposes */
   buffer[CATALOG_FILE_LIST+(catalog_entry*CATALOG_ENTRY_SIZE)+
	  (FILE_NAME+FILE_NAME_SIZE-1)]=
     buffer[CATALOG_FILE_LIST+(catalog_entry*CATALOG_ENTRY_SIZE)];
   
       /* Actually delete the file */
       /* by setting the track value to FF which indicates deleted file */
   buffer[CATALOG_FILE_LIST+(catalog_entry*CATALOG_ENTRY_SIZE)]=0xff;
   
       /* re seek to catalog position and write out changes */
   lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
   write(fd,buffer,BYTES_PER_SECTOR);
   
   return 0;
}

int dump_sector(unsigned char *buffer) {
    int i,j;
   
    for(i=0;i<16;i++) {
       printf("$%02X : ",i*16);
       for(j=0;j<16;j++) 
	  printf("%02X ",buffer[i*16+j]);
       printf("\n");
    }
    return 0;
}

   


int dos33_dump(int fd, unsigned char *buffer) {
   
    int num_tracks,i,j,catalog_t,catalog_s,file,ts_t,ts_s,ts_total,track,sector;
    int deleted=0;
    char temp_string[BUFSIZ];
    unsigned char tslist[BYTES_PER_SECTOR];
   
    dos33_read_vtoc(fd,buffer);
    
    dump_sector(buffer);
   
    printf("\n\n");
    printf("VTOC INFORMATION:\n");
    catalog_t=buffer[VTOC_CATALOG_T];
    catalog_s=buffer[VTOC_CATALOG_S];
    printf("\tFirst Catalog = %02X/%02X\n",catalog_t,catalog_s);
    printf("\tDOS RELEASE = 3.%i\n",buffer[VTOC_DOS_RELEASE]);
    printf("\tDISK VOLUME = %i\n",buffer[VTOC_DISK_VOLUME]);
    ts_total=buffer[VTOC_MAX_TS_PAIRS];
    printf("\tT/S pairs that will fit in T/S List = %i\n",ts_total);
	                          
    printf("\tLast track where sectors were allocated = $%02X\n",
	                          buffer[VTOC_LAST_ALLOC_T]);
    printf("\tDirection of track allocation = %i\n",
	                          buffer[VTOC_ALLOC_DIRECT]);
   
    num_tracks=buffer[VTOC_NUM_TRACKS];
    printf("\tNumber of tracks per disk = %i\n",num_tracks);
    printf("\tNumber of sectors per track = %i\n",
	                          buffer[VTOC_S_PER_TRACK]);
    printf("\tNumber of bytes per sector = %i\n",
	        (buffer[VTOC_BYTES_PER_SH]<<8)+buffer[VTOC_BYTES_PER_SL]);
    
    printf("\nFree sector bitmap:\n");
    printf("\tTrack  FEDCBA98 76543210\n");
    for(i=0;i<num_tracks;i++) {
       printf("\t $%02X:  ",i);
       for(j=0;j<8;j++) { 
	  if ((buffer[VTOC_FREE_BITMAPS+(i*4)]<<j)&0x80) printf("."); 
          else printf("U");
       }
       printf(" ");
       for(j=0;j<8;j++) { 
	  if ((buffer[VTOC_FREE_BITMAPS+(i*4)+1]<<j)&0x80) printf("."); 
          else printf("U");
       }
       
       printf("\n");
    }

repeat_catalog:
   
    printf("\nCatalog Sector $%02X/$%02x\n",catalog_t,catalog_s);
    lseek(fd,DISK_OFFSET(catalog_t,catalog_s),SEEK_SET);
    read(fd,buffer,BYTES_PER_SECTOR);

    dump_sector(buffer);    

   
    for(file=0;file<7;file++) {
       printf("\n\n");	

       ts_t=buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_TS_LIST_T))];
       ts_s=buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_TS_LIST_S))];

       printf("%i+$%02X/$%02X - ",file,catalog_t,catalog_s);
       deleted=0;
       
       if (ts_t==0xff) {
          printf("**DELETED** ");
          deleted=1;
	  ts_t=buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_NAME+0x1e))];
       }
   
       if (ts_t==0x00) {
          printf("UNUSED!\n");
          goto continue_dump;
       }
   
       strncpy(temp_string,dos33_filename_to_ascii(temp_string,
		buffer+(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_NAME))),BUFSIZ);

       for(i=0;i<strlen(temp_string);i++) {
          if (temp_string[i]<0x20) printf("^%c",temp_string[i]+0x40);
          else printf("%c",temp_string[i]);
       }
       printf("\n");
       printf("\tLocked = %s\n",
	    buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE)+FILE_TYPE]>0x7f?
	   "YES":"NO");
       printf("\tType = %c\n", 
           dos33_file_type(buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE)+FILE_TYPE]));
       printf("\tSize in sectors = %i\n",
                   buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_SIZE_L)]+
	          (buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_SIZE_H)]<<8));
repeat_tsl:
       printf("\tT/S List $%02X/$%02X:\n",ts_t,ts_s);
       if (deleted) goto continue_dump;
       lseek(fd,DISK_OFFSET(ts_t,ts_s),SEEK_SET);
       read(fd,&tslist,BYTES_PER_SECTOR);

       for(i=0;i<ts_total;i++) {
          track=tslist[TSL_LIST+(i*TSL_ENTRY_SIZE)];
          sector=tslist[TSL_LIST+(i*TSL_ENTRY_SIZE)+1];
          if ((track==0) && (sector==0)) printf(".");
          else printf("\n\t\t%02X/%02X",track,sector);
       }
       ts_t=tslist[TSL_NEXT_TRACK];
       ts_s=tslist[TSL_NEXT_SECTOR];
   
       if (!((ts_s==0) && (ts_t==0))) goto repeat_tsl;
continue_dump:
    }
    
    catalog_t=buffer[CATALOG_NEXT_T];
    catalog_s=buffer[CATALOG_NEXT_S];
   
    if (catalog_s!=0) {
       file=0;
       goto repeat_catalog;
    }
   
	   

   
	
   
    printf("\n");
    
   
    return 0;
}



int display_help(char *name) {
    printf("\n%s version %s\n",name,VERSION);
    printf("by Vince Weaver <vince@deater.net>\n");
    printf("\n");
    printf("Usage: %s disk_image COMMAND\n",name);
    printf("  Where disk_image is a valid dos3.3 disk image\n"
	   "  and COMMAND is one of the following:\n");
    printf("\tCATALOG\n");
    printf("\tLOAD apple_file <local_file>\n");
    printf("\n");
    return 0;
}

#define COMMAND_UNKNOWN  0
#define COMMAND_LOAD     1
#define COMMAND_SAVE     2
#define COMMAND_BLOAD    3
#define COMMAND_BSAVE    4
#define COMMAND_CATALOG  5
#define COMMAND_DELETE   6
#define COMMAND_UNDELETE 7
#define COMMAND_LOCK     8
#define COMMAND_UNLOCK   9
#define COMMAND_INIT    10
#define COMMAND_UPLOAD  11
#define COMMAND_DNLOAD  12
#define COMMAND_VERIFY  13
#define COMMAND_RENAME  14
#define COMMAND_COPY    15
#define COMMAND_DUMP    16

int main(int argc, char **argv) {
   
    char image[BUFSIZ];
    unsigned char type='b';
    int dos_fd=0,i;

    int command,catalog;
    char temp_string[BUFSIZ];
    char apple_filename[31];
    char output_filename[BUFSIZ];
   
    unsigned char scratch_sector[BYTES_PER_SECTOR];
   
    if (argc<3) {
       printf("\nInvalid arguments!\n");
       display_help(argv[0]);
       goto exit_program;
    }

    strncpy(temp_string,argv[2],BUFSIZ);
    for(i=0;i<strlen(temp_string);i++) temp_string[i]=toupper(temp_string[i]);
   
    if (!strncmp(temp_string,"LOAD",4)) {
       command=COMMAND_LOAD;
    }
    else if (!strncmp(temp_string,"SAVE",4)) {
       command=COMMAND_SAVE;
    }
    else if (!strncmp(temp_string,"BLOAD",5)) {
       command=COMMAND_BLOAD;
    }
    else if (!strncmp(temp_string,"BSAVE",5)) {
       command=COMMAND_BSAVE;
    }
    else if (!strncmp(temp_string,"CATALOG",7)) {
       command=COMMAND_CATALOG;
    }
    else if (!strncmp(temp_string,"DELETE",6)) {
       command=COMMAND_DELETE;
    }
    else if (!strncmp(temp_string,"UNDELETE",8)) {
       command=COMMAND_UNDELETE;
    }
    else if (!strncmp(temp_string,"LOCK",4)) {
       command=COMMAND_LOCK;
    }
    else if (!strncmp(temp_string,"UNLOCK",6)) {
       command=COMMAND_UNLOCK;
    }
    else if (!strncmp(temp_string,"INIT",4)) {
       command=COMMAND_INIT;
    }
    else if (!strncmp(temp_string,"UPLOAD",6)) {
       command=COMMAND_UPLOAD;
    }
    else if (!strncmp(temp_string,"DNLOAD",6)) {
       command=COMMAND_DNLOAD;
    }
    else if (!strncmp(temp_string,"VERIFY",6)) {
       command=COMMAND_VERIFY;
    }
    else if (!strncmp(temp_string,"RENAME",6)) {
       command=COMMAND_RENAME;
    }
    else if (!strncmp(temp_string,"COPY",4)) {
       command=COMMAND_COPY;
    }
    else if (!strncmp(temp_string,"DUMP",4)) {
       command=COMMAND_DUMP;
    }	
    else {
       display_help(argv[0]);
       goto exit_program;
    }
   
    strncpy(image,argv[1],BUFSIZ);    
    dos_fd=open(image,O_RDWR);
    if (dos_fd<0) {
       printf("Error opening disk_image: %s\n",image);
       exit(4);
    }
   
    switch(command) {
       case COMMAND_LOAD:
       case COMMAND_BLOAD:
            if (argc<4) {
	       printf("Error! Need apple file_name\n");
	       printf("%s %s LOAD apple_filename\n",argv[0],image);
	       goto exit_and_close;
	    }
            if (strlen(argv[3])>30) {
	       printf("Warning!  Truncating %s to 30 chars\n",argv[3]);
	    }
            strncpy(apple_filename,argv[3],30);
	    apple_filename[31]='\0';
		
            if (argc==5) {
	       strncpy(output_filename,argv[4],BUFSIZ);
	    }
            else {
	       strncpy(output_filename,apple_filename,30);
	    }
       
            catalog=dos33_check_file_exists(dos_fd,apple_filename,scratch_sector);
            if (catalog<0) {
	       printf("Error!  %s not found!\n",apple_filename);
	       goto exit_and_close;
	    }

            dos33_load_file(dos_fd,catalog,output_filename,scratch_sector);
            
       
            break;
       case COMMAND_CATALOG:     
            
            /* get first catalog */
            catalog=dos33_get_catalog_ts(dos_fd,scratch_sector);       
       
            printf("\nDISK VOLUME %i\n\n",scratch_sector[VTOC_DISK_VOLUME]);
            while(catalog>0) {
               catalog=dos33_find_next_file(dos_fd,catalog,scratch_sector);
               if (catalog>0) {
		  dos33_print_file_info(dos_fd,catalog,scratch_sector);
	          catalog+=(1<<16);
	       }
	    }
            printf("\n");
            break;
     
     case COMMAND_SAVE:
       
               /* argv3 == type == A,B,T,I, N,L etc */
               /* argv4 == name of local file */
               /* argv5 == optional name of file on disk image */
       
            if (argc<5) {
	       printf("Error! Need type and file_name\n");
	       printf("%s %s SAVE type file_name apple_filename\n",argv[0],image);
	       goto exit_and_close;
	    }
            
            type=argv[3][0];
       
            if (argc==6) {
	       if (strlen(argv[5])>30) {
		  printf("Warning!  Truncating filename to 30 chars!\n");
	       }
	       strncpy(apple_filename,argv[5],30);
	       apple_filename[31]=0;
	    }
            else {
	       if (strlen(argv[4])>30) {
		  printf("Warning!  Truncating filename to 30 chars!\n");
	       }
	       strncpy(apple_filename,argv[4],30);
	       apple_filename[31]=0;
	    }
       
            catalog=dos33_check_file_exists(dos_fd,apple_filename,scratch_sector);
            if (catalog>=0) {
	       printf("Warning!  %s exists!\n",apple_filename);
	       printf("Over-write (y/n)?");
	       fgets(temp_string,BUFSIZ,stdin);
	       if (temp_string[0]!='y') {
		  printf("Exiting early...\n");
		  goto exit_and_close;
	       }
	       printf("Deleting previous version...\n");
	       dos33_delete_file(dos_fd,catalog,scratch_sector);
	    }

            dos33_add_file(dos_fd,type,argv[4],apple_filename,scratch_sector);
            
       
            break;
     case COMMAND_BSAVE:

     case COMMAND_DELETE:
            if (argc<4) {
	       printf("Error! Need file_name\n");
	       printf("%s %s DELETE apple_filename\n",argv[0],image);
	       goto exit_and_close;
	    }
            catalog=dos33_check_file_exists(dos_fd,argv[3],scratch_sector);
            if (catalog<0) {
	       printf("Error!  File %s does not exist\n",argv[3]);
	       goto exit_and_close;
	    } 
	    dos33_delete_file(dos_fd,catalog,scratch_sector);
	    break;
	 
     case COMMAND_UNDELETE:
     case COMMAND_LOCK:
     case COMMAND_UNLOCK:
     case COMMAND_INIT:
     case COMMAND_UPLOAD:
     case COMMAND_DNLOAD:
     case COMMAND_VERIFY:
     case COMMAND_RENAME:
     case COMMAND_COPY:
     case COMMAND_DUMP:
          printf("Dumping %s!\n",argv[1]);
          dos33_dump(dos_fd,scratch_sector);
          break;
     default:
       printf("Sorry, unsupported command\n");
       goto exit_and_close;
    }

   
exit_and_close:
    close(dos_fd);
exit_program:
   
    return 0;  
}
