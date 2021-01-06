/* The following code is UGLY.  Read at your own risk.  --vmw */

#include <stdio.h>
#include <string.h> /* strncpy() */
#include <ctype.h>  /* isdigit() */
#include <fcntl.h>  /* open() */
#include <unistd.h> /* close() */

char dos_color_to_apple[16]=
{0, /* 0 black */
 2, /* 1 blue */
 4, /* 2 green */
 7, /* 3 cyan */
 1, /* 4 red  */
 3, /* 5 purple */ 
 8, /* 6 brown */
 10,/* 7 l grey */
 5, /* 8 d grey */
 6, /* 9 l blue */
12, /*10 l green */
14, /*11 l cyan */
 9, /*12 l red */
11, /*13 pink */
13, /*14 yellow */
15, /* 15 white */
}
;
     
int get_number(char *string, int *pointer) {

    int temp_number;

   
    if (string[*pointer]=='0') {
       
          /* Hexadecimal */
       if (string[*pointer+1]=='x') {
	  (*pointer)++;
	  
	  (*pointer)++;
	  temp_number=0;
	  while(isxdigit(string[*pointer])) {
	     if ((string[*pointer]>='a') && (string[*pointer]<='f')) 
		temp_number=16*temp_number+(10+(string[*pointer]-'a'));
	     if ((string[*pointer]>='A') && (string[*pointer]<='F')) 
		temp_number=16*temp_number+(10+(string[*pointer]-'A'));
	     if ((string[*pointer]>='0') && (string[*pointer]<='9')) 
		temp_number=16*temp_number+(string[*pointer]-'0');
	     (*pointer)++;
	  }
       }
       else {     
	  /* Octal */
          temp_number=0;
          while(isdigit(string[*pointer])) {
             temp_number=8*temp_number+(string[*pointer]-'0');
	     (*pointer)++;
	  }  
       }
       
    }
    else {
       /* Decimal */
       temp_number=0;
       while(isdigit(string[*pointer])) {
          temp_number=10*temp_number+(string[*pointer]-'0');
          (*pointer)++;
       }
    }
     
    return temp_number;
   
}


int main(int argc, char **argv) {

    FILE *input,*output;

    char input_filename[]="sprites";
    int pointer,temp_pointer;
    char input_line[BUFSIZ];
    char temp_string[BUFSIZ];    
    int color=0,oldcolor,run;
   
    input=fopen(input_filename,"r");
    if (input==NULL) goto file_error;
   
   
    while(1) {
	
       if ( fgets(input_line,BUFSIZ,input) ==NULL) goto close_file;
       
       pointer=0;
       
       while(pointer<strlen(input_line)) {
	     /* Comment, we are done */
	  if (input_line[pointer]=='#') goto done_with_string;
	     /* end of line, we are done */
	  if (input_line[pointer]=='\n') goto done_with_string;
	  
	       
	  
	     /* directive */
	  if (input_line[pointer]=='.') {
	     if (!strncmp("byte",input_line+pointer+1,4)) {
		pointer=5;
    
	        printf("\t.byte ");
		while(!isdigit(input_line[pointer])) pointer++;
		color=get_number(input_line,&pointer); 
		while(!isdigit(input_line[pointer])) pointer++;
		oldcolor=color;
		run=1;
		while(pointer<strlen(input_line)) {
		   color=get_number(input_line,&pointer);
		   if ((color!=oldcolor) || (run>14)) {	
		      printf("$%X,",(run<<4)+dos_color_to_apple[oldcolor]);
		      run=0;
		   }
		   run++;
		   oldcolor=color;
		   
		   while(!isdigit(input_line[pointer])) pointer++;
		}
		if (color!=0) {
		   printf("$%X,",(run<<4)+dos_color_to_apple[color]);
		}
		
		
		printf("$00\n");
		goto done_with_string;
	     }
	     
	     else {
		printf("Unknown directive!\n");
		goto close_file;
	     }
	     	     
	  }
	     /* end of label */
	  if (input_line[pointer]==':') {

	     temp_pointer=pointer;
	     while( (temp_pointer>0) &&
		    (input_line[temp_pointer]!='\t') &&
		    (input_line[temp_pointer]!=' ')) temp_pointer--;

	     strncpy(temp_string,input_line+temp_pointer,pointer-temp_pointer);
	     temp_string[pointer]='\0';
	     printf("\t.byte $00\n");
	     printf("%s:\n",temp_string);
	     
	  }
	  
	       
	  
	  
	  pointer++;
       }
done_with_string:       ;
       
       
    }
   

   
close_file:   
    if (input!=NULL) fclose(input);
   
file_error:   
    return 0;
}
