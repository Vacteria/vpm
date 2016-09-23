/*
 * gdbm_db.c
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

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <gdbm.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <linux/limits.h>
#include "messages.h"
#include "gdbm_db.h"

bool test_datafile(char mode, const char* datafile)
{
	char fullpath[PATH_MAX+1];
	realpath(datafile,fullpath);
	if (fullpath == NULL)
	{
		perror(datafile);
		return(false);
	}

	int ret = 0;
	switch(mode)
	{
		case 'r' :
			ret = access(fullpath,R_OK);
			break;
		case 'w' :
			ret = access(fullpath,W_OK);
			break;
		case 'e' :
			ret = access(fullpath,F_OK);
			break;
		case '?' :
			msg_unk_mode(mode);
			return(false);
	}
	
	if (ret != 0)
	{
		perror(datafile);
		return(false);
	}
	
	struct stat buf;
	ret = stat(fullpath,&buf);
	
	if ( ret == -1 )
	{
		perror(datafile);
		return(false);
	}
	
	if (!S_ISREG(buf.st_mode))
		return(false);

	return(true);
}

bool create_database(const char* dbfile)
{
	GDBM_FILE dbf;
	dbf = gdbm_open(dbfile, BLOCK_SIZE, GDBM_NEWDB, MODE, NULL);
	gdbm_close(dbf);
	
	return(true);
}

bool insert_record(const char* datafile, list_t* argv)
{
	char* mykey  = get_list(argv,0);
	char* myval  = get_list(argv,1);
	
	if (!test_datafile('w',datafile))
		return(false);
	
	int ret;
	datum key;
	datum value;
	GDBM_FILE dbf;
	
	key.dptr = mykey;
	key.dsize = strlen(mykey)+1; 
	value.dptr = myval;
	value.dsize = strlen(myval)+1;
		
	dbf = gdbm_open(datafile, BLOCK_SIZE, GDBM_WRITER, MODE, NULL);
	ret = gdbm_store(dbf, key, value, GDBM_INSERT);

	if (ret == 1)
	{
		if (quiet == 0)
			fprintf(stderr,_("\"%s\" key alrready exist in database\n"),key.dptr);
		
		return(false);
	}

	gdbm_close(dbf);
	fflush(stderr);
	return(true);
}

bool delete_record(const char* datafile, char* record)
{
	if (!test_datafile('w',datafile))
		return(false);
		
	int ret = 0;
	datum key;
	GDBM_FILE dbf;
	
	key.dptr = record;
	key.dsize = strlen(record)+1;
	
	dbf = gdbm_open(datafile, BLOCK_SIZE, GDBM_WRITER, MODE, NULL);
	if(!gdbm_exists(dbf, key))
	{
		if (quiet == 0)
			fprintf(stderr,_("key \"%s\" does not exists\n"),key.dptr);

		gdbm_close(dbf);
		return(false);
	}
	
	ret = gdbm_delete(dbf, key);
	if ( ret == -1 )
	{
		if (quiet == 0)
			fprintf(stderr,_("Failed to delete %s key\n"),key.dptr);

		gdbm_close(dbf);
		return(false);
	}
			
	gdbm_close(dbf);
	fflush(stderr);
	
	return(true);
}

bool search_record(const char* datafile, char* record)
{
	if (!test_datafile('r',datafile))
		return(false);
		
	datum key;
	datum data;
	GDBM_FILE dbf;
	
	key.dptr = record;
	key.dsize = strlen(record)+1;
	
	dbf = gdbm_open(datafile, BLOCK_SIZE, GDBM_READER, MODE, NULL);
	if(!gdbm_exists(dbf, key))
	{
		if (quiet == 0)
			fprintf(stderr,_("key \"%s\" not found\n"),key.dptr);

		gdbm_close(dbf);
		return(false);
	} else {	
		data = gdbm_fetch(dbf, key);
		if ( quiet == 0 )
			printf("%s|%s\n",key.dptr,data.dptr);
		
		free(data.dptr);
	}
	
	gdbm_close(dbf);
	fflush(stderr);
	
	return(true);
}

bool list_database(const char* datafile)
{
	if (!test_datafile('r',datafile))
		return(false);
	
	GDBM_FILE dbf = gdbm_open(datafile, BLOCK_SIZE, GDBM_READER, MODE, NULL);

	datum key;
	datum nextkey;
	datum data;
			
	key = gdbm_firstkey(dbf);
	while (key.dptr != NULL) 
	{
		nextkey = gdbm_nextkey(dbf,key);
		data = gdbm_fetch(dbf,key);
		printf("%s|%s\n",key.dptr,data.dptr);
		free(data.dptr);
		free(key.dptr);
		key = nextkey;
	}
   
   gdbm_close(dbf);
   return(true);
}
