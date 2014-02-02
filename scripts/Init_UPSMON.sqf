// =========================================================================================================
//  UPSMON - Urban Patrol Script  Mon
//  Version: 5.1.0 
//  Author: Monsada (chs.monsada@gmail.com) 
//
//		Wiki: http://dev-heaven.net/projects/upsmon/wiki
//		Forum: http://forums.bistudio.com/showthread.php?t=91696
//		Share your missions with upsmon: http://dev-heaven.net/projects/upsmon/boards/86
// ---------------------------------------------------------------------------------------------------------
//  Based on Urban Patrol Script  
//  Version: 2.0.3 
//  Author: Kronzky (www.kronzky.info / kronzky@gmail.com)
// ---------------------------------------------------------------------------------------------------------
//  Some little fixes: !Rafalsky (v5.0.8 - 5.0.9)
// ---------------------------------------------------------------------------------------------------------

//Adding eventhandlers
	"KRON_UPS_EAST_SURRENDED" addPublicVariableEventHandler { if (_this select 1) then { nul=[east] execvm "scripts\UPSMON\MON_surrended.sqf";};};
	"KRON_UPS_WEST_SURRENDED" addPublicVariableEventHandler { if (_this select 1) then { nul=[west] execvm "scripts\UPSMON\MON_surrended.sqf";};};
	"KRON_UPS_GUER_SURRENDED" addPublicVariableEventHandler { if (_this select 1) then { nul=[resistance] execvm "scripts\UPSMON\MON_surrended.sqf";};};
	"MON_LOCAL_EXEC" addPublicVariableEventHandler { if (local ((_this select 1)select 0)) then {
		call ( compile format[(_this select 1)select 1,(_this select 1)select 0] );
		};
	};


if (!isServer && hasInterface ) exitWith {};

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
//        These Variables should be checked and set as required, to make the mission runs properly.
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// ACE Wounds System for AI (set TRUE to On, set FALSE to Off) ! 
ace_sys_wounds_noai = false; // set it as required

//1=Enable or 0=disable debug. In debug could see a mark positioning de leader and another mark of the destination of movement, very useful for editing mission
KRON_UPS_Debug = 0;

//1=Enable or 0=disable. In game display global chat info about who just killed a civilian. 
//numbers of Civilians killed by players could be read from array 'KILLED_CIV_COUNTER' -> [Total, by West, by East, by Res, The killer]
R_WHO_IS_CIV_KILLER_INFO = 0;


// if you are spotted by AI group, how close the other AI group have to be to You , to be informed about your present position. over this, will lose target
KRON_UPS_sharedist = 800;

// If enabled AI communication between them with radio defined sharedist distance, 0/2 
// (must be set to 2 in order to use reinforcement !R)
KRON_UPS_comradio = 2;

//Sides that are enemies of resistance
KRON_UPS_Res_enemy = [];
_resEnemyWest = false;
_resEnemyEast = false;				
if ( (resistance getFriend WEST) < 0.6 ) then { _resEnemyWest = true }; // resistance is enemy of West
if ( (resistance getFriend EAST) < 0.6 ) then { _resEnemyEast = true }; // resistance is enemy of East

if ( _resEnemyWest && _resEnemyEast ) then { KRON_UPS_Res_enemy = [west, east] };
if ( _resEnemyWest && !_resEnemyEast ) then { KRON_UPS_Res_enemy = [west] };
if ( !_resEnemyWest && _resEnemyEast ) then { KRON_UPS_Res_enemy = [east] };
//if ( !_resEnemyWest && !_resEnemyEast ) then { KRON_UPS_Res_enemy = [] };

// Distance from destination for searching vehicles. (Search area is about 200m), 
// If your destination point is further than KRON_UPS_searchVehicledist, AI will try to find a vehicle to go there.
KRON_UPS_searchVehicledist = 300;

//Enables or disables AI to use static weapons
KRON_UPS_useStatics = true;

//Enables or disables AI to put mines if armoured enemies near (use ambush2 if needed)
KRON_UPS_useMines = false;

//------------------------------------------------------------------------------------------------------------------------------
//        These Variables can be changed if needed but it is not necessary.
//------------------------------------------------------------------------------------------------------------------------------

