/*
  Created by Spirit, 5-1-2014
 	 	
*/ 

GAIA_INIT = FALSE;

GAIA_scripts 	= format ["%1gaia\scripts\",MCC_path];
GAIA_fsm 		= format ["%1gaia\fsm\",MCC_path];

//GAIA 
fnc_GAIA					 									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GAIA.sqf");
fnc_GAIA_AnalyzeTargets							= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GAIA_AnalyzeTargets.sqf");
fnc_GAIA_AnalyzeForces							= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GAIA_AnalyzeForces.sqf");
fnc_GAIA_ConflictAreas							= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GAIA_ConflictAreas.sqf");
fnc_GAIA_Classify										= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GAIA_Classify.sqf");
fnc_GAIA_IssueOrders								= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GAIA_IssueOrders.sqf");


//Cache
gaia_fn_cache												= compile preprocessfilelinenumbers (GAIA_scripts + "fn_cache.sqf");
gaia_fn_cache_stage_2								= compile preprocessfilelinenumbers (GAIA_scripts + "fn_cache_stage_2.sqf");
gaia_fn_sync												= compile preprocessfilelinenumbers (GAIA_scripts + "fn_sync.sqf");
gaia_fn_uncache											= compile preprocessfilelinenumbers (GAIA_scripts + "fn_uncache.sqf");
gaia_fn_uncache_stage_2							= compile preprocessfilelinenumbers (GAIA_scripts + "fn_uncache_stage_2.sqf");
gaia_fn_nearPlayer									= compile preprocessfilelinenumbers (GAIA_scripts + "fn_nearPlayer.sqf");
gaia_fn_gaia_cache_init							= compile preprocessfilelinenumbers (GAIA_scripts + "fn_gaia_cache_init.sqf");

fn_cache_original_group							= compile preprocessfilelinenumbers (GAIA_scripts + "fn_cache_original_group.sqf");
fn_uncache_original_group						= compile preprocessfilelinenumbers (GAIA_scripts + "fn_uncache_original_group.sqf");










//Behavior Functions
fnc_GetCAPoints											= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GetCAPoints.sqf");
fnc_DoTask 													= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_DoTask.sqf");
fnc_GetZoneIntendFomGroup						= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GetZoneIntendFomGroup.sqf");
fnc_GetDistanceClosestZone					= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GetDistanceClosestZone.sqf");
fnc_AddGroupToGAIA									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_AddGroupToGAIA.sqf");
fnc_HasLOS													= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_HasLOS.sqf");
fnc_SortGroupsByCA									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_SortGroupsByCA.sqf");
fnc_FireFlare												= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_FireFlare.sqf");




//Orders
fnc_GetPosition 										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_GetPosition.sqf");
fnc_addWaypoint											= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_addWaypoint.sqf");
fnc_AddAttackWaypoint								= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_AddAttackWaypoint.sqf");
fnc_RemoveWayPoints									= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_RemoveWayPoints.sqf");
fnc_CreateBuildingWP								= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_CreateBuildingWP.sqf");
fnc_CreateWP												= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_CreateWP.sqf");
fnc_DoPatrolInf											= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolInf.sqf");
fnc_DoPatrolRecon										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolRecon.sqf");
fnc_DoPatrol												= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrol.sqf");
fnc_DoPatrolCar											= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolCar.sqf");
fnc_DoPatrolMotorRecon							= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolMotorRecon.sqf");
fnc_DoPatrolMechInf									= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolMechInf.sqf");
fnc_DoPatrolMotorInf								= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolMotorInf.sqf");
fnc_DoPatrolShip										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolShip.sqf");
fnc_DoPatrolHeli										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolHeli.sqf");
fnc_DoFortify												= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoFortify.sqf");
fnc_DoWait													= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoWait.sqf");



//fnc_DoPatrolMotorizedRecon					= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPatrolMotorizedRecon.sqf");
fnc_DoAttackRecon										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackRecon.sqf");
fnc_DoAttackInf											= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackInf.sqf");
fnc_DoAttackCar											= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackCar.sqf");
fnc_DoAttackMotorRecon							= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackMotorRecon.sqf");
fnc_DoAttackMotorInf								= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackMotorInf.sqf");
fnc_DoAttack												= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttack.sqf");
fnc_DoAttackMechInf									= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackMechInf.sqf");
fnc_DoAttackTank										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackTank.sqf");
fnc_DoAttackShip										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackShip.sqf");
fnc_DoAttackHeli										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoAttackHeli.sqf");

fnc_DoTransportCar									= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoTransportCar.sqf");
fnc_DoTransportTank									= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoTransportTank.sqf");
fnc_DoTransportHeli									= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoTransportHeli.sqf");



fnc_DoClear													= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoClear.sqf");
fnc_DoClearRecon										= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoClearRecon.sqf");
fnc_DoClearInf											= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoClearInf.sqf");
fnc_DoSupport												= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoSupport.sqf");
fnc_DoHide													= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoHide.sqf");
fnc_DoOrganizeTransportation				= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoOrganizeTransportation.sqf");
fnc_DoPark													= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoPark.sqf");
fnc_DoMortar												= compile preprocessfilelinenumbers (GAIA_scripts + "orders\fnc_DoMortar.sqf");










// Subfunctions Positioning

fnc_PosIsInMarker										= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_PosIsInMarker.sqf");
fnc_GetDirectionalPos								= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GetDirectionalPos.sqf");
fnc_findClosestPosition 						= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_findclosestposition.sqf");
fnc_getMarkerCorners 								= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_getmarkercorners.sqf");
fnc_getMarkerShape 									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_getmarkershape.sqf");
fnc_getPosFromCircle 								= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_getposfromcircle.sqf");
fnc_getPosFromEllipse 							= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_getposfromellipse.sqf");
fnc_getPosFromRectangle 						= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_getposfromrectangle.sqf");
fnc_getPosFromSquare 								= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_getposfromsquare.sqf");
fnc_isBlacklisted 									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_isblacklisted.sqf");
fnc_isInCircle 											= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_isincircle.sqf");
fnc_isInEllipse 										= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_isinellipse.sqf");
fnc_isInRectangle 									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_isinrectangle.sqf");
fnc_isSamePosition 									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_issameposition.sqf");
fnc_rotatePosition 									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_rotateposition.sqf");
fnc_getNearestBuildingPosDistance		= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_getNearestBuildingPosDistance.sqf");
fnc_GetZoneStatusBehavior						= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_GetZoneStatusBehavior.sqf");
fnc_TimeOut													= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_TimeOut.sqf");
fnc_isCleared												= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_isCleared.sqf");

//Terrain functions
fnc_ScanTerrain 										= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_ScanTerrain.sqf");

//Statistic function
fnc_CountUnitTypes								= compile preprocessfilelinenumbers (GAIA_scripts 	+ "fnc_CountUnitTypes.sqf");
fnc_ClassifyUnits									= compile preprocessfilelinenumbers (GAIA_scripts + "fnc_ClassifyUnits.sqf");
fnc_AnalyseUnit 									= compile preprocessfilelinenumbers (GAIA_scripts 	+ "fnc_AnalyseUnit.sqf");
fnc_GetTurretsWeapons						 	= compile preprocessfilelinenumbers (GAIA_scripts 	+ "fnc_GetTurretsWeapons.sqf");

//garrison specific
//define functions hint

gaia_CBA_fnc_taskDefend 					=compile preProcessFileLineNumbers (GAIA_scripts + "Fortify\gaia_CBA_fnc_taskDefend.sqf");





//GAIA Public (local) variables
MCC_GAIA_DEBUG						= false;
MCC_GAIA_CA_DEBUG					= [];


MCC_GAIA_CACHE						= false;
GAIA_CACHE_SLEEP					= 0.5;
GAIA_CACHE_STAGE_1				= 2000;
GAIA_CACHE_STAGE_2				= 4000;
MCC_GAIA_CACHE_STAGE2			= []; 




// dont CHANGE without knowledge 
MCC_GAIA_OPERATIONAL 			= false;

//Used for the breadcrumb blacklist system. How far should a waypoint be from a position a unit has last been?
MCC_GAIA_CYCLE								 = 1;
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
MCC_GAIA_MORTAR_TIMEOUT				 = 300;
//This switch makes it possible for GAIA to send units into the attack she does not initialy control
MCC_GAIA_ATTACKS_FOR_NONGAIA	 = false;


//Side specific
MCC_GAIA_CA_WEST					= [];  
MCC_GAIA_CA_EAST					= [];  
MCC_GAIA_CA_INDEP					= [];  
MCC_GAIA_ZONES_INDEP			= [];  
MCC_GAIA_ZONES_POS_INDEP	= [];  
MCC_GAIA_ZONES_EAST				= [];  
MCC_GAIA_ZONES_POS_EAST		= [];  
MCC_GAIA_ZONES_WEST				= [];  
MCC_GAIA_ZONES_POS_WEST		= [];  
MCC_GAIA_GROUPS_WEST			= [];  
MCC_GAIA_GROUPS_EAST			= [];  
MCC_GAIA_GROUPS_INDEP			= [];  
MCC_GAIA_BREADCRUMBS_WEST	= []; 
MCC_GAIA_BREADCRUMBS_EAST	= []; 
MCC_GAIA_BREADCRUMBS_INDEP= []; 
MCC_GAIA_WPPOS_WEST				= []; 
MCC_GAIA_WPPOS_EAST				= []; 
MCC_GAIA_WPPOS_INDEP			= []; 
MCC_GAIA_ZONESTATUS_WEST	=	[]; for "_i" from 0 to 90 do  { MCC_GAIA_ZONESTATUS_WEST set [_i,"0"];};  
MCC_GAIA_ZONESTATUS_EAST	=	[]; for "_i" from 0 to 90 do  { MCC_GAIA_ZONESTATUS_EAST set [_i,"0"];};  
MCC_GAIA_ZONESTATUS_INDEP	=	[]; for "_i" from 0 to 90 do  { MCC_GAIA_ZONESTATUS_INDEP set [_i,"0"];};  
MCC_GAIA_TARGETS_WEST			= []; for "_i" from 0 to 90 do  { MCC_GAIA_TARGETS_WEST set [_i,[]];};  
MCC_GAIA_TARGETS_EAST			= []; for "_i" from 0 to 90 do  { MCC_GAIA_TARGETS_EAST set [_i,[]];};  
MCC_GAIA_TARGETS_INDEP		= []; for "_i" from 0 to 90 do  { MCC_GAIA_TARGETS_INDEP set [_i,[]];};  




//We spawn GAIA for each side (but dont worry, it will only be really active if there are units.)
//Still a smarter solution is welcome.

[WEST] 				spawn fnc_GAIA;
[EAST] 				spawn fnc_GAIA;
[independent] spawn fnc_GAIA;

[] spawn gaia_fn_gaia_cache_init;

GAIA_INIT = TRUE;
