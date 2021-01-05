#include <stdio.h>

int main(int argc, char **argv) {

	int h[7],hpe;
	int sum_a3,sum_a4,sum_a5,sum_a6;
	int v[5],va,vb,vc;
	int a[16],addr,i;
	// hbl = horizontal blanking gate
	int text=1,page1=1,page2=0,hbl=0;
	int vcount=0;
	int vline=0;
	int refresh[128],ra[7],ras,refresh_cycles=0;

	for(i=0;i<128;i++) refresh[i]=0;

	while(1) {
		h[0]=(vcount>>0)&1;
		h[1]=(vcount>>1)&1;
		h[2]=(vcount>>2)&1;
		h[3]=(vcount>>3)&1;
		h[4]=(vcount>>4)&1;
		h[5]=(vcount>>5)&1;
		hpe=(vcount>>6)&1;
		va=(vcount>>7)&1;
		vb=(vcount>>8)&1;
		vc=(vcount>>9)&1;
		v[0]=(vcount>>10)&1;
		v[1]=(vcount>>11)&1;
		v[2]=(vcount>>12)&1;
		v[3]=(vcount>>13)&1;
		v[4]=(vcount>>14)&1;
		v[5]=(vcount>>15)&1;


		/* First 25 cycles */
		hbl=!h[5]&&(!h[3]||!h[4]);

		int x,y,z,sum;
		x=0xd;	// 1101
		y=(h[5]<<2)|(h[4]<<1)|(h[3]);
		z=(v[4]<<3)|(v[3]<<2)|(v[4]<<1)|(v[3]);
		sum=x+y+z;

		sum_a6=(sum>>3)&1;
		sum_a5=(sum>>2)&1;
		sum_a4=(sum>>1)&1;
		sum_a3=(sum)&1;

		a[0]=h[0];
		a[1]=h[1];
		a[2]=h[2];
		a[3]=sum_a3;
		a[4]=sum_a4;
		a[5]=sum_a5;
		a[6]=sum_a6;
		a[7]=v[0];
		a[8]=v[1];
		a[9]=v[2];
		a[10]=text&page1;
		a[11]=text&page2;
		a[12]=text&hbl;
		a[13]=0;
		a[14]=0;
		a[15]=0;

		ra[0]=v[0];
		ra[1]=h[2];
		ra[2]=h[0];
		ra[3]=v[1];
		ra[4]=sum_a3;	// sum0?
		ra[5]=h[1];
		ra[6]=hbl;

		ras=0;
		for(i=0;i<7;i++) ras|=(ra[i]<<i);
//		printf("RAS: %d\n",ras);

		refresh[ras]=1;

		int refreshed=0;
		for(i=0;i<128;i++) refreshed+=refresh[i];
//		printf("REFRESHED= %d\n",refreshed);

		if (refreshed==128) {
			printf("*** DONE REFRESHING %d ***\n",
				refresh_cycles);
			for(i=0;i<128;i++) refresh[i]=0;
			refresh_cycles=0;
		}

		addr=0;
		for(i=0;i<15;i++) addr|=(a[i]<<i);
		printf("%04x ",addr);

		/* horizontal divide by 65 counter */
		/* values are 000.0000 and 100.0000-111.1111 */
		if ((vcount&0x7f)==0) {
			vcount|=0x40;
			printf("\nRestart H, V=%d\n",vline);
			vline++;
		}
		else {
			vcount++;
		}

		/* vertical divide by 262 */
		if ((vcount&0xff80)==0) {
			vcount|=0x7d00; // 0.1111.1010
					// 0111.1101.0000.0000
			vline=0;
			printf("Restart V\n");
		}

		refresh_cycles++;
	}

	return 0;
}
