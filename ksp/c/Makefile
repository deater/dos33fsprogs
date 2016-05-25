CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

all:	ksp_acpx ksp_launch ksp_loading ksp_vab

ksp_acpx:	ksp_acpx.o
	$(CC) $(LFLAGS) -o ksp_acpx ksp_acpx.o

ksp_acpx.o:	ksp_acpx.c
	$(CC) $(CFLAGS) -c ksp_acpx.c

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
	rm -f *~ *.o ksp_launch ksp_loading ksp_vab ksp_acpx

