#include <stdio.h>
#include <string.h>

#define NUM_WORDS 75

static char word_list[NUM_WORDS][20]={
	"already","cottage","peasant","There's","Trogdor",
	"little","you're","You're",
	"about","can't","don't","looks","there","There","those",
	"baby","dead","from","game","good","have","here","into","it's","It's","just","like","over","says","some","that","That","this","with","your",
	"all","and","are","but","for","get","got","him","his","not","now","old","one","out","see","the","The","was","you","You",
	"an","at","be","do","go","he","He","in","is","it","It","my","no","No","of","on","or","so","to","up",
};

static char replacement_list[NUM_WORDS][32]={
	"DIALOG_ALREADY",
	"DIALOG_COTTAGE",
	"DIALOG_PEASANT",
	"DIALOG_CAPITAL_THERES",
	"DIALOG_CAPITAL_TROGDOR",

	"DIALOG_LITTLE",
	"DIALOG_YOURE",
	"DIALOG_CAPITAL_YOURE",

	"DIALOG_ABOUT",
	"DIALOG_CANT",
	"DIALOG_DONT",
	"DIALOG_LOOKS",
	"DIALOG_THERE",
	"DIALOG_CAPITAL_THERE",
	"DIALOG_THOSE",

	"DIALOG_BABY",
	"DIALOG_DEAD",
	"DIALOG_FROM",
	"DIALOG_GAME",
	"DIALOG_GOOD",
	"DIALOG_HAVE",
	"DIALOG_HERE",
	"DIALOG_INTO",
	"DIALOG_ITS",
	"DIALOG_CAPITAL_ITS",
	"DIALOG_JUST",
	"DIALOG_LIKE",
	"DIALOG_OVER",
	"DIALOG_SAYS",
	"DIALOG_SOME",
	"DIALOG_THAT",
	"DIALOG_CAPITAL_THAT",
	"DIALOG_THIS",
	"DIALOG_WITH",
	"DIALOG_YOUR",

	"DIALOG_ALL",
	"DIALOG_AND",
	"DIALOG_ARE",
	"DIALOG_BUT",
	"DIALOG_FOR",
	"DIALOG_GET",
	"DIALOG_GOT",
	"DIALOG_HIM",
	"DIALOG_HIS",
	"DIALOG_NOT",
	"DIALOG_NOW",
	"DIALOG_OLD",
	"DIALOG_ONE",
	"DIALOG_OUT",
	"DIALOG_SEE",
	"DIALOG_THE",
	"DIALOG_CAPITAL_THE",
	"DIALOG_WAS",
	"DIALOG_YOU",
	"DIALOG_CAPITAL_YOU",

	"DIALOG_AN",
	"DIALOG_AT",
	"DIALOG_BE",
	"DIALOG_DO",
	"DIALOG_GO",
	"DIALOG_HE",
	"DIALOG_CAPITAL_HE",
	"DIALOG_IN",
	"DIALOG_IS",
	"DIALOG_IT",
	"DIALOG_CAPITAL_IT",
	"DIALOG_MY",
	"DIALOG_NO",
	"DIALOG_CAPITAL_NO",
	"DIALOG_OF",
	"DIALOG_ON",
	"DIALOG_OR",
	"DIALOG_SO",
	"DIALOG_TO",
	"DIALOG_UP",

};


static int char_count=0,orig_count=0;

void parse_line(char *string) {
	int len;
	int i,j;
	int in_string=0;
	int in_quote=0;
	int dotfound=0,bfound=0,yfound=0,tfound=0,efound=0;

	len=strlen(string);

	for(i=0;i<len;i++) {

		if ((!in_string) && (!in_quote)) {
			if (string[i]=='.') dotfound=1;
			else if ((dotfound)&&(string[i]=='b')) bfound=1;
			else if ((bfound)&&(string[i]=='y')) yfound=1;
			else if ((yfound)&&(string[i]=='t')) tfound=1;
			else if ((tfound)&&(string[i]=='e')) efound=1;
			else {
				dotfound=0;
				bfound=0;
				yfound=0;
				tfound=0;
				efound=0;
			}

			if (efound) {
				in_string=1;
			}
		}

		if (in_string) {
			if (!in_quote) {
				if (string[i]=='\"') {
					in_quote=1;
				}
			}
			else {
				/* in quote */
				if (string[i]=='\"') {
					in_quote=0;
				}
				else {
					orig_count++;
					char_count++;
				}
			}

			for(j=0;j<NUM_WORDS;j++) {
				if (!strncmp(&string[i],word_list[j],
					strlen(word_list[j]))) {

//					printf("MATCH %s%d %s%d\n",
//						&string[i],i,word_list[j],j);

					printf("\",%s,\"",replacement_list[j]);
					orig_count+=strlen(word_list[j]);
					i+=strlen(word_list[j]);
				}
			}
		}

		printf("%c",string[i]);

	}

}

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;
	int length_of_table=0;
	int i;

	for(i=0;i<NUM_WORDS;i++) {
		length_of_table+=strlen(word_list[i]);
	}

	while(1) {

		result=fgets(string,BUFSIZ,stdin);
		if (result==NULL) break;

		parse_line(string);

	}

	printf("; Done!  rough char count = %d, rough orig count = %d length_of_table = %d\n",
		char_count, orig_count, length_of_table);

}
