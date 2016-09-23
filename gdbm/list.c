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

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "list.h"

/* 
 * Struc to save vector elemnts and index number. The alias for this
 * struct is defined as list_t data type
*/
struct list
{
	size_t size;
	void** vector;
};

/* 
 * This function create a new dinamic list with especified size
*/
list_t* new_list(size_t size)
{
	list_t* list = malloc(sizeof(list_t));		
	list->size = size;
	list->vector = malloc(sizeof(void**)*size);
	
	int i;
	for (i=0; i<size; i++)
	{
		list->vector[i] = NULL;
	}
	
	return(list);
}

/* Add an element to a especified dinamic list.*/
bool add_list(list_t* list, size_t index, void* member)
{
	if (index < 0 || index >= list->size) return(false);
	
	list->vector[index]=member;
	
	return(true);
}

/* Return a size of especified dinamic list */
size_t size_list(list_t* list)
{
	return(list->size);
}

/* Return a member list for especified index */
void* get_list(list_t* list, size_t index)
{
	if (index < 0 || index >= list->size) return(NULL);
	
	return(list->vector[index]);
}

/* Rezise an especified dinamic list using new size especified */
bool resize_list(list_t* list, size_t new_size)
{	
	if (new_size < 0 || new_size < list->size) return(false);
		
	void** new_vector = realloc(list->vector,new_size*sizeof(void*));	
	if ( new_vector == NULL ) return(false);

	//free(list->vector);

	list->vector = new_vector;
	list->size = new_size;
	
	return(true);
}

/* Destroy a dinamic list */
void destroy_list(list_t* list)
{
	free(list->vector);
	free(list);
}
