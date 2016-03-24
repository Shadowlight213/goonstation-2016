

#if !defined(MAP_FILE)

	#include "map_files\cogmap.dmm"
	#include "map_files\z2_cog1.dmm"
	#include "map_files\z3.dmm"
	#define MAP_MODE "standard"
	#define MAP_NAME "Cogmap1"
	#define MAP_FILE "cogmap.dmm"

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring cogmap.

#endif