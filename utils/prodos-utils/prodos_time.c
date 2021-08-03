#include <stdio.h>
#include <stdlib.h>   /* exit()    */
#include <string.h>   /* strncpy() */
#include <sys/stat.h> /* struct stat */
#include <fcntl.h>    /* O_RDONLY */
#include <unistd.h>   /* lseek() */
#include <ctype.h>    /* toupper() */
#include <errno.h>
#include <time.h>

#include "version.h"

#include "prodos.h"

extern int debug;

int prodos_time(time_t t) {

	struct tm *broken_time;
	int pyear,pmonth,pday,phour,pminute;
	int ptime;

	broken_time=localtime(&t);

	pyear=broken_time->tm_year;
	pmonth=broken_time->tm_mon;
	pday=broken_time->tm_mday;
	phour=broken_time->tm_hour;
	pminute=broken_time->tm_min;

	ptime=(pyear<<25)|(pmonth<<21)|(pday<<16)|(phour<<8)|pminute;

	if (debug) printf("Y=%d M=%d D=%d h=%d m=%d\n",
			pyear,pmonth,pday,phour,pminute);

	return ptime;
}

