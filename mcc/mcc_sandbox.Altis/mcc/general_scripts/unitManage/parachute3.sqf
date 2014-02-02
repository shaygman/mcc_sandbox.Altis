private ["_pos", "_unit", "_halo","_hight","_headgear","_uniform","_backpack","_backPackItems","_uniformItems""_paracute","_jumperNumber","_packHolder"];
_pos 			= _this select 0;
_unit			= if (((_this select 1) select 0) == "") then {(_this select 1) select 1} else {objectFromNetId ((_this select 1) select 0)};
if (isNil "_unit") exitWIth {};
_halo			= _this select 2;
_hight			= _this select 3; 
_jumperNumber	= _this select 4; 


if (isnil "mcc_isparajuming") then {mcc_isparajuming = false}; 
if (!local _unit || mcc_isparajuming) exitWith {}; 

mcc_isparajuming = true; 
if (isPlayer _unit) then {							//If is player make some effects
	cutText ["Get ready to jump","BLACK OUT",1];
	sleep 3; 
	playmusic "ac130";
	}; 

if (_halo) then {							//HALO
		_headgear = headgear _unit; 		//Remove uniforms and add HALO gear
		_uniform = uniform _unit; 
		_backpack = backpack _unit;
		_backPackItems = backPackItems _unit;
		_uniformItems = uniformItems _unit;

		removeHeadgear _unit;
		removeUniform _unit;
		removeBackpack _unit;

		_unit addHeadgear "H_CrewHelmetHeli_B";
		_unit addUniform "U_B_HeliPilotCoveralls";
		_unit addBackpack "B_Parachute";
		
		if (_backpack != "") then 
			{
				_packHolder = createVehicle ["groundWeaponHolder", [0,0,0], [], 0, "can_collide"]; //create an empty holder 
				_packHolder addBackpackCargo [_backpack, 1]; //place your old backpack into the empty holder
				_packHolder attachTo [_unit,[0.1,0.56,-.72],"pelvis"]; //attach empty holder to unit
				_packHolder setVectorDirAndUp [[0,1,0],[0,0,-1]]; //set the vector and direction of the empty holder
			};
		
		_unit setpos [(_pos select 0) + (_jumperNumber*20), _pos select 1,_hight];
		sleep 5;	
		if (isPlayer _unit) then {
			cutText ["","BLACK IN",3]; 
			playmusic ""; 
			}; 
		
			
		while {alive _unit && (vehicle _unit == _unit) && (isplayer _unit)} do {playmusic "mcc_wind"; sleep 4.6}; 
		
		//Opening Chute
		if (_backpack != "") then 
			{
				_packHolder attachTo [vehicle _unit,[0.1,0.72,0.52],"pelvis"]; //attach the empty holder to the new position
				_packHolder setVectorDirAndUp [[0,0.1,1],[0,1,0.1]]; //set the new vector direction
			};		
		
		while {alive _unit && (((getpos _unit) select 2)> 1) && !isTouchingGround _unit} do {sleep 1};  		//Remove HALO gear and add normal gear
		if (!alive _unit) exitwith {}; 

		if (isPlayer _unit) then {cutText ["Changing Gear","BLACK OUT",0.5]};	
		if (!isnil "_packHolder") then {deleteVehicle _packHolder}; //delete the temp backpack and empty holder  
		if (_headgear != "") then {removeHeadgear _unit; _unit addHeadgear _headgear};
		if (_uniform != "") then {removeUniform _unit; _unit addUniform _uniform};
		if (_backpack != "") then {removeBackpack _unit; _unit addBackpack _backpack};
		
		_paracute = "B_Parachute" createVehicle (getpos _unit) ; 

		{
			switch (true) do
				{
					case (isClass (configFile >> "CfgMagazines" >> _x)) : {(unitBackpack _unit) addMagazineCargoGlobal [_x,1]};
					case (isClass (configFile >> "CfgWeapons" >> _x)) : {(unitBackpack _unit) addItemCargoGlobal [_x,1]};
					case (isClass (configFile >> "CfgGlasses" >> _x)) : {(unitBackpack _unit) addItemCargoGlobal [_x,1]};
				}; 
		} foreach _backPackItems;
		
		{
			switch (true) do
			{
				case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
				case (isClass (configFile >> "CfgWeapons" >> _x)) : {player additem _x};
				case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x};
			}; 
		} foreach _uniformItems;

		sleep 3; 
		if (isPlayer _unit) then {cutText ["","BLACK IN",2]};	
	}; 
	
if (!_halo) then {							//Parachute
		_backpack = backpack _unit;
		_backPackItems = backPackItems _unit;
		removeBackpack _unit;
		
		_unit addBackpack "B_Parachute";
		_unit setpos [(_pos select 0) + (_jumperNumber*20), _pos select 1,_hight];
		
		_packHolder = createVehicle ["groundWeaponHolder", [0,0,0], [], 0, "can_collide"]; //create an empty holder 
		_packHolder addBackpackCargo [_backpack, 1]; //place your old backpack into the empty holder
		_packHolder attachTo [_unit,[0.1,0.56,-.72],"pelvis"]; //attach empty holder to unit
		_packHolder setVectorDirAndUp [[0,1,0],[0,0,-1]]; //set the vector and direction of the empty holder
		
		sleep 3;	
		if (isPlayer _unit) then {
			cutText ["","BLACK IN",1]; 
			playmusic ""; 
			}; 
		
		while {alive _unit && (vehicle _unit == _unit) && (isplayer _unit)} do {playmusic "mcc_wind"; sleep 4.6}; 
		
		//Opening Chute
		_packHolder attachTo [vehicle _unit,[0.1,0.72,0.52],"pelvis"]; //attach the empty holder to the new position
		_packHolder setVectorDirAndUp [[0,0.1,1],[0,1,0.1]]; //set the new vector direction
		
		while {alive _unit && (((getpos _unit) select 2)> 1)} do {sleep 1}; 		//Remove gear and add normal gear
		if (!alive _unit) exitwith {}; 

		if (isPlayer _unit) then {cutText ["Changing Gear","BLACK OUT",0.5]};	
		deleteVehicle _packHolder; //delete the temp backpack and empty holder  
		
		if (_backpack != "") then {removeBackpack _unit; _unit addBackpack _backpack};

		_paracute = "B_Parachute" createVehicle (getpos _unit) ; 

		{
			switch (true) do
				{
					case (isClass (configFile >> "CfgMagazines" >> _x)) : {(unitBackpack _unit) addMagazineCargoGlobal [_x,1]};
					case (isClass (configFile >> "CfgWeapons" >> _x)) : {(unitBackpack _unit) addItemCargoGlobal [_x,1]};
					case (isClass (configFile >> "CfgGlasses" >> _x)) : {(unitBackpack _unit) addItemCargoGlobal [_x,1]};
				}; 
		} foreach _backPackItems;

		sleep 3; 
		if (isPlayer _unit) then {cutText ["","BLACK IN",2]};	
	};
mcc_isparajuming = false; 

