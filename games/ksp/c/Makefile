CC = gcc
CFLAGS = -Wall -O2
LFLAGS = -lm

all:	ksp_acpx ksp_atan ksp_drag ksp_launch ksp_loading ksp_vab

ksp_acpx:	ksp_acpx.o
	$(CC) $(LFLAGS) -o ksp_acpx ksp_acpx.o

ksp_acpx.o:	ksp_acpx.c
	$(CC) $(CFLAGS) -c ksp_acpx.c

ksp_atan:	ksp_atan.o
	$(CC) $(LFLAGS) -o ksp_atan ksp_atan.o

ksp_atan.o:	ksp_atan.c
	$(CC) $(CFLAGS) -c ksp_atan.c

ksp_drag:	ksp_drag.o
	$(CC) $(LFLAGS) -o ksp_drag ksp_drag.o

ksp_drag.o:	ksp_drag.c
	$(CC) $(CFLAGS) -c ksp_drag.c

ksp_launch:	ksp_launch.o
	$(CC) $(LFLAGS) -o ksp_launch ksp_launch.o -lm

ksp_launch.o:	ksp_launch.c
	$(CC) $(CFLAGS) -c ksp_launch.c

ksp_loading:	ksp_loading.o
	$(CC) $(LFLAGS) -o ksp_loading ksp_loading.o

ksp_loading.o:	ksp_loading.c
	$(CC) $(CFLAGS) -c ksp_loading.c

ksp_vab:	ksp_vab.o
	$(CC) $(LFLAGS) -o ksp_vab ksp_vab.o

ksp_vab.o:	ksp_vab.c
	$(CC) $(CFLAGS) -c ksp_vab.c


clean:	
	rm -f *~ *.o ksp_launch ksp_loading ksp_vab ksp_acpx ksp_drag ksp_atan

