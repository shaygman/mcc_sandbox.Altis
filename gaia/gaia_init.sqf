/*
  Created by Spirit, 5-1-2014

*/

GAIA_INIT = FALSE;

GAIA_scripts 	= format ["%1gaia\scripts\",MCC_path];
GAIA_fsm 		= format ["%1gaia\fsm\",MCC_path];

//GAIA Public (local) variables
MCC_GAIA_DEBUG						= false;
MCC_GAIA_CA_DEBUG					= [];


MCC_GAIA_CACHE						= false;
GAIA_CACHE_SLEEP					= 0.5;

GAIA_CACHE_STAGE_2				= (2*(missionNamespace getVariable ["GAIA_CACHE_STAGE_1",1000]));
MCC_GAIA_CACHE_STAGE2			= [];




// dont CHANGE without knowledge
MCC_GAIA_OPERATIONAL 			= false;

//Used for the breadcrumb blacklist system. How far should a waypoint be from a position a unit has last been?
MCC_GAIA_CYCLE								 = 1;
MCC_GAIA_CA_SIZE					=200;
MCC_GAIA_AWARENESSRANGE				 = 100;
MCC_GAIA_CLEARRANGE						 = 70;
MCC_GAIA_SHARETARGET_DELAY		 = 10;
MCC_GAIA_MAX_SLOW_SPEED_RANGE  = 600;
MCC_GAIA_MAX_MEDIUM_SPEED_RANGE= 4500;
MCC_GAIA_MAX_FAST_SPEED_RANGE  = 80000;
// The seconds of rest a transporter takes after STARTING his last order
MCC_GAIA_TRANSPORT_RESTTIME		= 40;
//If an order is older then 10 minutes, cancel it. There is probbaly something wrong.
MCC_GAIA_MAX_ORDER_AGE				 = 5000;
MCC_GAIA_MORTAR_TIMEOUT				 = 1;
//This switch makes it possible for GAIA to send units into the attack she does not initialy control
MCC_GAIA_ATTACKS_FOR_NONGAIA	 = false;

//Ambient Combat
//<<<<<<< HEAD
MCC_GAIA_AC										 = false;
MCC_GAIA_AC_MAXRANGE			 		 = 1000;
MCC_GAIA_AC_MAXGROUPS						= 35;
//=======
MCC_GAIA_AMBIANT_COMBAT				 = true;
MCC_GAIA_AMBIENT_minRange			 = 800;
MCC_GAIA_AMBIENT_maxRange 		 = 1000;
//>>>>>>> parent of f16fa86... Refactoring of GAIA cache functions
MCC_GAIA_AMBIENT_ZONE_RESERVED = 1000;

//Side specific
MCC_GAIA_CA_WEST					= [];
MCC_GAIA_CA_EAST					= [];
MCC_GAIA_CA_INDEP					= [];
MCC_GAIA_CA_CIV						= [];
MCC_GAIA_ZONES_INDEP			= [];
MCC_GAIA_ZONES_CIV				= [];
MCC_GAIA_ZONES_POS_INDEP	= [];
MCC_GAIA_ZONES_POS_CIV		= [];
MCC_GAIA_ZONES_EAST				= [];
MCC_GAIA_ZONES_POS_EAST		= [];
MCC_GAIA_ZONES_WEST				= [];
MCC_GAIA_ZONES_POS_WEST		= [];
MCC_GAIA_GROUPS_WEST			= [];
MCC_GAIA_GROUPS_EAST			= [];
MCC_GAIA_GROUPS_INDEP			= [];
MCC_GAIA_GROUPS_CIV				= [];
MCC_GAIA_BREADCRUMBS_WEST	= [];
MCC_GAIA_BREADCRUMBS_EAST	= [];
MCC_GAIA_BREADCRUMBS_INDEP= [];
MCC_GAIA_BREADCRUMBS_CIV= [];
MCC_GAIA_WPPOS_WEST				= [];
MCC_GAIA_WPPOS_EAST				= [];
MCC_GAIA_WPPOS_INDEP			= [];
MCC_GAIA_WPPOS_CIV				= [];
MCC_GAIA_FACTIONS_WEST		= [];
MCC_GAIA_FACTIONS_EAST		= [];
MCC_GAIA_FACTIONS_INDEP		= [];
MCC_GAIA_FACTIONS_CIV 		= [];
MCC_GAIA_ZONESTATUS_WEST	=	[]; for "_i" from 0 to 90 do  { MCC_GAIA_ZONESTATUS_WEST set [_i,"0"];};
MCC_GAIA_ZONESTATUS_EAST	=	[]; for "_i" from 0 to 90 do  { MCC_GAIA_ZONESTATUS_EAST set [_i,"0"];};
MCC_GAIA_ZONESTATUS_INDEP	=	[]; for "_i" from 0 to 90 do  { MCC_GAIA_ZONESTATUS_INDEP set [_i,"0"];};
MCC_GAIA_ZONESTATUS_CIV		=	[]; for "_i" from 0 to 90 do  { MCC_GAIA_ZONESTATUS_INDEP set [_i,"0"];};
MCC_GAIA_TARGETS_WEST			= []; for "_i" from 0 to 90 do  { MCC_GAIA_TARGETS_WEST set [_i,[]];};
MCC_GAIA_TARGETS_EAST			= []; for "_i" from 0 to 90 do  { MCC_GAIA_TARGETS_EAST set [_i,[]];};
MCC_GAIA_TARGETS_INDEP		= []; for "_i" from 0 to 90 do  { MCC_GAIA_TARGETS_INDEP set [_i,[]];};
MCC_GAIA_TARGETS_CIV			= []; for "_i" from 0 to 90 do  { MCC_GAIA_TARGETS_INDEP set [_i,[]];};




//We spawn GAIA for each side (but dont worry, it will only be really active if there are units.)
//Still a smarter solution is welcome.

[WEST] 				spawn GAIA_fnc_startGaia;
[EAST] 				spawn GAIA_fnc_startGaia;
[independent] spawn GAIA_fnc_startGaia;
[civilian] 		spawn GAIA_fnc_startGaia;


[] spawn GAIA_fnc_startGaiaCache;

[] spawn GAIA_FNC_ambientCombat;

GAIA_INIT = TRUE;
