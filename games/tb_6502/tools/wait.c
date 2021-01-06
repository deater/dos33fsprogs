#include <stdio.h>

int main(int argc, char **argv) {
   
    int i;
   
    for(i=0;i<256;i++) {
       printf("%i = %x = %i\n",i,i,(26+27*i+5*i*i)/2);
    }
   
   return 0;
   
   
   
}
