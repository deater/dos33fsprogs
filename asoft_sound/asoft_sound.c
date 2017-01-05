#include <stdio.h>
#include <string.h>

static int line=0;


static int get_freq(int note, int octave, int flat, int sharp) {

	if (octave==0) {

	switch(note) {
		case 'A':
			if (sharp) return 143;
			if (flat) return 161;
			return 152;
		case 'B':
			if (flat) return 143;
			return 135;
		case 'C':
			if (sharp) return 241;
			return 255;
		case 'D':
			if (sharp) return 214;
			if (flat) return 241;
			return 227;
		case 'E':
			if (flat) return 214;
			return 202;
		case 'F':
			if (sharp) return 180;
			return 191;
		case 'G':
			if (sharp) return 161;
			if (flat) return 180;
			return 170;
		default: fprintf(stderr,"Unknown note %c Line %d\n",
					note,line);
	}

	} else

	if (octave==1) {

	switch(note) {
		case 'A':
			if (sharp) return 72;
			if (flat) return 81;
			return 76;
		case 'B':
			if (flat) return 72;
			return 68;
		case 'C':
			if (sharp) return 121;
			return 128;
		case 'D':
			if (sharp) return 108;
			if (flat) return 121;
			return 114;
		case 'E':
			if (flat) return 108;
			return 102;
		case 'F':
			if (sharp) return 91;
			return 96;
		case 'G':
			if (sharp) return 81;
			if (flat) return 91;
			return 85;
		default: fprintf(stderr,"Unknown note %c\n",note);
	}
	} else

	if (octave==2) {

	switch(note) {
		case 'A':
			if (sharp) return 36;
			if (flat) return 40;
			return 38;
		case 'B':
			if (flat) return 36;
			return 34;
		case 'C':
			if (sharp) return 60;
			return 64;
		case 'D':
			if (sharp) return 54;
			if (flat) return 60;
			return 57;
		case 'E':
			if (flat) return 54;
			return 51;
		case 'F':
			if (sharp) return 45;
			return 48;
		case 'G':
			if (sharp) return 40;
			if (flat) return 45;
			return 43;
		default: fprintf(stderr,"Unknown note %c\n",note);
	}

	} else {
		fprintf(stderr,"Unknown octave %d!\n",octave);
	}

	return 0;
}

static int get_duration(int length) {

	int d=0;

	if (length==2) {
		d=216;
	} else if (length==4) {
		d=108;
	} else if (length==8) {
		d=54;
	} else if (length==16) {
		d=27;
	} else if (length==3) {
		d=162;
	} else {
		fprintf(stderr,"Unknown duration %d Line %d\n",length,line);
	}

	return d;
}

static int get_rest(int length) {

	int rest=0;

	switch(length) {
		case 1:	rest=128; break;
		case 2: rest=64; break;
		case 4: rest=32; break;
		case 8: rest=16; break;
		case 16: rest=8; break;
		default: fprintf(stderr,"Unknown rest length %d Line %d!\n",
				length,line);
	}

	return rest*5;
}

int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;
	int basic_line=100;
	int i;
	int length=8,last_length=0,duration;
	int rest_length,sharp,flat;
	int octave=1;
	int freq;
	int note;

	/* Routine from http://eightbitsoundandfury.ld8.org/programming.html */
	printf("40 FOR L = 770 TO 790: READ V: POKE L,V: NEXT L\n");
	printf("41 DATA 173,48,192,136,208,5,206,1,3,240,9\n");
	printf("42 DATA 202,208,245,174,0,3,76,2,3,96\n");
	printf("43 GOTO 100\n");


	/* Improved by Carlsson */
	/* http://atariage.com/forums/topic/246369-music-in-applesoft-basic/ */
	printf("50 DATA 173,48,192,174,0,3,202,240,247,234,234,136,208,248,206,1,3,208,243,96\n");
	printf("51 FOR L=770 TO 789:READ V:POKE L,V:NEXT L\n");
	printf("52 GOTO 100\n");

	/* Lighter/faster by Carlsson */
	printf("60 DATA 173,48,192,174,0,3,202,240,247,234,136,208,249,206,1,3,208,244,96\n");
	printf("61 FOR L=770 TO 788:READ V:POKE L,V:NEXT L\n");
	printf("62 GOTO 100\n");

	/* Darker/lower by Calsson */
	printf("70 DATA 173,48,192,174,0,3,202,240,247,234,234,234,136,208,247,206,1,3,208,242,96\n");
	printf("71 FOR L=770 TO 790:READ V:POKE L,V:NEXT L\n");
	printf("72 GOTO 100\n");

	/* Violin sound: https://gist.github.com/thelbane/9291cc81ed0d8e0266c8 */
	printf("80 DATA 172,1,3,173,0,3,133,250,174,0,3,228,250,208,3,173,48,"
			"192,202,208,246,173,48,192,136,240,7,198,250,208,"
			"233,76,5,3,96\n");
	printf("81 FOR L=770 TO 804:READ V:POKE L,V:NEXT L\n");
	printf("82 GOTO 100\n");

	printf("90 POKE 768,F:POKE 769,D:CALL 770:RETURN\n");

	while(1) {
		result=fgets(string,BUFSIZ,stdin);
		line++;
		if (result==NULL) break;

		if (string[0]=='\'') continue;

		i=0;
		while(1) {

			if (string[i]=='\n') break;
			if (string[i]=='\0') break;
			if ((string[i]==' ') || (string[i]=='\t')) {
				i++;
				continue;
			}

			if (string[i]=='<') {
				octave--;
			}
			else if (string[i]=='>') {
				octave++;
			}
			else if (string[i]=='L') {
				i++;
				length=string[i]-'0';
				if ((length==1) && (string[i+1]=='6')) {
					length=16;
					i++;
				}
			}
			else if (string[i]=='R') {
				i++;
				rest_length=get_rest(string[i]-'0');
				printf("%d FOR I=1 TO %d: NEXT I\n",
					basic_line,rest_length);
				basic_line++;
			}
			else if ((string[i]>='A') && (string[i]<='G')) {
				sharp=0; flat=0;
				note=string[i];
				if (string[i+1]=='#') {
					sharp=1;
					i++;
				}
				if (string[i+1]=='-') {
					flat=1;
					i++;
				}
				printf("%d ",basic_line);
				if (length!=last_length) {
					duration=get_duration(length);
					printf("D=%d:",duration);
					last_length=length;
				}

				freq=get_freq(note,octave,flat,sharp);

				printf("F=%d:GOSUB 90\n",freq);
				basic_line++;
			}
			else {
				fprintf(stderr,"Unknown char %c\n",string[i]);
			}
			i++;

		}
	}

	return 0;
}
