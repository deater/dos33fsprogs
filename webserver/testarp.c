#include <stdio.h>
#include <pcap.h>

int main(int argc, char **argv) {

	char *device_name,errbuf[PCAP_ERRBUF_SIZE];

	device_name=pcap_lookupdev(errbuf);
	if (device_name==NULL) {
		fprintf(stderr,"Can't find default device\n");
		return -1;
	}

	printf("Using device: %s\n", device_name);

	return 0;

}
