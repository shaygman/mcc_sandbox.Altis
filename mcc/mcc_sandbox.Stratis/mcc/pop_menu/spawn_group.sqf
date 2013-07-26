#define MCC_SANDBOX_IDD 1000
#define MCCZONENUMBER 1023
#define FACTIONCOMBO 1001
#define SPAWNTYPE 1002
#define SPAWNBRANCH 1003
#define SPAWNCLASS 1004

#define SPAWNBEHAVIOR 1005
#define SPAWNEMPTY 1024
#define SPAWNAWARNESS 1025
#define MCC_ZONE_LOC 1026

private ["_type","_groupArray","_nul","_zonePos"];
disableSerialization;
if (mcc_missionmaker == (name player)) then {
	if (count mcc_zone_pos == 0) exitWith {hint "Create a zone first"};	//Failsafe incase we trying to spawn something without making a zone first
	_zonePos = (mcc_zone_pos select (lbCurSel MCCZONENUMBER)+1);
	if (isnil "_zonePos") exitWith {hint "Create a zone first"};	//Failsafe incase we trying to spawn something without making a zone first
	if ((lbCurSel SPAWNTYPE) == 1) then {	//Group
		_type = lbCurSel SPAWNBRANCH;
		
		switch (_type) do		//Which group do we want
			{
			   case 0:	//Infantry
				{
					_groupArray = GEN_INFANTRY;
				};
				
				case 1:	//Motorized
				{
					_groupArray = GEN_MOTORIZED;
				};
				
				case 2:	//Mechnized
				{
					_groupArray = GEN_MECHANIZED;
				};
				
				case 3:	//Armor
				{
					_groupArray = GEN_ARMOR;
				};
				
				case 4:	//Air
				{
					_groupArray = GEN_AIR;
				};
				
				case 5:	//SpecOps
				{
					_groupArray = GEN_SPECOPS;
				};
				
				case 6:	//Support
				{
					_groupArray = GEN_SUPPORT;
				};
			};
			
		if (_type==7) exitWith 	//Paratroopers
			{
				if (lbCurSel SPAWNCLASS==0) then {
				mcc_spawnname="1"} else {mcc_spawnname="2"};
				mcc_spawntype="PARATROOPER";
				mcc_classtype = "PARATROOPER";
				mcc_spawnfaction = mcc_sidename;
			};  

		if (_type == 8) exitWith {							 //Garrison
			private ["_center","_radius","_action","_intanse","_faction"];
			_center = (mcc_zone_pos select (mcc_zone_number));
			_radius = (((mcc_zone_size select (mcc_zone_number))select 0) + ((mcc_zone_size select (mcc_zone_number)) select 1))/2;
			_faction = getText (configFile >> "CfgVehicles" >> (U_GEN_SOLDIER select 0 select 1) >> "faction");
			
			switch (lbCurSel SPAWNCLASS) do		
				{
				   case 0:	//Light
					{
						_action 	= 0;
						_intanse 	= 3;
					};
					
					 case 1:	//Light -vehicles
					{
						_action 	= 1;
						_intanse 	= 3;
					};
					
					 case 2:	//Heavy
					{
						_action 	= 0;
						_intanse 	= 6;
					};
					
					 case 3:	//Heavy -vehicles
					{
						_action 	= 1;
						_intanse 	= 6;
					};
				};
			if (MCC_capture_state) then	{
				MCC_capture_var = MCC_capture_var + FORMAT ['
					[[%1,%2,%3,%4,"%5","%6"],"MCC_fnc_garrison",true,false] call BIS_fnc_MP;;
					'
					,_center
					,_radius
					,_action
					,_intanse
					,_faction
					,mcc_sidename
					];
				} else {
						mcc_safe = mcc_safe + FORMAT ['
						[[%1,%2,%3,%4,"%5","%6"],"MCC_fnc_garrison",true,false] call BIS_fnc_MP;;
						'
						,_center
						,_radius
						,_action
						,_intanse
						,_faction
						,mcc_sidename
						];
						[[_center,_radius,_action,_intanse,_faction,mcc_sidename],"MCC_fnc_garrison",true,false] call BIS_fnc_MP;;
					};
			};
			
		mcc_spawntype="GROUP";
		mcc_classtype = (_groupArray select (lbCurSel SPAWNCLASS)) select 0;
		mcc_spawnname = (_groupArray select (lbCurSel SPAWNCLASS)) select 1;
		mcc_spawnfaction = (_groupArray select (lbCurSel SPAWNCLASS)) select 2;
		mcc_spawndisplayname = (_groupArray select (lbCurSel SPAWNCLASS)) select 3;
		};
		
	if ((lbCurSel SPAWNTYPE) == 0) then 	//Units
		{ 
		_type = lbCurSel SPAWNBRANCH;
		switch (_type) do		//Which unit do we want
			{
			   case 0:	//Infantry
				{
					_groupArray = U_GEN_SOLDIER;
					mcc_spawntype="MAN";
				};
				
				case 1:	//Car
				{
					_groupArray = U_GEN_CAR;
					mcc_spawntype="VEHICLE";
				};
				
				case 2:	//Tank
				{
					_groupArray = U_GEN_TANK;
					mcc_spawntype="VEHICLE";
				};
				
				case 3:	//Motorcycle
				{
					_groupArray = U_GEN_MOTORCYCLE;
					mcc_spawntype="VEHICLE";
				};
				
				case 4:	//Helicopter
				{
					_groupArray = U_GEN_HELICOPTER;
					mcc_spawntype="VEHICLE";
				};
				
				case 5:	//Aircraft
				{
					_groupArray = U_GEN_AIRPLANE;
					mcc_spawntype="VEHICLE";
				};
				
				case 6:	//Ship
				{
					_groupArray = U_GEN_SHIP;
					mcc_spawntype="VEHICLE";
				};
						
				case 7:	//DOC
				{
					_groupArray = GEN_DOC1;
					mcc_spawntype="DOC";
				};
				
				case 8:	//AMMO
				{
					_groupArray = U_AMMO;
					mcc_spawntype="AMMO";
				};
				
				case 9:	//Fortifications
				{
					_groupArray = U_FORT;
					mcc_spawntype="AMMO";
				};
					
				case 10:	//Dead Bodies
				{
					_groupArray = U_DEAD_BODIES;
					mcc_spawntype="AMMO";
				};
				
				case 11:	//Furniture
				{
					_groupArray = U_FURNITURE;
					mcc_spawntype="AMMO";
				};
				
				case 12:	//Market
				{
					_groupArray = U_MARKET;
					mcc_spawntype="AMMO";
				};
				
				case 13:	//Misc
				{
					_groupArray = U_MISC;
					mcc_spawntype="AMMO";
				};
				
				case 14:	//Sighns
				{
					_groupArray = U_SIGHNS;
					mcc_spawntype="AMMO";
				};
				
				case 15:	//Warefare
				{
					_groupArray = U_WARFARE;
					mcc_spawntype="AMMO";
				};
				
				case 16:	//Wrecks
				{
					_groupArray = U_WRECKS;
					mcc_spawntype="AMMO";
				};
				
				case 17:	//Houses
				{
					_groupArray = U_HOUSES;
					mcc_spawntype="AMMO";
				};
				
				case 18:	//Ruins
				{
					_groupArray = U_RUINS;
					mcc_spawntype="AMMO";
				};
				
				case 19:	//Garbage
				{
					_groupArray = U_GARBAGE;
					mcc_spawntype="AMMO";
				};
				
				case 20:	//Lamps
				{
					_groupArray = U_LAMPS;
					mcc_spawntype="AMMO";
				};
				
				case 21:	//Containers
				{
					_groupArray = U_CONTAINER;
					mcc_spawntype="AMMO";
				};
				
				case 22:	//Small Items
				{
					_groupArray = U_SMALL_ITEMS;
					mcc_spawntype="AMMO";
				};
				
				case 23:	//structures
				{
					_groupArray = U_STRUCTERS;
					mcc_spawntype="AMMO";
				};
				
				case 24:	//helpers
				{
					_groupArray = U_HELPERS;
					mcc_spawntype="AMMO";
				};
				
				case 25:	//training
				{
					_groupArray = U_TRAINING;
					mcc_spawntype="AMMO";
				};
			};
		mcc_classtype = (_groupArray select (lbCurSel SPAWNCLASS)) select 0;
		mcc_spawnname = (_groupArray select (lbCurSel SPAWNCLASS)) select 1;
		mcc_spawnfaction = (_groupArray select (lbCurSel SPAWNCLASS)) select 2;
		mcc_spawndisplayname = (_groupArray select (lbCurSel SPAWNCLASS)) select 3;
		};

	mcc_spawnwithcrew = (MCC_spawn_empty select (lbCurSel SPAWNEMPTY)) select 1;	//let's add the behavior/awerness
	MCC_empty_index = (lbCurSel SPAWNEMPTY);

	mcc_spawnbehavior = (MCC_spawn_behavior select (lbCurSel SPAWNBEHAVIOR)) select 1;
	MCC_behavior_index = (lbCurSel SPAWNBEHAVIOR);

	mcc_awareness = (MCC_spawn_awereness select (lbCurSel SPAWNAWARNESS)) select 1;
	MCC_awereness_index = (lbCurSel SPAWNAWARNESS);
	mcc_hc = (lbCurSel MCC_ZONE_LOC);
	mcc_track_units = false;
	_nul=[4] execVM MCC_path + "mcc\general_scripts\mcc_SpawnStuff.sqf";
} else {player globalchat "Access Denied"};