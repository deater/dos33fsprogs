#include <stdio.h>
#include <pcap.h>

int main(int argc, char **argv) {

	char *device_name,errbuf[PCAP_ERRBUF_SIZE];

	pcap_t *handle;

	device_name=pcap_lookupdev(errbuf);
	if (device_name==NULL) {
		fprintf(stderr,"Can't find default device %s\n",errbuf);
		return -1;
	}

	printf("Using device: %s\n", device_name);

	handle=pcap_open_live(device_name, BUFSIZ, 1, 1000, errbuf);
	if (handle==NULL) {
		fprintf(stderr,"Couldn't open device %s: %s\n",
			device_name,errbuf);
		return -1;
	}

	return 0;

}
