#include <stdio.h>
#include <string.h>

static void generate_keyhandler(void) {

  printf("9000 REM ******************\n");
  printf("9003 REM * GET KEYPRESSES *\n");
  printf("9005 REM ******************\n");

  /* memory location -16384 holds keyboard strobe */
  /* Loop until a key is pressed.                 */
  printf("9005 X=PEEK(-16384): IF X < 128 THEN 9005\n");
  /* get the key value, convert to ASCII */
  printf("9010 X=PEEK(-16368)-128\n");
  /* Exit if escape pressed */
  printf("9020 IF X=27 THEN END\n");
  /* increment page count if space or -> */
  printf("9030 IF X=21 OR X=32 THEN P%%=P%%+1\n");
  /* decrement page count if <- */
  printf("9040 IF X=8 THEN P%%=P%%-1\n");
  /* keep from going off the end */
  printf("9050 IF P%%>TP%% THEN P%%=TP%%\n");
  printf("9060 IF P%%<0 THEN P%%=0\n");
  printf("9070 RETURN\n");
}


static void generate_footer(char *left, char *center, int cols) {

  int center_len,center_count,i,right_count;

  printf("10000 REM ****************\n");
  printf("10001 REM * PRINT FOOTER *\n");
  printf("10002 REM ****************\n");
  /* make text black on white; move to bottom line */
  printf("10003 INVERSE : VTAB 24\n");

  printf("10005 X$=STR$(P%%)+\"/\":X$=X$+STR$(TP%%)\n");
  printf("10007 L%%=LEN(X$)\n");

  printf("10010 PRINT \"%s",left);
  
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

  printf("10012 FOR I=0 TO %d-L%%:PRINT \" \";: NEXT I\n",right_count-1);

  printf("10014 PRINT LEFT$(X$,L%%-1);\n");
  
  /* set last character to the right most char of the total pages */
  /* without scrolling.                                           */
  printf("10015 TP$=STR$(TP%%) : X$=RIGHT$(TP$,1) : X=VAL(X$): POKE 2039,X+48\n"); 
  /* reset text, move cursor up */
  printf("10020 NORMAL : VTAB 1: PRINT\"\"\n");
  printf("10030 RETURN\n");
}


int main(int argc, char **argv) {

   printf("5 HOME\n");
   printf("10 P%%=1 : TP%%=100\n");
   printf("20 GOSUB 10000\n");
   printf("30 GOSUB 9000\n");
   printf("40 GOTO 20\n");
   printf("100 END\n");

   generate_keyhandler();
   generate_footer("11 MAY 2012","ICL/UTK",40);

   return 0;
}
