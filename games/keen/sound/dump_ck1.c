/* Dump sounds files from commander keen 1-3 sound file */
/* "Inverse Frequency Sound Format" */

/* https://moddingwiki.shikadi.net/wiki/Inverse_Frequency_Sound_format */

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>

#define NUM_SOUNDS	64

int main(int argc, char **argv) {

	unsigned char header[16],info[16],temp_sample[2];
	int fd,result,i,j;
	int file_size,num_sounds,sample,last,count,final;
	double frequency;

	char *filename;

	struct sound_info_type {
		int offset;
		int priority;
		int rate;
		char name[16];
	} sound_info[NUM_SOUNDS];

	if (argc>1) {
		filename=strdup(argv[1]);
	}
	else {
		filename=strdup("sounds.ck1");
	}

	fd=open(filename,O_RDONLY);
	if (fd<0) {
		fprintf(stderr,"Error: %s\n",strerror(errno));
		return -1;
	}

	/* read header */
	result=read(fd,header,16);
	if (result<16) {
		fprintf(stderr,"Error reading: %s\n",strerror(errno));
		return -1;
	}

	if ((header[0]=='S') && (header[1]=='N') && (header[2]=='D')) {
		file_size=(header[4]|(header[5]<<8));
		num_sounds=(header[8]|(header[9]<<8));
		printf("Detected SND file, %d sounds, %d bytes\n",
			num_sounds,file_size);
	}
	else {
		fprintf(stderr,"Unknown file format!\n");
		return -1;
	}

	if (num_sounds>=NUM_SOUNDS) {
		fprintf(stderr,"Too many sounds %d\n",num_sounds);
		return -1;
	}

	for(i=0;i<num_sounds;i++) {
		result=read(fd,info,16);
		if (result<16) {
			fprintf(stderr,"Error reading: %s\n",strerror(errno));
			return -1;
		}
		sound_info[i].offset=info[0]+(info[1]<<8);
		sound_info[i].priority=info[2];
		sound_info[i].rate=info[3];
		for(j=0;j<12;j++) {
			sound_info[i].name[j]=info[4+j];
		}
		sound_info[i].name[12]=0;
	}

	printf("\nName\tOffset\tPriority\tRate\n");
	printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
	for(i=0;i<num_sounds;i++) {
		printf("%s\t%d\t%d\t%d\n",
			sound_info[i].name,
			sound_info[i].offset,
			sound_info[i].priority,
			sound_info[i].rate);
	}


	i=14;
	printf("Dump of %s\n",sound_info[i].name);
	lseek(fd,sound_info[i].offset,SEEK_SET);

	last=0xffff;
	count=0;
	while(1) {
		result=read(fd,temp_sample,2);
		if (result<2) {
			fprintf(stderr,"Error reading sample\n");
			return -1;
		}
		sample=temp_sample[0]|(temp_sample[1]<<8);

//		printf("%d\n",sample);

		if (last!=sample) {
			if (last!=0xffff) {
				if (last==0) {
					frequency=0;
					final=0;
				}

				else {
					frequency=1193181.0/last;

					final=(int)(1.0/(
						(20.0*(1.023e-6)*frequency)-
						17*1.023e-6));
				}

				printf(".byte %d,%d\t; %.1lf\n",
					final/2,count,frequency);
			}
			count=0;
			last=sample;
		}
		count++;

		if (sample==0xffff) break;
	}
	/* close */
	close(fd);

	return 0;
}