//% of chanse to use smoke by team members when someone wounded or killed in the group in %(default 13 & 35).
// set both to 0 -> to switch off this function 
R_USE_SMOKE_wounded = 10;
R_USE_SMOKE_killed = 35;

//Height that heli will fly this input will be randomised in a 10%
KRON_UPS_flyInHeight = 80;

//Percentage of units to surrender.
KRON_UPS_EAST_SURRENDER = 0; // 10
KRON_UPS_WEST_SURRENDER = 0; // 10
KRON_UPS_GUER_SURRENDER = 0; // 10

// knowsAbout 0.5 1.03 , 1.49 to add this enemy to "target list" (1-4) the higher number the less detect ability (original in 5.0.7 was 0.5)
// it does not mean the AI will not shoot at you. This means: what must be knowsAbout you to UPSMON adds you to the list of targets (UPSMON list of target) 
R_knowsAboutEnemy = 0.5;

// units will react (change the beahaviour) when dead bodies found 
R_deadBodiesReact = true;  // true OR flase

// ---------------------------------------------------------------------------------------------------------------------
//      Better do not change these variables if you aren't sure !R
// ---------------------------------------------------------------------------------------------------------------------

//Efective distance for doing perfect ambush (max distance is this x2)
KRON_UPS_ambushdist = 100;

//Max distance to target for doing para-drop, will be randomised between 0 and 100% of this value.
KRON_UPS_paradropdist = 250;

//Frequency for doing calculations for each squad.
KRON_UPS_Cycle = 10; //org 20

//Time that lider wait until doing another movement, this time reduced dynamically under fire, and on new targets
KRON_UPS_react = 60;

//Min time to wait for doing another reaction
KRON_UPS_minreact = 20; // org 30

//Max waiting is the maximum time patrol groups will wait when arrived to target for doing another target.
KRON_UPS_maxwaiting = 30;

// how long AI units should be in alert mode after initially spotting an enemy
KRON_UPS_alerttime = 90;

// how far opfors should move away if they're under attack
KRON_UPS_safedist = 250; //org 300

// how close unit has to be to target to generate a new one target or to enter stealth mode
KRON_UPS_closeenough = 50; //org 300 

//Enable it to send reinforcements, better done it in a trigger inside your mission.
KRON_UPS_reinforcement = false; 

