#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static void generate_keyhandler(void) {

  printf("9000 REM ******************\n");
  printf("9002 REM * GET KEYPRESSES *\n");
  printf("9004 REM ******************\n");

  printf("9006 N%%=1\n");

  /* memory location -16384 holds keyboard strobe */
  /* Loop until a key is pressed.                 */
  printf("9008 X=PEEK(-16384): IF X < 128 THEN 9008\n");
  /* get the key value, convert to ASCII */
  printf("9010 X=PEEK(-16368)-128\n");
  /* Exit if escape or Q pressed */
  printf("9020 IF X=27 OR X=81 THEN END\n");
  /* increment page count if space or -> */
  printf("9030 IF X=21 OR X=32 THEN P%%=P%%+1:N%%=3\n");
  /* decrement page count if <- */
  printf("9040 IF X=8 THEN P%%=P%%-1:N%%=2\n");
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
  printf("10003 HOME: INVERSE : VTAB 24\n");

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

static void print_line(unsigned char c, int num) {

   int i;

   for(i=0;i<num;i++) printf("%c",c);

}

static void center_comment(unsigned char c, int max_len, char *string) {

   int half_len;

   half_len=(max_len-strlen(string))/2;

   print_line(' ',half_len);
   printf("%s",string);
   /* handle strings of odd length */
   print_line(' ',max_len-half_len-strlen(string));
}

static void generate_initial_comment(char *title, char *author, char *email) {

  int max_len;

   max_len=strlen(title);
   if (max_len<strlen(author)) max_len=strlen(author);
   if (max_len<strlen(email)) max_len=strlen(email);

   printf("2 REM ");
   print_line('*',max_len+4);
   printf("\n");

   printf("4 REM * ");
   center_comment(' ',max_len,title);
   printf(" *\n");

   printf("6 REM * ");
   center_comment(' ',max_len,author);
   printf(" *\n");

   printf("8 REM * ");
   center_comment(' ',max_len,email);
   printf(" *\n");

   printf("9 REM ");
   print_line('*',max_len+4);
   printf("\n");

} 

struct project_info {
  char *title;
  char *author;
  char *email;
  int slides;
};

int main(int argc, char **argv) {

   char project_directory[BUFSIZ];
   char filename[BUFSIZ],string[BUFSIZ];
   char *result;
   FILE *fff;

   struct project_info info;

   if (argc<2) {
      fprintf(stderr,"\n");
      fprintf(stderr,"USAGE: %s DIR\n",argv[0]);
      fprintf(stderr,"\tWhere DIR contains presentation info\n\n");
      exit(1);
   }

   /* read in project info */
   strncpy(project_directory,argv[1],BUFSIZ);
   sprintf(filename,"%s/info",project_directory);

   fff=fopen(filename,"r");
   if (fff==NULL) {
      fprintf(stderr,"Error!  Could not open %s\n",filename);
      exit(1);
   }

   result=fgets(string,BUFSIZ,fff);
   string[strlen(string)-1]='\0';
   info.title=strdup(string);

   result=fgets(string,BUFSIZ,fff);
   string[strlen(string)-1]='\0';
   info.author=strdup(string);
   
   result=fgets(string,BUFSIZ,fff);
   string[strlen(string)-1]='\0';
   info.email=strdup(string);

   result=fgets(string,BUFSIZ,fff);
   sscanf(string,"%d",&info.slides);

   if (result==NULL) fprintf(stderr,"Error reading!\n");

   fclose(fff);

   /* Print the initial program remarks */
   generate_initial_comment(info.title,info.author,info.email);

   printf("20 HOME\n");
   printf("30 P%%=0 : TP%%=%d\n",info.slides-1);

   printf("100 GOSUB 10000\n");
   printf("101 VTAB 1: PRINT \"    RAPL\"\n");
   printf("102 PRINT\n");
   printf("103 PRINT \"* RAPL is awesome\"\n");
   printf("130 GOSUB 9000\n");
   printf("131 ON N%% GOTO 100,100,200\n");

   printf("200 GOSUB 10000\n");
   printf("201 VTAB 1: PRINT \"    RAPL1\"\n");
   printf("202 PRINT\n");
   printf("203 PRINT \"* RAPL2 is awesome\"\n");
   printf("230 GOSUB 9000\n");
   printf("231 ON N%% GOTO 200,100,300\n");

   printf("300 GOSUB 10000\n");
   printf("301 VTAB 1: PRINT \"    RAPL2\"\n");
   printf("302 PRINT\n");
   printf("303 PRINT \"* RAPL3 is awesome\"\n");
   printf("330 GOSUB 9000\n");
   printf("331 ON N%% GOTO 300,200,400\n");

   printf("400 GOSUB 10000\n");
   printf("401 VTAB 1: PRINT \"    RAPL3\"\n");
   printf("402 PRINT\n");
   printf("403 PRINT \"* RAPL4 is awesome\"\n");
   printf("430 GOSUB 9000\n");
   printf("431 ON N%% GOTO 400,300,400\n");

   printf("999 END\n");

   generate_keyhandler();
   generate_footer("11 MAY 2012","ICL/UTK",40);

   return 0;
}
