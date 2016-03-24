
#if !defined(MAP_FILE)

	#include "map_files\construction_shuttle.dmm"
	#include "map_files\z2.dmm"
	#include "map_files\z3.dmm"
	#define MAP_MODE "construction"
	#define MAP_NAME "Construction"
	#define MAP_FILE "construction_shuttle.dmm"

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring construction.

#endif