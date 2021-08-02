include ../../Makefile.inc

PRODOS = ../../utils/prodos-utils/prodos
TEXT_TO_PRODOS = ../../utils/prodos-utils/text_to_prodos
EMPTY_DISK = ../../empty_disk/empty.po

all:	rr_logo.po

rr_logo.po:	RR
	cp $(EMPTY_DISK) rr_logo.po
	$(PRODOS) -y rr_logo.po VOLNAME RR
	$(PRODOS) -y rr_logo.po SAVE -t TXT RR

####

RR:	rr.logo
	$(TEXT_TO_PRODOS) < rr.logo > RR

####

clean:
	rm -f *~ *.o *.lst RR

