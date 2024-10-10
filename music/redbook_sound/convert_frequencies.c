#include <stdio.h>

int main(int argc, char **argv) {

	int final,count=1,frequency;
	int result;

	while(1) {
		result=scanf("%d",&frequency);
		if (result<1) break;


		final=(int)(1.0/(
			(20.0*(1.023e-6)*frequency)-17*1.023e-6));

		printf(".byte %d,%d\t; %.1lf\n",
                                        final,count,(double)frequency);

	}
	return 0;
}
