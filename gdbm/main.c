/*
 * main.c
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
#include <getopt.h>
#include "main.h"
#include "messages.h"
#include "list.h"
#include "gdbm_db.h"
#include "depends.h"

int main(int argc, char **argv)
{
	progname = argv[0];
	setlocale( LC_ALL, "" );
	bindtextdomain( progname, "/usr/share/locale" );
	textdomain(progname);
	
	int next_opt          = 0; 
	unsigned short pkgc   = 0;
	unsigned short action = 0;
	const char* datafile  = NULL;
	
	const char* short_opts="idlscrbChf:q";
	const struct option long_opts[] =
	{
		{"insert",    0, NULL, 'i'},
		{"delete",    0, NULL, 'd'},
		{"list",      0, NULL, 'l'},
		{"search",    0, NULL, 's'},
		{"create",    0, NULL, 'c'},
		{"rundeps",   0, NULL, 'r'},
		{"buildeps",  0, NULL, 'b'},
		{"conflicts", 0, NULL, 'C'},
		{"help",      0, NULL, 'h'},
		{"file",      1, NULL, 'f'},
		{"quiet",     0, NULL, 'q'},
	};
	
	while(1)
	{
		next_opt = getopt_long(argc, argv, short_opts, long_opts, NULL);
		
		if (next_opt == -1)
			break;
		
		switch(next_opt)
		{
			case 'h' :
				action = 1;
				break;
			case 'i' :
				action = 2;
				break;
			case 'd' :
				action = 3;
				break;
			case 'l' :
				action = 4;
				break;
			case 's' :
				action = 5;
				break;
			case 'c' :
				action = 6;
				break;
			case 'r' :
				action = 7;
				break;
			case 'b' :
				action = 8;
				break;
			case 'C' :
				action = 9;
				break;
			case 'f' :
				datafile = optarg;
				break;
			case 'q' :
				quiet = 1;
				break;
			case '?' :
				exit(EXIT_FAILURE);
		}
	}
	
	switch(action)
	{
		case 0 :
			printf(_("No main action selected.\n"));
			exit(EXIT_FAILURE);
		case 1 :
			usage();
			exit(EXIT_SUCCESS);
		default :
			break;
	}
	
	if (datafile == NULL)
	{
		printf(_("%s need a database to work\n"),progname);
		exit(EXIT_FAILURE);
	}
		
	int i=0, c=0;
	pkgc = argc - optind;
	list_t* pkgv = new_list(pkgc);
	
	if (optind < argc && optind > 1)
	{	
		for (i=optind; i<argc; i++)
		{
			add_list(pkgv,c,argv[i]);
			c++;
		}
	}
	
	const char* opt;
	char* record;
	
	switch(action)
	{
		case 2 :
			if (size_list(pkgv) < 2)
			{
				opt = "-i";
				msg_mis_params(opt);
				exit(EXIT_FAILURE);
			}
			if ( !insert_record(datafile,pkgv) )
				return(EXIT_FAILURE);

			break;
		case 3 :
			if (size_list(pkgv) < 1)
			{
				opt = "-d";
				msg_mis_params(opt);
				exit(EXIT_FAILURE);
			}
			record = get_list(pkgv,0);
			if ( !delete_record(datafile,record) )
				return(EXIT_FAILURE);

			break;
		case 4 :
			if ( !list_database(datafile) )
				return(EXIT_FAILURE);

			break;
		case 5 :
			if (size_list(pkgv) < 1)
			{
				const char* opt = "-d";
				msg_mis_params(opt);
				exit(EXIT_FAILURE);
			}
			record = get_list(pkgv,0);
			if ( !search_record(datafile,record) )
				return(EXIT_FAILURE);

			break;
		case 6 :
			if (!create_database(datafile))
				return(EXIT_FAILURE);

			break;
		case 7 :
			if (size_list(pkgv) < 1)
			{
				const char* opt = "-r";
				msg_mis_params(opt);
				exit(EXIT_FAILURE);
			}
			if ( !find_rundeps(datafile,pkgc,pkgv) )
				return(EXIT_FAILURE);
				
			break;
		case 8 :
			if (size_list(pkgv) < 1)
			{
				const char* opt = "-r";
				msg_mis_params(opt);
				exit(EXIT_FAILURE);
			}
			if ( !find_rundeps(datafile,pkgc,pkgv) )
				return(EXIT_FAILURE);
				
			break;
		case 9 :
			if (size_list(pkgv) < 1)
			{
				const char* opt = "-r";
				msg_mis_params(opt);
				exit(EXIT_FAILURE);
			}
			if ( !find_conflicts(datafile,pkgc,pkgv) )
				return(EXIT_FAILURE);

			break;
	}
	
	return 0;
}

