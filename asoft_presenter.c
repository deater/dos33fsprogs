#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static void generate_keyhandler(void) {

  printf("9000 REM ******************\n");
  printf("9002 REM * GET KEYPRESSES *\n");
  printf("9004 REM ******************\n");

  printf("9006 N%%=2\n");

  /* memory location -16384 holds keyboard strobe */
  /* Loop until a key is pressed.                 */
  printf("9008 X=PEEK(-16384): IF X < 128 THEN 9008\n");
  /* get the key value, convert to ASCII */
  printf("9010 X=PEEK(-16368)-128\n");
  /* Exit if escape or Q pressed */
  printf("9020 IF X=27 OR X=81 THEN TEXT:HOME:END\n");
  /* increment page count if space or -> */
  printf("9030 IF X=21 OR X=32 THEN P%%=P%%+1:N%%=3\n");
  /* decrement page count if <- */
  printf("9040 IF X=8 THEN P%%=P%%-1:N%%=1\n");
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

struct footer_info {
  char *left;
  char *center;
};

#define SLIDE_40COL 0
#define SLIDE_80COL 1
#define SLIDE_HGR   2
#define SLIDE_HGR2  3

#define MAX_SLIDES 100

struct slide_info {
  int type;
  char *filename;
};

#define LINES_PER_SLIDE 30

static void generate_slide(int num, int max, char*filename) {

   int line_num;
   FILE *fff;
   char string[BUFSIZ],*result;

   /* line numbers start at 100 and run LINES_PER_SLIDE per slide */
   line_num=100+(num*LINES_PER_SLIDE);

   /* print a REMARK block */
   printf("%d REM ",line_num);                                 line_num++;
   print_line('*',strlen(filename)+8);
   printf("\n");
   printf("%d REM *** %s ***\n",line_num,filename);            line_num++;
   printf("%d REM ",line_num);                                 line_num++;
   print_line('*',strlen(filename)+8);
   printf("\n");

   /* print the footer */
   printf("%d GOSUB 10000\n",line_num);                        line_num++;

   /* generate the slide */

   fff=fopen(filename,"r");
   if (fff==NULL) {
     fprintf(stderr,"Couldn't open %s!\n",filename);
   }
   else {

     printf("%d VTAB 1\n",line_num);                           line_num++;
      while(1) {
	 result=fgets(string,BUFSIZ,fff);
	 if (result==NULL) break;
	 string[strlen(string)-1]='\0';
	 printf("%d  PRINT \"%s\"\n",line_num,string);         line_num++;
      }

      fclose(fff);
   }

   /* wait for keypress and move to next slide */
   printf("%d GOSUB 9000\n",line_num);                         line_num++;
   printf("%d ON N%% GOTO %d,%d,%d\n",
	  line_num,
          /* previous */
	  num==0?(100+(num*LINES_PER_SLIDE)):(100+((num-1)*LINES_PER_SLIDE)),
	  /* current  */
	  100+(num*LINES_PER_SLIDE),                      
	  /* next */
	  num<(max-1)?(100+((num+1)*LINES_PER_SLIDE)):
                      (100+(num*LINES_PER_SLIDE))); 
}

int main(int argc, char **argv) {

   int i;
   char project_directory[BUFSIZ];
   char filename[BUFSIZ],string[BUFSIZ];
   char *result;
   FILE *fff;

   struct project_info info;
   struct footer_info footer;
   struct slide_info slides[MAX_SLIDES];

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

   /* Get Title */
   while(1) {
      result=fgets(string,BUFSIZ,fff);
      if (result==NULL) {
	 fprintf(stderr,"Unexpected EOF finding TITLE in %s\n",filename);
	 exit(1);
      }
      if (!strncmp("TITLE",string,5)) break;
   }
   result=fgets(string,BUFSIZ,fff);
   string[strlen(string)-1]='\0';
   info.title=strdup(string);

   /* Get Author */
   while(1) {
      result=fgets(string,BUFSIZ,fff);
      if (result==NULL) {
	 fprintf(stderr,"Unexpected EOF finding AUTHOR in %s\n",filename);
	 exit(1);
      }
      if (!strncmp("AUTHOR",string,6)) break;
   }
   result=fgets(string,BUFSIZ,fff);
   string[strlen(string)-1]='\0';
   info.author=strdup(string);

   /* Get E-mail */
   while(1) {
      result=fgets(string,BUFSIZ,fff);
      if (result==NULL) {
	 fprintf(stderr,"Unexpected EOF finding EMAIL in %s\n",filename);
	 exit(1);
      }
      if (!strncmp("EMAIL",string,5)) break;
   }
   result=fgets(string,BUFSIZ,fff);
   string[strlen(string)-1]='\0';
   info.email=strdup(string);

   /* Get list of slides */

   while(1) {
      result=fgets(string,BUFSIZ,fff);
      if (result==NULL) {
	 fprintf(stderr,"Unexpected EOF finding SLIDES in %s\n",filename);
	 exit(1);
      }
      if (!strncmp("SLIDES",string,6)) break;
   }

   info.slides=0;

   while(1) {
      result=fgets(string,BUFSIZ,fff);
      if (result==NULL) {
	 fprintf(stderr,"Unexpected EOF finding END_SLIDES in %s\n",filename);
	 exit(1);
      }
      if (!strncmp("END_SLIDES",string,10)) break;

      string[strlen(string)-1]='\0';
      slides[info.slides].filename=strdup(string);

      info.slides++;
   }

   if (result==NULL) fprintf(stderr,"Error reading!\n");

   fclose(fff);

   /************************/
   /* read in footer info  */
   /************************/

   strncpy(project_directory,argv[1],BUFSIZ);
   sprintf(filename,"%s/footer",project_directory);

   fff=fopen(filename,"r");
   if (fff==NULL) {
      fprintf(stderr,"Error!  Could not open %s\n",filename);
      exit(1);
   }

   result=fgets(string,BUFSIZ,fff);
   string[strlen(string)-1]='\0';
   footer.left=strdup(string);

   result=fgets(string,BUFSIZ,fff);
   string[strlen(string)-1]='\0';
   footer.center=strdup(string);

   fclose(fff);
   

   /**************************/
   /* Generate the program   */
   /**************************/

   /* Print the initial program remarks */
   generate_initial_comment(info.title,info.author,info.email);

   printf("20 HOME\n");
   printf("30 P%%=0 : TP%%=%d\n",info.slides-1);

   for(i=0;i<info.slides;i++) {
     generate_slide(i,info.slides,slides[i].filename);
   }

   printf("999 END\n");

   generate_keyhandler();
   generate_footer(footer.left,footer.center,40);

   return 0;
}
