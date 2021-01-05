#include <stdio.h>

#include "version.h"

int main(int argc, char **argv) {
   
    int ch;
    while(1) {
	
       ch=fgetc(stdin);
       if (feof(stdin)) return 0;
          /* clear high byte */
       ch=ch&0x7f;
          /* convert apple carriage-return to unix linefeed */
       if (ch=='\r') ch=('\n');
       fputc(ch,stdout);
    }
   
    return 0;
}

   
