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

/*
Integer Basic

         $03: :
         $04: LOAD
         $05: SAVE
         $07: RUN
         $09: DEL
         $0A: ,
         $0B: NEW
         $0C: CLR
         $0D: AUTO
         $0F: MAN
         $10: HIMEM:
         $11: LOMEM:
         $12: +
         $13: -
         $14: *
         $15: /
         $16: =
         $17: #
         $18: >=
         $19: >
         $1A: <=
         $1B: <>
         $1C: <
         $1D:  AND
         $1E:  OR
         $1F:  MOD
         $20: ^
         $22: (
         $23: ,
         $24,
         $25:  THEN
         $26,
         $27: ,
         $28, $29: \"
         $2A: (
         $2D: (
         $2E:  PEEK
         $2F: RND
         $30: SGN
         $31: ABS
         $32: PDL
         $34: (
         $35: +
         $36: -
         $37: NOT
         $38: (
         $39: =
         $3A: #
         $3B: LEN (
         $3C: ASC (
         $3D: SCRN (
         $3E: ,
         $3F:  (
         $40: $
         $42: (
         $43,
         $44: ,
         $45,
         $46,
         $47: ;
         $48,
         $49: ,
         $4A: ,
         $4B: TEXT
         $4C: GR
         $4D: CALL
         $4E,
         $4F: DIM
         $50: TAB
         $51: END
         $52,  $53,  $54: INPUT
         $55: FOR
         $56:  =
         $57:  TO
         $58:  STEP
         $59: NEXT
         $5A: ,
         $5B: RETURN
         $5C: GOSUB
         $5D: REM
         $5E: LET
         $5F: GOTO
         $60: IF
         $61,
         $62: PRINT
         $63: PRINT
         $64:    POKE
         $65: ,
         $66: COLOR=
         $67: PLOT
         $68: ,
         $69: HLIN
         $6A: ,
         $6B:  AT
         $6C: VLIN
         $6D: ,
         $6E:  AT
         $6F: VTAB
         $70,
         $71:  =
         $72: )
         $74: LIST
         $75: ,
         $77: POP
         $79: NO DSP
         $7A: NO TRACE
         $7B,
         $7C: DSP
         $7D: TRACE
         $7E: PR #
         $7F: IN #

*/
		
		
int main(int argc, char **argv) {
   
   int ch1,i;
   unsigned char size1,size2;
   unsigned char line1,line2;
   unsigned char eight,line_length;
   
   
       /* read size, first two bytes */
   size1=fgetc(stdin);
   size2=fgetc(stdin);
   
   while(!feof(stdin)) {
  
      
      line_length=fgetc(stdin);
      eight=fgetc(stdin);   /* sometimes 8, sometimes 9? */
      if (eight==0) goto the_end;
      line1=fgetc(stdin);
      line2=fgetc(stdin);
      if (feof(stdin)) goto the_end;
      printf("%4d ",(((int)line2)<<8)+line1);
	
      while( (ch1=fgetc(stdin))!=0 ) {
	  if (ch1>=0x80) {
	     fputc(' ',stdout);
	     for(i=0;i<strlen(applesoft_tokens[ch1-0x80]);i++) {
	        fputc(applesoft_tokens[ch1-0x80][i],stdout);
	     }
	     fputc(' ',stdout);
	  }
          else fputc(ch1,stdout);
      }
      printf("\n");
   }
   the_end:;
   return 0;
}
