#include <stdio.h>
#include <math.h>

int main(int argc, char **argv) {

	int nv,dv;

	for(dv=0;dv<256;dv++) {

		if (dv%16==0) {
			printf(".byte ");
		}
		nv= round(15.0 - ( (log(255.0/dv)) / (log(sqrt(2))) ));

		printf("$%02X",nv);
		if (dv%16==15) {
			printf("\n");
		}
		else {
			printf(",");
		}
	}
	return 0;
}
