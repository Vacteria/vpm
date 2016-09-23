/*
 * messages.c
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
#include "messages.h"

void usage(void)
{
	printf(_(
	"vpmqdb is a vpm query local database information for Vacteria GNU/Linux\n"
	"\n"
	"Usage :\n"
	" vpmqd [arguments] [parameters]\n"
	"\n"
	"Arguments :\n"
	" -i, --insert     Insert a record in database, take key/value as parameters\n"
	" -d, --delete     Delete record for database only take key as parameter\n"
	" -l, --list       List all record in database\n"
	" -s, --search     Search record across database\n"
	" -c, --create     Create new empty database. If this exist override them\n"
	" -r, --rundeps    Find package rundeps into database\n"
	" -b, --buildeps   Find package buildeps into database\n"
	" -C, --conflicts  Find package conflicts into database\n"
	" -f, --file       Set database file or path to use\n"
	" -q, --quiet      Only show fatal warnings\n"
	" -h, --help       Show this help and exit\n"
	"\n"
	));
}

void msg_mis_params(const char* opt)
{
	fprintf(stderr,_("Missing parameters for \"%s\" option\n"),opt);
}

void msg_unk_mode(char mode)
{
	fprintf(stderr,_("Unknow \"%c\" mode"),mode);
}
