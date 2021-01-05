#include <stdio.h>

int main(int argc, char **argv) {

	long long cycles=0,last=0;
	int x,y;
	int f,d;

	f=76;		// a (should be 440Hz?)
//	f=128;		// c (should be 261Hz?)
	d=108;		// 1/2 note

	x=f;
	y=d;

	while(1) {

//
//  f=1/T
//

//music_loop:
		y--;		//dey                     ; Y never set?
		if (y<0) y=255;
		cycles+=2;

		cycles+=2;
		if (y!=0) {
			cycles++;
			//goto loop;	//bne     loop
		}
		else {
			d--;	// dec     $0301
			cycles+=6;

//			printf("d=%d cycles=%lld\n",d,cycles);

			cycles+=2;
			if (d==0) {        // beq     music_done
				cycles++;
				break;
			}
		}
				// loop
		x--;		// dex
		cycles+=2;

		cycles+=2;
		if (x!=0) {	// bne     music_loop
			cycles++;
			//goto music_loop;
		}
		else {
			x=f;		// ldx     $0300
			cycles+=4;

		        //jmp     click_speaker
			cycles+=3;

			cycles+=4;	//lda     $C030           ; click the speaker
			printf("period=%lld us, f=%lf Hz, should be %lf\n",
				cycles-last,1023000.0/((cycles-last)*2),
				1000000.0/880);
			last=cycles;
		}
	}

	printf("Total cycles: %lld, %lf seconds\n",
		cycles,cycles/1023000.0);

	return 0;

}

