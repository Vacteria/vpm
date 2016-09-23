#!/usr/bin/make -f

CC = gcc
CFLAGS = -Wall -ggdb
LDFLAGS = -lgdbm
DEPS  = messages.o list.o gdbm_db.o depends.o main.o
PROGS = vpmqdb

vpmqdb : $(DEPS)
	gcc $(LDFLAGS) $(CFLAGS) -o vpmqdb $(DEPS)
	
all   : $(PROGS)

clean :
	for prog in $(PROGS); do \
		rm -f $$prog; \
	done
	
	rm *.o
