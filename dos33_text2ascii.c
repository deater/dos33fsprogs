#include <stdio.h>

int main(int argc, char **argv) {
   
    int ch;
    while(1) {
	
       ch=fgetc(stdin);
       if (feof(stdin)) return 0;
       ch=ch&0x7f;
       if (ch=='\r') ch=('\n');
       fputc(ch,stdout);
    }
   
    return 0;

   
}

   
