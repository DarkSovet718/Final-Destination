#define SHIP_SIZE_TINY	1
#define SHIP_SIZE_SMALL	2
#define SHIP_SIZE_LARGE	3

//multipliers for max_speed to find 'slow' and 'fast' speeds for the ship
#define SHIP_SPEED_SLOW  1/(40 SECONDS)
#define SHIP_SPEED_FAST  1/(5 SECONDS)

#define OVERMAP_WEAKNESS_NONE 0
#define OVERMAP_WEAKNESS_FIRE 1
#define OVERMAP_WEAKNESS_EMP 2
#define OVERMAP_WEAKNESS_MINING 4
#define OVERMAP_WEAKNESS_EXPLOSIVE 8
#define OVERMAP_WEAKNESS_DROPPOD 16
#define OVERMAP_WEAKNESS_BLUESPACE 32
#define OVERMAP_WEAKNESS_WORM 64

#define TARGET_SHIP 0
#define TARGET_MISSILE 1
#define TARGET_PLANET 2
#define TARGET_PLANETCOORD 4
#define TARGET_POINT 8
//#define SENSOR_COEFFICENT 1000