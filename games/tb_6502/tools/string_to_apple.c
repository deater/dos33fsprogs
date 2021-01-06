#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {
    
    char string[BUFSIZ];
    int i;

    while(1) {
    fgets(string,BUFSIZ,stdin);
    if (feof(stdin)) goto done;
       
    printf(";# %s\n",string);
    printf(".byte\t");
   
    printf("$%X",string[0]+128);
   
    for (i=1;i<strlen(string);i++) {
       printf(",$%X",string[i]+128);
    }
    printf("\n");
    
    }
   done:
    return 0;  
}
