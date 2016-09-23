/*
 * depends.c
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
#include "depends.h"

list_t* find_and_report(const char* datafile, const char mode, int pkgc, list_t* argv)
{
	// set quiet to avoid print results of search_record()
	unsigned short int hold_quiet=quiet;
	quiet = 1;

	int i=0;
	int found = 0;
	unsigned short int fcount = 0;
	unsigned short int mcount = 0;
	
	list_t* founded = new_list(0);
	list_t* missing = new_list(0);
	
	for (i=0; i<pkgc; i++)
	{	
		char* pkg  = get_list(argv,i);
		char buf[1024];
		strcpy(buf, pkg);
		
		char* tk = strtok(buf, "|");
		while(tk != NULL)
		{
			found = 0;
			if(search_record(datafile, tk))
			{
				found = 1;
				break;
			}
			tk = strtok(NULL, " ,");
		}
	
		if(found == 1)
		{
			fcount = fcount+1;
			resize_list(founded,fcount);
			add_list(founded,fcount-1,tk);
		} else {
			mcount = mcount+1;
			resize_list(missing,mcount);
			add_list(missing,mcount-1,pkg);
		}
	}
	quiet = hold_quiet;
	
	switch(mode)
	{
		case 'f' :
			return(founded);
		case 'm' :
			return(missing);
	}
	
	destroy_list(founded);
	destroy_list(missing);
	return(NULL);
}

bool find_rundeps(const char* datafile, int pkgc, list_t* argv)
{
	int i=0;
	char* pkg = NULL;
	list_t* missing = find_and_report(datafile,'m',pkgc,argv);
	int size = size_list(missing);
	
	if ( size > 0 )
	{
		if (quiet == 0)
		{
			for (i=0; i<size; i++)
			{
				pkg = get_list(missing,i);
				printf("%s ",pkg);
			}
		}
		
		if ( quiet == 0 )
			printf("\n");
			
		destroy_list(missing);
		return(false);
	}
	
	return(true);
}

bool find_conflicts(const char* datafile, int pkgc, list_t* argv)
{
	int i=0;
	char* pkg = NULL;
	list_t* founded = find_and_report(datafile,'f',pkgc,argv);
	int size = size_list(founded);
	
	if ( size > 0 )
	{
		if (quiet == 0)
		{
			for (i=0; i<size; i++)
			{
				pkg = get_list(founded,i);
				printf("%s ",pkg);
			}
		}
		
		if ( quiet == 0 )
			printf("\n");
			
		destroy_list(founded);
		return(false);
	}
	
	return(true);
}
