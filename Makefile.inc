CC = gcc
CFLAGS = -O2 -Wall $(shell pkg-config --cflags libpng liblz4)
LFLAGS = $(shell pkg-config --libs libpng liblz4)

INSTALL_LOC = /usr/local/bin
