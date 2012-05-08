/* http://www.atariarchives.org/cgp/Ch03_Sec05.php */

#include <stdio.h>
#include <string.h>

#define MAX_SIZE 8192 /* not really, but anything larger would be crazy */

static unsigned char table[MAX_SIZE];
  
void set_offset(current_shape,current_offset) {

  table[2+(current_shape*2)]=current_offset&0xff;
  table[2+(current_shape*2)+1]=(current_offset>>8)&0xff;
}

int main(int argc, char **argv) {

  char string[BUFSIZ];
  char *result;
  int table_size=0;
  int num_shapes=0;
  int current_offset=0,current_shape=0;
  int i;


  while(1) {
    result=fgets(string,BUFSIZ,stdin);
    if (result==NULL) break;

    /* skip comments and blank lines */
    if ((string[0]=='#') || (string[0]=='\n')) continue;

    sscanf(string,"%d",&num_shapes);

  }

  printf("Num shapes: %d\n",num_shapes);

  table[0]=num_shapes;
  table[1]=0;

  current_shape=0;
  current_offset=2+2*(num_shapes);

  set_offset(current_shape,current_offset);

  /* Find START */

  while(1) {
    result=fgets(string,BUFSIZ,stdin);
    if (result==NULL) break;

    /* skip comments and blank lines */
    if ((string[0]=='#') || (string[0]=='\n')) continue;

    if (!strstr(string,"START")) continue;

  }
  
  table_size=current_offset;

  for(i=0;i<current_offset;i++) {
    if(i%10==0) printf("%d DATA ",100+i/10);
    printf("%d",table[i]);

    if ((i%10==9)||(i==current_offset-1)) printf("\n");
    else printf(",");
  }

  return 0;
}
