#include <stdio.h>
#include <string.h>

void generate_footer(char *left, char *center, int cols) {

  int center_len,center_count,i,right_count;

  printf("1000 REM ************\n");
  printf("1001 REM PRINT FOOTER\n");
  printf("1002 REM ************\n");
  /* make text black on white; move to bottom line */
  printf("1003 INVERSE : VTAB 24\n");

  printf("1005 X$=STR$(P%%)+\"/\":X$=X$+STR$(TP%%)\n");
  printf("1007 L%%=LEN(X$)\n");

  printf("1010 PRINT \"%s",left);
  
  center_len=strlen(center);
  center_count=(cols-center_len)/2;
  center_count-=strlen(left);

  if (center_count<0) {
     fprintf(stderr,"Error! can't fit text in footer\n");
     center_count=0;
  }

  for(i=0;i<center_count;i++) printf(" ");
  printf("%s\";\n",center);

  right_count=cols-strlen(left)-center_count-center_len;

  printf("1012 FOR I=0 TO %d-L%%:PRINT \" \";: NEXT I\n",right_count-1);

  printf("1014 PRINT LEFT$(X$,L%%-1);\n");
  
  /* set last character to the right most char of the total pages */
  /* without scrolling.                                           */
  printf("1015 TP$=STR$(TP%%) : X$=RIGHT$(TP$,1) : X=VAL(X$): POKE 2039,X+48\n"); 
  /* reset text, move cursor up */
  printf("1020 NORMAL : VTAB 23: PRINT\"\"\n");
  printf("1030 RETURN\n");
}


int main(int argc, char **argv) {

   printf("5 HOME\n");
   printf("10 P%%=1 : TP%%=100\n");
   printf("20 GOSUB 1000\n");
   printf("22 PRINT \"\"\n");
   printf("25 GET A$\n");
   printf("30 IF A$ = \" \" THEN P%%=P%%+1: GOTO 20\n");
   printf("100 END\n");

   generate_footer("11 MAY 2012","ICL/UTK",40);

   return 0;
}
