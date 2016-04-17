

#if !defined(MAP_FILE)

	#include "map_files\destiny.dmm"
	#include "map_files\z2_destiny.dmm"
	#include "map_files\z3.dmm"
	#define MAP_MODE "standard"
	#define MAP_NAME "Destiny"
	#define MAP_FILE "destiny.dmm"
	#define DESTINY_MODE


#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring destiny.

#endif