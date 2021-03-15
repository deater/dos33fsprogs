#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define OFFSET	32
#define OFFSET2	35

//#define OFFSET	35

static int hex2int(int val) {

	if ((val>='0') && (val<='9')) return val-'0';
	if ((val>='A') && (val<='F')) return (val-'A')+10;
	if ((val>='a') && (val<='f')) return (val-'a')+10;

	printf("Unknown: %c %d\n",val,val);
	return -1;
}

int main(int argc, char **argv) {

	int i = 0;
	int e = 0,filesize;
	int val,pv,final;
	unsigned char in[1024];
	unsigned char enc[1024],enc2[1024];
	int third,enc_ptr=0;
	char string[256];
	char *result;
	int op=0;

	memset(in,0,sizeof(in));

	while(1) {
		result=fgets(string,256,stdin);
		if (result==NULL) break;

		for(i=0;i<strlen(string);i++) {
			if (string[i]=='$') {
				in[op]=(hex2int(string[i+1])<<4)+hex2int(string[i+2]);
				op++;
			}
		}
	}
	filesize=op;

	i=0;

	do {
		third = ((in[i + 2] & 3) << 4) +
			((in[i + 1] & 3) << 2) + (in[i + 0] & 3);
		enc[e++]=third+OFFSET2;
		if (i<filesize) {
			val=in[i+0];
			pv=val;
			val=val+0x40;
			val-=third;
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+third-0x40;
			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i,pv,val,third,final);
			if (pv!=final) fprintf(stderr,"error0: no match!\n");
			if (val<0) fprintf(stderr,"error0, negative! in=%x e=%x val=%x\n",
				in[i+0],third,val);
			if (val<0x20) fprintf(stderr,"error0, unprintable! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
			if (val>0x7e) fprintf(stderr,"error0, too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
//			printf("%c",val); //(in[i + 0] >> 2) + OFFSET);
			//printf("%c",val); //(in[i + 0] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
		if (i + 1 < filesize) {
			val=in[i+1];
			pv=val;
			val=val+0x40;
			val-=(third>>2);
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+(third>>2)-0x40;

			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i+1,pv,val,third>>2,final);
			if (pv!=final) fprintf(stderr,"error1: no match!\n");
			if (val<0) fprintf(stderr,"error1, negative! %x %x\n",
				in[i+0]&0xfc,third);
			if (val<0x20) fprintf(stderr,"error1, unprintable! %x %x\n",
				in[i+0]&0xfc,third);
			if (val>0x7e) fprintf(stderr,"error1, too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
//			printf("%c",val); //(in[i + 1] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
		if (i + 2 < filesize) {
			val=in[i+2];
			pv=val;
			val=val+0x40;
			val-=(third>>4);
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+(third>>4)-0x40;
			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i+2,pv,val,third>>4,final);
			if (pv!=final) fprintf(stderr,"error2: no match!\n");
			if (val<0) fprintf(stderr,"error2, negative! %x %x\n",
				in[i+0]&0xfc,third);
			if (val<0x20) fprintf(stderr,"error2, unprintable! %x %x\n",
				in[i+0]&0xfc,third);
			if (val>0x7e) fprintf(stderr,"error2 too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
//			printf("%c",val);//(in[i + 2] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
	} while ((i += 3) < filesize);

	enc[e]=0;
	enc2[enc_ptr]=0;

	printf("%s%s\n",enc2,enc);

	return 0;
}
