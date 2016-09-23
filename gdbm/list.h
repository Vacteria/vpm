/*
 * sin título.c
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

#include <stddef.h>
#include <stdbool.h>

#ifndef LIST_H
#define LIST_H

typedef struct list list_t;
list_t* new_list(size_t);
bool add_list(list_t*, size_t, void*);
size_t size_list(list_t*);
void* get_list(list_t*, size_t);
bool resize_list(list_t*, size_t);
void destroy_list(list_t*);
#endif