//Artillery support, better control if set in trigger  
KRON_UPS_ARTILLERY_EAST_FIRE = true; //set to true for doing east to fire
KRON_UPS_ARTILLERY_WEST_FIRE = true; //set to true for doing west to fire
KRON_UPS_ARTILLERY_GUER_FIRE = true; //set to true for doing resistance to fire

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
//		Do not touch these variables !!!! !R	
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	R_GOTHIT_ARRAY =[0];
	AcePresent = isClass(configFile/"CfgPatches"/"ace_main");
	UPSMON_Version = "UPSMON 5.1.1";
	KILLED_CIV_COUNTER = [0,0,0,0,0];
	KRON_UPS_flankAngle = 45; //Angulo de flanqueo
	KRON_UPS_INIT = 0;        //Variable que indica que ha sido inicializado
	KRON_UPS_EAST_SURRENDED = false;
	KRON_UPS_WEST_SURRENDED = false;
	KRON_UPS_GUER_SURRENDED = false;
	KRON_AllWest=[];	//All west AI 
	KRON_AllEast=[];	//All east AI 
	KRON_AllRes=[];		//All resistance AI 
	KRON_UPS_East_enemies = [];
	KRON_UPS_West_enemies = [];
	KRON_UPS_Guer_enemies = [];
	KRON_UPS_East_friends = [];
	KRON_UPS_West_friends = [];
	KRON_UPS_Guer_friends = [];
	KRON_targets0 =[];//objetivos west
	KRON_targets1 =[];//objetivos east
	KRON_targets2 =[];//resistence	
	KRON_targetsPos =[];//Posiciones de destino actuales.
	KRON_NPCs = []; //Lideres de los grupos actuales	
	KRON_UPS_Instances=0;
	KRON_UPS_Total=0;
	KRON_UPS_Exited=0;
	KRON_UPS_East_Total = 0;
	KRON_UPS_West_Total = 0;
	KRON_UPS_Guer_Total = 0;	
	KRON_UPS_ARTILLERY_UNITS = [];
	KRON_UPS_ARTILLERY_WEST_TARGET = objnull;
	KRON_UPS_ARTILLERY_EAST_TARGET = objnull;
	KRON_UPS_ARTILLERY_GUER_TARGET = objnull;
	KRON_UPS_TEMPLATES = [];
	KRON_UPS_MG_WEAPONS = ["LMG_Mk200_F","arifle_MX_SW_F","LMG_Zafir_F"];
	
	
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	// ***************************************** SERVER INITIALIZATION *****************************************
	if (isNil("KRON_UPS_INIT") || KRON_UPS_INIT == 0) then {

		//Init library function, Required Version: 5.0 of mon_functions
		call compile preprocessFileLineNumbers format ["%1scripts\UPSMON\common\MON_functions.sqf",MCC_path];
		
		//init !R functions
		call compile preprocessFileLineNumbers format ["%1scripts\UPSMON\!R\R_functions.sqf",MCC_path];
		
		//if (isNil "RE") then {[] execVM "\ca\Modules\MP\data\scripts\MPframework.sqf"}; 
		
		//scripts initialization
		UPSMON = compile preprocessFile format ["%1scripts\UPSMON.sqf",MCC_path];	
		UPSMON_surrended = compile preprocessFile format ["%1scripts\UPSMON\MON_surrended.sqf",MCC_path];	

		// declaración de variables privadas
		private["_obj","_trg","_l","_pos"];

		// global functions
		KRON_randomPos = {private["_cx","_cy","_rx","_ry","_cd","_sd","_ad","_tx","_ty","_xout","_yout"];_cx=_this select 0; _cy=_this select 1; _rx=_this select 2; _ry=_this select 3; _cd=_this select 4; _sd=_this select 5; _ad=_this select 6; _tx=random (_rx*2)-_rx; _ty=random (_ry*2)-_ry; _xout=if (_ad!=0) then {_cx+ (_cd*_tx - _sd*_ty)} else {_cx+_tx}; _yout=if (_ad!=0) then {_cy+ (_sd*_tx + _cd*_ty)} else {_cy+_ty}; [_xout,_yout]};
		KRON_PosInfo = {private["_pos","_lst","_bld","_bldpos"];_pos=_this select 0; _lst=_pos nearObjects ["House",12]; if (count _lst==0) then {_bld=0;_bldpos=0} else {_bld=_lst select 0; _bldpos=[_bld] call KRON_BldPos}; [_bld,_bldpos]};
		KRON_PosInfo3 = {private["_pos","_lst","_bld","_bldpos"];_pos=_this select 0; _lst= nearestObjects [_pos, [], 3];
			if (count _lst==0) then {_bld=objnull;_bldpos=0} else {_bld = nearestbuilding (_lst select 0); 
			_bldpos=[_bld] call KRON_BldPos2}; [_bld,_bldpos]};
		KRON_BldPos = {private ["_bld","_bldpos","_posZ","_maxZ"];_bld=_this select 0;_maxZ=0;_bi=0;_bldpos=0;while {_bi>=0} do {if (((_bld BuildingPos _bi) select 0)==0) then {_bi=-99} else {_bz=((_bld BuildingPos _bi) select 2); if (((_bz)>4) && ((_bz>_maxZ) || ((_bz==_maxZ) && (random 1>.8)))) then {_maxZ=_bz; _bldpos=_bi}};_bi=_bi+1};_bldpos};
		KRON_BldPos2 = {private ["_bld","_bldpos"];
							_bld=_this select 0; _bldpos = 1;
							while {format ["%1", _bld buildingPos _bldpos] != "[0,0,0]"}  do {_bldpos = _bldpos + 1;};
						_bldpos = _bldpos - 1; _bldpos;};
		
		
		KRON_getDirPos = {private["_a","_b","_from","_to","_return"]; _from = _this select 0; _to = _this select 1; _return = 0; _a = ((_to select 0) - (_from select 0)); _b = ((_to select 1) - (_from select 1)); if (_a != 0 || _b != 0) then {_return = _a atan2 _b}; if ( _return < 0 ) then { _return = _return + 360 }; _return};
		KRON_distancePosSqr = {round(((((_this select 0) select 0)-((_this select 1) select 0))^2 + (((_this select 0) select 1)-((_this select 1) select 1))^2)^0.5)};
		KRON_relPos = {private["_p","_d","_a","_x","_y","_xout","_yout"];_p=_this select 0; _x=_p select 0; _y=_p select 1; _d=_this select 1; _a=_this select 2; _xout=_x + sin(_a)*_d; _yout=_y + cos(_a)*_d;[_xout,_yout,0]};
		KRON_rotpoint = {private["_cp","_a","_tx","_ty","_cd","_sd","_cx","_cy","_xout","_yout"];_cp=_this select 0; _cx=_cp select 0; _cy=_cp select 1; _a=_this select 1; _cd=cos(_a*-1); _sd=sin(_a*-1); _tx=_this select 2; _ty=_this select 3; _xout=if (_a!=0) then {_cx+ (_cd*_tx - _sd*_ty)} else {_cx+_tx}; _yout=if (_a!=0) then {_cy+ (_sd*_tx + _cd*_ty)} else {_cy+_ty}; [_xout,_yout,0]};
		KRON_stayInside = {
			private["_np","_nx","_ny","_cp","_cx","_cy","_rx","_ry","_d","_tp","_tx","_ty","_fx","_fy"];
			_np=_this select 0;	_nx=_np select 0;	_ny=_np select 1;
			_cp=_this select 1;	_cx=_cp select 0;	_cy=_cp select 1;
			_rx=_this select 2;	_ry=_this select 3;	_d=_this select 4;
			_tp = [_cp,_d,(_nx-_cx),(_ny-_cy)] call KRON_rotpoint;
			_tx = _tp select 0; _fx=_tx;
			_ty = _tp select 1; _fy=_ty;
			if (_tx<(_cx-_rx)) then {_fx=_cx-_rx};
			if (_tx>(_cx+_rx)) then {_fx=_cx+_rx};
			if (_ty<(_cy-_ry)) then {_fy=_cy-_ry};
			if (_ty>(_cy+_ry)) then {_fy=_cy+_ry};
			if ((_fx!=_tx) || (_fy!=_ty)) then {_np = [_cp,_d*-1,(_fx-_cx),(_fy-_cy)] call KRON_rotpoint};
			_np;
		};
	// Misc
		KRON_UPSgetArg = {private["_cmd","_arg","_list","_a","_v"]; _cmd=_this select 0; _arg=_this select 1; _list=_this select 2; _a=-1; {_a=_a+1; _v=format["%1",_list select _a]; if (_v==_cmd) then {_arg=(_list select _a+1)}} foreach _list; _arg};
		KRON_UPSsetArg = {private["_cmd","_arg","_list","_a","_v"]; 
			_cmd=_this select 0; 
			_arg=_this select 1; 
			_list=_this select 2; 
			_a=-1; 
			{	
				_a=_a+1; 
				_v= format ["%1", _list select _a]; 
				if (_v==_cmd) then {
					_a=_a+1; 
					_list set [_a,_arg];
					};
				} foreach _list; 
			_list};
		KRON_deleteDead = {private["_u","_s"];_u=_this select 0; _s= _this select 1; _u removeAllEventHandlers "killed"; sleep _s; deletevehicle _u};

		
		
		
		
	// ***********************************************************************************************************	
	//									  MAIN UPSMON SERVER FUNCTION 
	// ***********************************************************************************************************	
		MON_MAIN_server = {
		
			private["_obj","_trg","_l","_pos","_countWestSur","_countEastSur","_countResSur","_WestSur","_EastSur","_ResSur","_target","_targets","_targets0","_targets1","_targets2","_npc","_cycle"
				,"_arti","_side","_range","_rounds","_area","_maxcadence","_mincadence","_bullet","_fire","_knownpos","_sharedenemy","_enemyside","_timeout"];
			_cycle = 10; //Time to do a call to commander
			_arti = objnull;
			_side = "";
			_range = 0;
			_rounds = 0;	
			_area = 0;	
			_maxcadence = 0;	
			_mincadence = 0;	
			_bullet = "";	
			_fire = false;
			_target = objnull;
			_knownpos =[0,0,0];
			_enemyside = [];

			_WestSur = KRON_UPS_WEST_SURRENDED;
			_EastSur = KRON_UPS_EAST_SURRENDED;
			_ResSur = KRON_UPS_GUER_SURRENDED;	
			
			
			//Main loop
			while {true} do 
			{			
				_countWestSur = round ( KRON_UPS_West_Total * KRON_UPS_WEST_SURRENDER / 100);
				_countEastSur = round ( KRON_UPS_East_Total * KRON_UPS_EAST_SURRENDER / 100);
				_countResSur = round ( KRON_UPS_Guer_Total * KRON_UPS_GUER_SURRENDER / 100);	
				
				//Checks for WEST surrender
				if (KRON_UPS_WEST_SURRENDER > 0 && !KRON_UPS_WEST_SURRENDED ) then {							
					{
						if (!alive _x || !canmove _x) then {KRON_AllWest = KRON_AllWest-[_x]};
					}foreach KRON_AllWest;
					
					if ( count KRON_AllWest <= _countWestSur  ) then { 
						KRON_UPS_WEST_SURRENDED = true; 
						publicvariable "KRON_AllWest";					
						publicvariable "KRON_UPS_WEST_SURRENDED";
					};
				};				
				
				//Checks for EAST surrender
				if (KRON_UPS_EAST_SURRENDER > 0 && !KRON_UPS_EAST_SURRENDED ) then {							
					{
						if (!alive _x || !canmove _x) then {KRON_AllEast = KRON_AllEast-[_x]};
					}foreach KRON_AllEast;
					
					if ( count KRON_AllEast <= _countEastSur  ) then { 
						KRON_UPS_EAST_SURRENDED = true; 
						publicvariable "KRON_AllEast";						
						publicvariable "KRON_UPS_EAST_SURRENDED";					
					};
				};				

				//Checks for RESISTANCE surrender
				if (KRON_UPS_GUER_SURRENDER > 0 && !KRON_UPS_GUER_SURRENDED ) then {							
					{
						if (!alive _x || !canmove _x) then {KRON_AllRes = KRON_AllRes-[_x]};
					}foreach KRON_AllRes;
					
					if ( count KRON_AllRes <= _countResSur  ) then { 
						KRON_UPS_GUER_SURRENDED = true; 
						publicvariable "KRON_AllRes";						
						publicvariable "KRON_UPS_GUER_SURRENDED";						
					};			
				};	

				//Exec surrended script
				if (KRON_UPS_WEST_SURRENDED && !_WestSur ) then {
					_WestSur = true;
					[west] spawn UPSMON_surrended;
				};
				if (KRON_UPS_EAST_SURRENDED && !_EastSur ) then {
					_EastSur = true;
					[east] spawn UPSMON_surrended;
				};
				if (KRON_UPS_GUER_SURRENDED && !_ResSur ) then {
					_ResSur = true;
					[Resistance] spawn UPSMON_surrended;
				};			
				sleep 0.5;	
				
				_sharedenemy = 0;	
				_targets0 = [];
				_targets1 = [];
				_targets2 = [];
				
				if ((count KRON_NPCs) > 0) then
				{
					{
						if (!(isNil "_x")) then
						{
							if( !(isNull _x) && (alive _x) && !(captive _x) ) then 
							{
								_npc = _x;						
								_targets = [];

								switch (side _npc) do 
								{
									//West targets
									case west: 
									{
										_sharedenemy = 0;
										_enemyside = [east];
									};
									//East targets
									case east: 
									{
										_sharedenemy = 1;
										_enemyside = [west];
									};
									//Resistance targets
									case resistance: 
									{								
										_sharedenemy = 2;
										_enemyside = KRON_UPS_Res_enemy;
									};
								};		
								
								if (side _npc in KRON_UPS_Res_enemy) then 
								{
									_enemyside = _enemyside + [resistance];
								};
								
								//Gets known targets on each leader for comunicating enemy position
								//Has better performance with targetsquery
								//_targets = _npc nearTargets KRON_UPS_sharedist;		
								_targets = _npc targetsQuery ["","","","",""];
								
								{
									//_target = _x select 4;      //Neartargets
									_target = _x select 1;        //Targetsquery							
									if ( side _target in _enemyside ) then {																									
									// if (KRON_UPS_Debug>0) then {player globalchat format["%1: knows about %2, enemies=%3",_npc getVariable ("UPSMON_grpid"),_npc knowsabout _target, _npc countEnemy _targets ]};
															
										if (!isnull _target && alive _target && canmove _target && !captive _target && _npc knowsabout _target > R_knowsAboutEnemy
											&& ( _target iskindof "Land" || _target iskindof "Air" || _target iskindof "Ship" )
											&& !( _target iskindof "Animal")
											&& ( _target emptyPositions "Gunner" == 0 && _target emptyPositions "Driver" == 0 
												|| (!isnull (gunner _target) && canmove (gunner _target))
												|| (!isnull (driver _target) && canmove (driver _target))) 									
										) then 
										{
											//Saves last known position	
											//_knownpos = _x select 0;	//Neartargets							
											_knownpos = _x select 4;//Targetsquery
											_target setvariable ["UPSMON_lastknownpos", _knownpos, false];									
											// _npc setVariable ["R_knowsAboutTarget", true, false];	  // !R								
											
											call (compile format ["_targets%1 = _targets%1 - [_target]",_sharedenemy]);
											call (compile format ["_targets%1 = _targets%1 + [_target]",_sharedenemy]);						
										};	
									};
									sleep 0.01;	
								} foreach _targets;							
							};					
							sleep 0.01;	
						};
					} forEach KRON_NPCs;		
				};
				
				//Share targets
				KRON_targets0 = _targets0;
				KRON_targets1 = _targets1;
				KRON_targets2 = _targets2;
				
				//Target debug console
				if (KRON_UPS_Debug>0) then {hintsilent parseText format["%1<br/>--------------------------<br/><t color='#33CC00'>West(A=%2 C=%3 T=%4)</t><br/><t color='#FF0000'>East(A=%5 C=%6 T=%7)</t><br/><t color='#00CCFF'>Res(A=%8 C=%9 T=%10)</t><br/>"
					,UPSMON_Version
					,KRON_UPS_West_Total, count KRON_AllWest, count KRON_targets0
					,KRON_UPS_East_Total, count KRON_AllEast, count KRON_targets1
					,KRON_UPS_Guer_Total, count KRON_AllRes, count KRON_targets2					]}; 	
				sleep 0.5;					

				//Artillery module control
				{
					_arti  = _x select 0;
					_rounds = _x select 1;					
					_range = _x select 2;
					_area = _x select 3;	
					_maxcadence = _x select 4;	
					_mincadence = _x select 5;	
					_bullet = _x select 6;
                    _salvobreak = _x select 7;					
					
					if (isnil{_arti getVariable ("timeout")}) then {		
						_arti setVariable ["timeout", time, false];
						sleep 0.1;
					};		
					
					_timeout = _arti getVariable ("timeout");
					if (isnil "_timeout") then {_timeout = 0};
					
					if (!isnull (gunner _arti) && canmove (gunner _arti) && (time >= _timeout)) then {
						_side = side gunner _arti;
						_fire = call (compile format ["KRON_UPS_ARTILLERY_%1_FIRE",_side]);					
						
						
						
						//If fire enabled gets a known target pos for doing fire if no friendly squads near.
						if (_fire) then {
							_target = call (compile format ["KRON_UPS_ARTILLERY_%1_TARGET",_side]);
							if (isnil "_target" ) then {_target = objnull;};
							
							switch (_side) do {
								//West targets
									case west: {											
										_targets = KRON_targets0;									
									};
									//East targets
									case east: {
										_targets = KRON_targets1;									
									};
									//Resistance targets
									case resistance: {								
										_targets = KRON_targets2;									
									};
							};
							
							//Check if has a target
							if (!(_target in _targets ) || isnull _target || !alive _target) then {
								_target = objnull;
								{
									_auxtarget = _x;
									_targetPos = _auxtarget getvariable ("UPSMON_lastknownpos");								
									if (!isnil "_targetPos") then {
										//If target in range check no friendly squad near									
										if (alive _auxtarget && !(_auxtarget iskindof "Air") && (round([position _arti,_targetPos] call KRON_distancePosSqr)) <= _range) then {
											_target = _auxtarget;
											//Must check if no friendly squad near fire position
											{	
												if (!isnil "_x") then
												{
													if (!isnull _x && _side == side _x) then
													{																								
														if ((round([position _x,_targetPos] call KRON_distancePosSqr)) < (KRON_UPS_safedist * 0.7)) exitwith {_target = objnull;};
													};	
												};	
											} foreach KRON_NPCs;																		
										};
									};
									
									//If target found exit
									if (!isnull _target) exitwith {};								
								} foreach _targets;							
							};
							
							//If target fires artillery
							if (!isnull _target) then {
								//Fix current target
								call (compile format ["KRON_UPS_ARTILLERY_%1_TARGET = _target",_side]);
								_targetPos = _target getvariable ("UPSMON_lastknownpos");	
								if (!isnil "_targetPos") then 
								{
									//_arti removeAllEventHandlers "fired"; sleep 0.01;
									// chatch the bullet in the air and delete it
									//_arti addeventhandler["fired", {deletevehicle (nearestobject[_this select 0, _this select 4])}];
									[_arti,_targetPos,_rounds,_area,_maxcadence,_mincadence,_bullet,_salvobreak] spawn MON_artillery_dofire;
								};
							};
						};
					};		
					sleep 0.5;
				} foreach KRON_UPS_ARTILLERY_UNITS;
				
					// if (KRON_UPS_Debug>0) then {player globalchat format["Init_upsmon artillery=%1",count KRON_UPS_ARTILLERY_UNITS]};							
				sleep _cycle;			
			};
		};	
	};
	
	
