/*
 * gdbm_db.h
 * 
 * Copyright 2012 Miguel Angel Reynoso <miguel@vacteria.org>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */

#include "list.h"

#ifndef GDBM_DB_H
#define GDBM_DB_H

#define BLOCK_SIZE 512
#define MODE       0644

extern unsigned short int quiet;

bool test_datafile(char, const char*);
bool create_database(const char* dbfile);
bool insert_record(const char*, list_t*);
bool delete_record(const char* datafile, char* key);
bool search_record(const char* datafile, char* record);
bool list_database(const char* datafile);

#endif

