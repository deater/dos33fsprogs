#include <stdio.h>

#include "version.h"

int main(int argc, char **argv) {
   
   int input;
   
   while(1) {
    
      input=fgetc(stdin);
      if (input==EOF) break;
      printf("$%02X,",input|0x80);
   }
 
   return 0;
}