// ***********************************************************************************************************	
//									  INITIALIZATION  OF UPSMON
// ***********************************************************************************************************		
	
	_l = allunits + vehicles;
	{
		if ((_x iskindof "AllVehicles") && (side _x != civilian)) then {
			_s = side _x;
			switch (_s) do {
				case west: 
					{ KRON_AllWest=KRON_AllWest+[_x]; };
				case east: 
					{ KRON_AllEast=KRON_AllEast+[_x]; };
				case resistance: 
					{ KRON_AllRes=KRON_AllRes+[_x]; };
			};
		};
	} forEach _l;
	_l = nil;

	if (isNil("KRON_UPS_Debug")) then {KRON_UPS_Debug=0};

	KRON_UPS_East_enemies = KRON_AllWest;
	KRON_UPS_West_enemies = KRON_AllEast;
	
	if (east in KRON_UPS_Res_enemy ) then {	
		KRON_UPS_East_enemies = KRON_UPS_East_enemies+KRON_AllRes;
		KRON_UPS_Guer_enemies = KRON_AllEast;
	} else {
		KRON_UPS_East_friends = KRON_UPS_East_friends+KRON_AllRes;
		KRON_UPS_Guer_friends = KRON_AllEast;
	}; 
		
	if (west in KRON_UPS_Res_enemy ) then {
		KRON_UPS_West_enemies = KRON_UPS_West_enemies+KRON_AllRes;
		KRON_UPS_Guer_enemies = KRON_UPS_Guer_enemies+KRON_AllWest;
	} else {
		KRON_UPS_West_friends = KRON_UPS_West_friends+KRON_AllRes;
		KRON_UPS_Guer_friends = KRON_UPS_Guer_friends+KRON_AllWest;
	};

	KRON_UPS_West_Total = count KRON_AllWest;		
	KRON_UPS_East_Total = count KRON_AllEast;
	KRON_UPS_Guer_Total = count KRON_AllRes;		
	
	//Initialization done
	KRON_UPS_INIT=1;	

	
	//killciv EH
	_l = allunits;
	{
		if (side _x == civilian) then {
			
			
			_x AddEventHandler ["firedNear", {nul = _this spawn R_SN_EHFIREDNEAR}];
			sleep 0.01;					
			
			
			_x AddEventHandler ["killed", {nul = _this spawn R_SN_EHKILLEDCIV}];
			sleep 0.01;					
		};
	} forEach _l;
	_l = nil;
		
	
	
	
// ---------------------------------------------------------------------------------------------------------
//processInitCommands;

//Executes de main process of server
[] SPAWN MON_MAIN_server;

diag_log "--------------------------------";
diag_log (format["UPSMON started"]);
if(true) exitWith {}; 