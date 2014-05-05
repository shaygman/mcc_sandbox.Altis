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

private ["_type","_groupArray","_nul","_zonePos","_comboBox","_group","_mccdialog"];
disableSerialization;
if (mcc_missionmaker == (name player)) then 
{
	if (count mcc_zone_pos == 0) exitWith {hint "Create a zone first"};	//Failsafe incase we trying to spawn something without making a zone first
	_zonePos = (mcc_zone_pos select (lbCurSel MCCZONENUMBER)+1);
	if (isnil "_zonePos") exitWith {hint "Create a zone first"};	//Failsafe incase we trying to spawn something without making a zone first
	//Group
	if ((lbCurSel SPAWNTYPE) == 1) then 
	{	
		if (((MCC_groupTypes select (lbCurSel SPAWNBRANCH) select 0)) =="Reinforcement") exitWith 	//Paratroopers
		{
			mcc_spawnname = (lbCurSel SPAWNCLASS);    //MCCR14 remove
			mcc_spawntype="Reinforcement";
			mcc_classtype = "Reinforcement";
			//mcc_spawnfaction = mcc_sidename;
			mcc_spawnfaction = mcc_faction;
			
			click = false;

			hint parseText format["<br/>--------------------------<br/>	
			<br/><t size='1.2' color='#33CC00'>Left click on the map to set start location (direction) of reinforcement</t><br/>
			<br/>--------------------------<br/>"]; 
			
			onMapSingleClick "mcc_spawn_dir = _pos;
			click = true;
			onMapSingleClick """";" ;
				
			waitUntil {(click)};
			hintsilent "";
			click = false;
		};  
		
		 //Garrison
		if (((MCC_groupTypes select (lbCurSel SPAWNBRANCH) select 0)) =="Garrison") exitWith 
		{							
			private ["_center","_radius","_action","_intanse","_faction"];
			_center = (mcc_zone_pos select (mcc_zone_number));
			_radius = (((mcc_zone_size select (mcc_zone_number))select 0) + ((mcc_zone_size select (mcc_zone_number)) select 1))/2;
			_faction = getText (configFile >> "CfgVehicles" >> (U_GEN_SOLDIER select 0 select 1) >> "faction");
			
			switch (lbCurSel SPAWNCLASS) do		
				{
				   case 0:	//Light
					{
						_action 	= 0;
						_intanse 	= 0.5;
					};
					
					 case 1:	//Light -vehicles
					{
						_action 	= 1;
						_intanse 	= 0.5;
					};
					
					 case 2:	//Heavy
					{
						_action 	= 0;
						_intanse 	= 1.5;
					};
					
					 case 3:	//Heavy -vehicles
					{
						_action 	= 1;
						_intanse 	= 1.5;
					};
				};
			if (MCC_capture_state) then	
			{
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
			} 
			else 
			{
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
		
		//Custom 
		if (((MCC_groupTypes select (lbCurSel SPAWNBRANCH) select 0)) =="Custom") then 
		{	
			private "_group";
			_mccdialog = findDisplay MCC_SANDBOX_IDD;	
			_comboBox = _mccdialog displayCtrl SPAWNCLASS;	
			_group = MCC_customGroupsSave select (call compile (_comboBox lbData (lbCurSel SPAWNCLASS)));
			mcc_classtype = _group select 1;
			mcc_spawnname = _group select 3;
			mcc_spawnfaction = _group select 2;
			mcc_spawndisplayname = _group select 3;
		}
		else
		{
			mcc_classtype = (MCC_groupArray select (lbCurSel SPAWNCLASS)) select 0;
			mcc_spawnname = (MCC_groupArray select (lbCurSel SPAWNCLASS)) select 1;
			mcc_spawnfaction = (MCC_groupArray select (lbCurSel SPAWNCLASS)) select 2;
			mcc_spawndisplayname = (MCC_groupArray select (lbCurSel SPAWNCLASS)) select 3;
		};
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
			
			case 15:	//Flags
			{
				_groupArray = U_FLAGS;
				mcc_spawntype="AMMO";
			};
			
			case 16:	//Warefare
			{
				_groupArray = U_MILITARY;
				mcc_spawntype="AMMO";
			};
			
			case 17:	//Small Items
			{
				_groupArray = U_SMALL_ITEMS;
				mcc_spawntype="AMMO";
			};
			
			case 18:	//Wrecks
			{
				_groupArray = U_WRECKS;
				mcc_spawntype="AMMO";
			};
			
			case 19:	//Houses
			{
				_groupArray = U_SUBMERGED;
				mcc_spawntype="AMMO";
			};
			
			case 20:	//Tents
			{
				_groupArray = U_TENTS;
				mcc_spawntype="AMMO";
			};
			
			case 21:	//Garbage
			{
				_groupArray = U_GARBAGE;
				mcc_spawntype="AMMO";
			};
			
			case 22:	//Lamps
			{
				_groupArray = U_LAMPS;
				mcc_spawntype="AMMO";
			};
			
			case 23:	//Containers
			{
				_groupArray = U_CONTAINER;
				mcc_spawntype="AMMO";
			};
			
			case 24:	//structures
			{
				_groupArray = U_STRUCTERS;
				mcc_spawntype="AMMO";
			};
			
			case 25:	//helpers
			{
				_groupArray = U_HELPERS;
				mcc_spawntype="AMMO";
			};
			
			case 26:	//training
			{
				_groupArray = U_TRAINING;
				mcc_spawntype="AMMO";
			};
			
			case 27:	//Animals
			{
				_groupArray = U_ANIMALS;
				mcc_spawntype="ANIMAL";
			};
		};
		mcc_classtype = (_groupArray select (lbCurSel SPAWNCLASS)) select 0;
		mcc_spawnname = (_groupArray select (lbCurSel SPAWNCLASS)) select 1;
		mcc_spawnfaction = (_groupArray select (lbCurSel SPAWNCLASS)) select 2;
		mcc_spawndisplayname = (_groupArray select (lbCurSel SPAWNCLASS)) select 3;
	};

	mcc_spawnwithcrew = (MCC_spawn_empty select (lbCurSel SPAWNEMPTY)) select 1;	//let's add the behavior/awerness
	MCC_empty_index = (lbCurSel SPAWNEMPTY);

	mcc_spawnbehavior = (MCC_spawn_behaviors select (lbCurSel SPAWNBEHAVIOR)) select 1;
	MCC_behavior_index = (lbCurSel SPAWNBEHAVIOR);

	mcc_awareness = (MCC_spawn_awereness select (lbCurSel SPAWNAWARNESS)) select 1;
	MCC_awereness_index = (lbCurSel SPAWNAWARNESS);
	mcc_hc = (lbCurSel MCC_ZONE_LOC);
	mcc_track_units = false;
	
	_nul=[4] execVM MCC_path + "mcc\general_scripts\mcc_SpawnStuff.sqf";
} 
else 
{
	player globalchat "Access Denied";
};