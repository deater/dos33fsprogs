#include <stdio.h>
#include <string.h> /* strlen() */

   /* Starting at 0x80 */
char applesoft_tokens[][8]={
   
/* 80 */ "END","FOR","NEXT","DATA","INPUT","DEL","DIM","READ",
/* 88 */ "GR","TEXT","PR #","IN #","CALL","PLOT","HLIN","VLIN",
/* 90 */ "HGR2","HGR","HCOLOR=","HPLOT","DRAW","XDRAW","HTAB","HOME",
/* 98 */ "ROT=","SCALE=","SHLOAD","TRACE","NOTRACE","NORMAL","INVERSE","FLASH",
/* A0 */ "COLOR=","POP","VTAB ","HIMEM:","LOMEM:","ONERR","RESUME","RECALL",
/* A8 */ "STORE","SPEED=","LET","GOTO","RUN","IF","RESTORE","&",
/* B0 */ "GOSUB","RETURN","REM","STOP","ON","WAIT","LOAD","SAVE",
/* B8 */ "DEF FN","POKE","PRINT","CONT","LIST","CLEAR","GET","NEW",
/* C0 */ "TAB","TO","FN","SPC(","THEN","AT","NOT","STEP",
/* C8 */ "+","-","*","/","^","AND","OR",">",
/* D0 */ "=","<","SGN","INT","ABS","USR","FRE","SCRN (",
/* D8 */ "PDL","POS","SQR","RND","LOG","EXP","COS","SIN",
/* E0 */ "TAN","ATN","PEEK","LEN","STR$","VAL","ASC","CHR$",
/* E8 */ "LEFT$","RIGHT$","MID$","","","","","",
/* F0 */ "","","","","","","","",
/* F8 */ "","","","","","(","(","("
};

#if 0
/* Integer Basic */

char integer_tokens[][8]={   
/* 00 */ "","","",":","LOAD","SAVE","","RUN",
/* 08 */ "","DEL",",","NEW","CLR","AUTO","","MAN",
/* 10 */ "HIMEM:","LOMEM:","+","-","*","/","=","#",
/* 18 */ ">=",">","<=","<>","<"," AND"," OR"," MOD",
/* 20 */ "^","","(",",",""," THEN","",",",
/* 28 */ "\"","\"","(","","","("," PEEK","RND",
/* 30 */ "SGN","ABS","PDL","","(","+","-","NOT",
/* 38 */ "(","=","LEN (","ASC (","SCRN (",","," (",
/* 40 */ "$","(","",",","","",";",
/* 48 */ "",",",",","TEXT","GR","CALL","","DIM",
/* 50 */ "TAB","END","","","INPUT","FOR","=","TO",
/* 58 */ " STEP","NEXT",",","RETURN","GOSUB","REM","LET","GOTO",
/* 60 */ "IF","","PRINT","PRINT","   POKE",",","COLOR=","PLOT",
/* 68 */ ",","HLIN",","," AT","VLIN",","," AT","VTAB",
/* 70 */ "","=",")","","LIST",",","","POP",
/* 78 */ "","NO DSP","NO TRACE","","DSP","TRACE","PR #","IN #"
};
#endif 
		
		
int main(int argc, char **argv) {
   
   int ch1,i;
   int size1,size2;
   int line1,line2;
   int link1,link2,link;
   
   
       /* read size, first two bytes */
   size1=fgetc(stdin);
   size2=fgetc(stdin);
   
   while(!feof(stdin)) {
        
      /* link points to the next line */
      /* assumes asoft program starts at address $801 */
      link1=fgetc(stdin);
      link2=fgetc(stdin);
      link=(link1<<8)|link2;
      /* link==0 indicates EOF */
      if (link==0) goto the_end;
      
      /* line number is little endian 16-bit value */
      line1=fgetc(stdin);
      line2=fgetc(stdin);
      if (feof(stdin)) goto the_end;
      printf("%4d ",((line2)<<8)+line1);
      
      /* repeat until EOL character (0) */
      while( (ch1=fgetc(stdin))!=0 ) {
	     /* if > 0x80 it's a token */
	  if (ch1>=0x80) {
	     fputc(' ',stdout);
	     for(i=0;i<strlen(applesoft_tokens[ch1-0x80]);i++) {
	        fputc(applesoft_tokens[ch1-0x80][i],stdout);
	     }
	     fputc(' ',stdout);
	  }
            /* otherwise it is an ascii char */
	  else {
	     fputc(ch1,stdout);
	  }
	 
      }
      printf("\n");
   }
   the_end:;
   return 0;
}
