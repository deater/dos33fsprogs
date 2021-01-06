#include <stdio.h>

int random_num(int seed) 
{

   static int our_seed;
      
   if (seed!=-1) our_seed=seed;
   
   if (our_seed==0) our_seed=13;
   
   our_seed<<=1;
   if (our_seed & 0x100) our_seed^=0x87;
   
   our_seed&=0xff;
   
   return our_seed;
   
}

int main(int argc, char **argv) 
{
int i;
   int frequency[256];
   for(i=0;i<256;i++) frequency[i]=0;
   
   for(i=0;i<4096;i++)
     frequency[random_num(-1)]++;
   
   for(i=0;i<256;i++) 
     printf("%i : %i\n",i,frequency[i]);

   
}

