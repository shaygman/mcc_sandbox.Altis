private ["_pos", "_unitID", "_unit", "_halo","_hight","_headgear","_uniform","_backpack","_backPackItems","_paracute","_jumperNumber"];
_pos 			= _this select 0;
_unitID 		= _this select 1;
if (isNil "_unitID") exitWIth {};
_unit			= objectFromNetId _unitID;
_halo			= _this select 2;
_hight			= _this select 3; 
_jumperNumber	= _this select 4; 


if (!local _unit) exitWith {}; 


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

		removeHeadgear _unit;
		removeUniform _unit;
		removeBackpack _unit;

		_unit addHeadgear "H_PilotHelmetFighter_I";
		_unit addUniform "U_B_HeliPilotCoveralls";
		_unit addBackpack "B_Parachute";

		_unit setpos [(_pos select 0) + (_jumperNumber*20), _pos select 1,_hight];
		sleep 5;	
		if (isPlayer _unit) then {
			cutText ["","BLACK IN",3]; 
			playmusic ""; 
			}; 

		while {alive _unit && (((getpos _unit) select 2)> 1)} do {sleep 1}; 		//Remove HALO gear and add normal gear
		if (!alive _unit) exitwith {}; 

		if (isPlayer _unit) then {cutText ["Changing Gear","BLACK OUT",0.5]};	

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

		sleep 3; 
		if (isPlayer _unit) then {cutText ["","BLACK IN",2]};	
	}; 
	
if (!_halo) then {							//Parachute
		_backpack = backpack _unit;
		_backPackItems = backPackItems _unit;
		removeBackpack _unit;
		
		_unit addBackpack "B_Parachute";
		_unit setpos [(_pos select 0) + (_jumperNumber*20), _pos select 1,_hight];
		sleep 3;	
		if (isPlayer _unit) then {
			cutText ["","BLACK IN",1]; 
			playmusic ""; 
			}; 
			
		while {alive _unit && (((getpos _unit) select 2)> 1)} do {sleep 1}; 		//Remove gear and add normal gear
		if (!alive _unit) exitwith {}; 

		if (isPlayer _unit) then {cutText ["Changing Gear","BLACK OUT",0.5]};	

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


