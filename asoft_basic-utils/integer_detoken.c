#include <stdio.h>
#include <string.h> /* strlen()  */
#include <ctype.h>  /* isalnum() */

#include "version.h"

/* with help from code by Paul Schlyter */

/* detokenizes Apple 2 integer basic programs */
/* re-tokenizing is hard, as some with same name */
/*   such as PRINT have different tokens depending */
/*   on arguments                                  */

/* Integer Basic */
char integer_tokens[128][8]={   

/* 00 */ "HIMEM:", "<$01>",  "_",      ":", 
         "LOAD ",  "SAVE ",  "CON ",   "RUN",   /* direct */
/* 08 */ "RUN",    "DEL ",   ",",      "NEW", 
         "CLR",    "AUTO",   ",",      "MAN",
/* 10 */ "HIMEM:", "LOMEM:", "+",      "-",     /* binary */
         "*",      "/",      "=",      "#",
/* 18 */ ">=",     ">",      "<=",     "<>",
         "<",      " AND ",  " OR ",   " MOD ",
/* 20 */ "^",      "+",      "(",      ",",
         " THEN ", " THEN ", ",",      ",",
/* 28 */ "\"",     "\"",     "(",      "!",
         "!",      "(",      " PEEK ", "RND",
/* 30 */ "SGN",    "ABS",    "PDL",    "RNDX",
         "(",      "+",      "-",      " NOT ", /* unary */
/* 38 */ "(",      "=",      "#",      "LEN(",
         "ASC(",   "SCRN(",  ",",      "(",
/* 40 */ "$",      "$",      "(",      ",",
         ",",      ";",      ";",      ";",
/* 48 */ ",",      ",",      ",",      "TEXT",  /* Statements */
         "GR",     "CALL ",  "DIM ",   "DIM ",
/* 50 */ "TAB ",   "END",    "INPUT ", "INPUT ",
         "INPUT ", "FOR ",   "=",      " TO ",
/* 58 */ "STEP ",  "NEXT ",  ",",      "RETURN",
         "GOSUB ", "REM ",   "LET ",   "GOTO ",
/* 60 */ "IF ",    "PRINT ", "PRINT ", "PRINT ",
         "POKE ",  ",",      "COLOR=", "PLOT ",
/* 68 */ ",",      "HLIN ",  ",",      " AT ",
         "VLIN ",  ",",      " AT ",   "VTAB ",
/* 70 */ "=",      "=",      ")",      ")",
         "LIST",   ",",      "LIST",   "POP",
/* 78 */ "NODSP",  "DSP",    "NOTRACE","DSP",
         "DSP",    "TRACE",  "PR#",    "IN#"
};


#define REM_TOKEN   0x5D
#define UNARY_PLUS  0x35
#define UNARY_MINUS 0x36
#define QUOTE_START 0x28
#define QUOTE_END   0x29


int main(int argc, char **argv) {
   
   int ch1;
   int size1,size2;
   int line_length;
   int line1,line2;
   int int1,int2;
   int in_rem=0,in_quote=0,last_was_alpha=0,last_was_token=0;
   int debug=0;
   
       /* read size, first two bytes */
   size1=fgetc(stdin);
   size2=fgetc(stdin);
   if (debug) fprintf(stderr,"Sign bytes: %x %x\n",size1,size2);

   while(!feof(stdin)) {

      in_rem=0;
      in_quote=0;
      last_was_alpha=0;
      last_was_token=0;
      
      line_length=fgetc(stdin);
      if (debug) fprintf(stderr,"Line length: %d\n",line_length);

      /* line number is little endian 16-bit value */
      line1=fgetc(stdin);
      line2=fgetc(stdin);
      if (feof(stdin)) goto the_end;
      printf("%4d ",((line2)<<8)+line1);
      
      /* repeat until EOL character (1) */
      while( (ch1=fgetc(stdin))!=0x1 ) {
	 
	     /* if < 0x80 it's a token */
	  if (ch1<0x80) {
	     printf("%s",integer_tokens[ch1]);
	     if (ch1==REM_TOKEN) in_rem=1;
	     if (ch1==QUOTE_START) in_quote=1;
	     if (ch1==QUOTE_END) in_quote=0;	     
	     last_was_alpha=0;
	     last_was_token=1;
	  }
            /* integer contant */
	  else if ((!in_rem) && (!in_quote) && (!last_was_alpha) &&
		   (ch1>=0xb0) && (ch1<=0xb9)) {
	     int1=fgetc(stdin);
	     int2=fgetc(stdin);
	     
	     printf("%d",(int2<<8)+int1);	     
	     last_was_token=0;
	  }
	    /* otherwise it is an ascii char */
	  else {	     
	     fputc(ch1&0x7f,stdout);
	     last_was_alpha=isalnum(ch1&0x7f);
	     last_was_token=0;
	  }
	 
      }
      printf("\n");
   }
   if (debug) fprintf(stderr,"Last was token: %d\n",last_was_token);
   the_end:;
   return 0;
}
