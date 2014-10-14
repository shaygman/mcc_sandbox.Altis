#define MCC3D_IDD 8000
#define MCC_UNIT_TYPE 8001
#define MCC_UNIT_CLASS 8002
#define MCC_NAMEBOX 8003 
#define MCC_INITBOX 8004 
#define MCC_PRESETS 8005
#define MCC_SETTING_EMPTY 8006
#define MCC_ZONE_LOC 8007

private ["_type","_groupArray","_3d", "_dlg","_tempText","_presetText","_pos"];
disableSerialization;
_3d = _this select 0;

if (mcc_missionmaker == (name player)) then 
{
	if (_3d == 0) then //Case we are opening the 3D
	{
		MCC3DRuning = true;
		_pos = _this select 1;
		
		while {dialog} do {closeDialog 0; sleep 0.2};
		_nul=["",_pos] call MCC_3D_PLACER;	
		
		while {MCC3DRuning && (alive player) && !isNil "MCC_3D_CAM"} do
		{
			MCC3DgotValue = false; 
			while {!MCC3DgotValue && MCC3DRuning && (alive player) && !isNil "MCC_3D_CAM"} do {sleep 0.1};
			if (MCC3DRuning) then 
			{
				if (MCC_capture_state) then
				{
					 MCC_capture_var = MCC_capture_var + FORMAT ["
										[[%1, %2, '%3', '%4', '%5', %6, '%7', '%8', %9],'MCC_fnc_simpleSpawn',true,false] spawn BIS_fnc_MP;		
										"
										,MCC3DValue select 0
										,MCC3DValue select 1
										,mcc_spawnname
										,mcc_spawntype
										,mcc_spawnfaction
										,mcc_spawnwithcrew
										,MCC_unitInit
										,MCC_unitName
										,mcc_hc
										];
				}	
				else
				{
					_pos = MCC3DValue select 0; 
					
					if (!isnil "Object3D" && (mcc_spawntype=="VEHICLE")) then 
					{
						private "_time"; 
						_time = time + 7; 
						waitUntil {(_pos distance Object3D > 8) || (time >_time)};
					};
					
					[[MCC3DValue select 0, MCC3DValue select 1, mcc_spawnname, mcc_spawntype, mcc_spawnfaction, mcc_spawnwithcrew,MCC_unitInit,MCC_unitName,mcc_hc],"MCC_fnc_simpleSpawn",true,false] spawn BIS_fnc_MP;		
				};
			};
			sleep 0.1;
		};
		
		mcc_isnewzone = false;	//reset stuff
		mcc_grouptype = "";
		mcc_spawntype = "";
		mcc_classtype = "";
		mcc_spawnname = "";
		mcc_spawnfaction = "";
		mcc_resetmissionmaker = false;
		MCC_unitInit = "";
		MCC_unitName = "";
	};
		
	if (_3d == 1) then //Case we are changing the object
	{
		if (!MCC3DInitDone) exitWith {};
		
		_type = lbCurSel MCC_UNIT_TYPE;
		switch (_type) do	
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
				
				case 26:	//Mines
				{
					_groupArray = U_MINES;
					mcc_spawntype="MINES";
				};
				
				case 27:	//Animals
				{
					_groupArray = U_ANIMALS;
					mcc_spawntype="ANIMAL";
				};
				
				case 28:	//S - Airport
				{
					_groupArray = S_AIRPORT;
					mcc_spawntype="AMMO";
				};
				
				case 29:	//S - Military 
				{
					_groupArray = S_MILITARY;
					mcc_spawntype="AMMO";
				};
				
				case 30:	//S - Cultural 
				{
					_groupArray = S_CULTURAL;
					mcc_spawntype="AMMO";
				};
				
				case 31:	//S - Walls 
				{
					_groupArray = S_WALLS;
					mcc_spawntype="AMMO";
				};
				
				case 32:	//S - Infrasructures 
				{
					_groupArray = S_INFRAS;
					mcc_spawntype="AMMO";
				};
				
				case 33:	//S - commercial 
				{
					_groupArray = S_COMMERSIAL;
					mcc_spawntype="AMMO";
				};
				
				case 34:	//S - industrial 
				{
					_groupArray = S_INDUSTRIAL;
					mcc_spawntype="AMMO";
				};
				
				case 35:	//S - TOWN 
				{
					_groupArray = S_TOWN;
					mcc_spawntype="AMMO";
				};
				
				case 36:	//S - Village 
				{
					_groupArray = S_VILLAGE;
					mcc_spawntype="AMMO";
				};
				
				case 37:	//S - Fences 
				{
					_groupArray = S_FENCES;
					mcc_spawntype="AMMO";
				};
				
				case 38:	//S - General 
				{
					_groupArray = U_STRUCTERS;
					mcc_spawntype="AMMO";
				};
				
				case 39:	//O_BACKPACKS
				{
					_groupArray = O_BACKPACKS;
					mcc_spawntype="AMMO";
				};
				
				case 40:	//O_INTEL
				{
					_groupArray = O_INTEL;
					mcc_spawntype="AMMO";
				};
				
				case 41:	//O_ITEMS
				{
					_groupArray = O_ITEMS;
					mcc_spawntype="AMMO";
				};
				
				case 42:	//O_HEADGEAR
				{
					_groupArray = O_HEADGEAR;
					mcc_spawntype="AMMO";
				};
				
				case 43:	//O_UNIFORMS
				{
					_groupArray = O_UNIFORMS;
					mcc_spawntype="AMMO";
				};
				
				case 44:	//O_VESTS
				{
					_groupArray = O_VESTS;
					mcc_spawntype="AMMO";
				};
				
				case 45:	//O_WEAPONSACCES
				{
					_groupArray = O_WEAPONSACCES;
					mcc_spawntype="AMMO";
				};
				
				case 46:	//O_WEAPONSHANDGUNS
				{
					_groupArray = O_WEAPONSHANDGUNS;
					mcc_spawntype="AMMO";
				};
				
				case 47:	//O_WEAPONSPRIMARY
				{
					_groupArray = O_WEAPONSPRIMARY;
					mcc_spawntype="AMMO";
				};
				
				case 48:	//O_WEAPONSPRIMARY
				{
					_groupArray = O_WEAPONSSECONDARY;
					mcc_spawntype="AMMO";
				};
				
				case 49:	//O_RESPWN
				{
					_groupArray = O_RESPWN;
					mcc_spawntype="AMMO";
				};
				
				case 50:	//O_SOUNDS
				{
					_groupArray = O_SOUNDS;
					mcc_spawntype="AMMO";
				};
				
			};
			
		if ((lbCurSel MCC_UNIT_CLASS) != -1) then
		{
			mcc_classtype = (_groupArray select (lbCurSel MCC_UNIT_CLASS)) select 0;
			mcc_spawnname = (_groupArray select (lbCurSel MCC_UNIT_CLASS)) select 1;
			mcc_spawnfaction = (_groupArray select (lbCurSel MCC_UNIT_CLASS)) select 2;
			mcc_spawndisplayname = (_groupArray select (lbCurSel MCC_UNIT_CLASS)) select 3;
			MCC_unitInit = ctrlText MCC_INITBOX;
			MCC_unitName = ctrlText MCC_NAMEBOX;
		};
		
		mcc_spawnwithcrew = (MCC_spawn_empty select (lbCurSel MCC_SETTING_EMPTY)) select 1;	//let's add the behavior/awerness
		MCC_empty_index = (lbCurSel MCC_SETTING_EMPTY);
		mcc_hc = (MCC_ZoneLocation select (lbCurSel MCC_ZONE_LOC)) select 1;
		
		if (! isnil "Object3D") then {deletevehicle Object3D};
		if (mcc_spawntype == "MINES") then	
		{
				Object3D = createMine [mcc_spawnname,[0,0,500], [], 0];
				Object3D enableSimulationGlobal true;
				Object3D AddEventHandler ["HandleDamage", {False}];
		}
		else	
		{
			Object3D = mcc_spawnname createvehicleLocal [0,0,500];	
			if (isnull Object3D) then {Object3D = "Sign_Arrow_Direction_F" createvehicle [0,0,500]}; 
			Object3D enableSimulationGlobal true;
			Object3D AddEventHandler ["HandleDamage", {False}];
		};
	};
		
	if (_3d == 2) then //Case we adding presets
	{	
		_type = lbCurSel MCC_UNIT_TYPE;
		_presets = [];
		if (_type in [0]) then {_presets = mccPresetsUnits};
		if (_type in [1,2,3,4,5,6]) then {_presets = mccPresetsVehicle}; 
		if (_type > 7) then {_presets = mccPresetsObjects};
		
		_tempText = ctrlText MCC_INITBOX;
		_presetText = (_presets select(lbCurSel MCC_PRESETS)) select 1; 
		ctrlSetText [MCC_INITBOX,format ["%1 %2",_tempText,_presetText]];
		_null = [1] execVM format["%1mcc\pop_menu\spawn_group3d.sqf",MCC_path];
	};
} 
else 
{
	player globalchat "Access Denied";
};	
	
	


 
		