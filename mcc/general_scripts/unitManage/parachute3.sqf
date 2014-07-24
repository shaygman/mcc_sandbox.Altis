private ["_pos", "_unit", "_halo","_height", "_gwh", "_gwhpos", "_headgear", "_uniform", "_backpack", "_backPackItems",
	"_uniformItems", "_parachute", "_jumperNumber", "_chute", "_packHolder"];
_pos 			= _this select 0;
_unit			= if (((_this select 1) select 0) == "") then {(_this select 1) select 1} else {objectFromNetId ((_this select 1) select 0)};
if (isNil "_unit") exitWIth {};
_halo			= _this select 2;
_height			= _this select 3; 
_jumperNumber	= _this select 4; 
_packHolder 	= objNull;

if ( !(isPlayer _unit) && { (_unit == leader _unit) } ) then
{
	_unit setDir ( random 360 );
};

//if (isnil "mcc_isparajuming") then {mcc_isparajuming = false}; 
if (!local _unit || _unit getVariable ["mcc_isparajuming", false]) exitWith {}; 

_unit setVariable ["mcc_isparajuming", true]; 

if (isPlayer _unit) then {							//If is player make some effects
	cutText ["Get ready to jump","BLACK OUT",1];
	sleep 3; 
	playmusic "ac130";
}; 

if (_halo) then 
{		
		//HALO
		_headgear = headgear _unit; 		//Remove uniforms and add HALO gear
		_uniform = uniform _unit; 
		_uniformItems = uniformItems _unit;
		
		_backpack = backpack _unit;
		_backPackItems = backPackItems _unit;

		removeHeadgear _unit;
		removeUniform _unit;
		removeBackpack _unit;

		_unit addHeadgear "H_CrewHelmetHeli_B";
		_unit forceAddUniform  "U_B_HeliPilotCoveralls";

		if ( isPlayer _unit ) then 
		{
			if (_backpack != "") then 
			{
				_packHolder = createVehicle ["groundWeaponHolder", getPos _unit, [], 0, "can_collide"]; //create an empty holder 
				_packHolder addBackpackCargo [_backpack, 1]; //place your old backpack into the empty holder
				_packHolder attachTo [_unit,[0.1,0.56,-.72],"pelvis"]; //attach empty holder to unit
				_packHolder setVectorDirAndUp [[0,1,0],[0,0,-1]]; //set the vector and direction of the empty holder				
			};

			_unit addBackpack "B_Parachute";
		};

		_unit setpos [(_pos select 0) + (_jumperNumber*20), _pos select 1,_height];

		sleep 2;
		
		if ( isPlayer _unit ) then 
		{
			cutText ["","BLACK IN",1]; 
			playmusic ""; 

			while { alive _unit && (vehicle _unit == _unit) } do {playmusic "mcc_wind"; sleep 4.6}; 
			
			//Opening Chute
			if (_backpack != "") then 
			{
				_packHolder = nearestObject [getPos _unit, "GroundWeaponHolder"];
				_packHolder attachTo [vehicle _unit,[0.1,0.72,0.52],"pelvis"]; //attach the empty holder to the new position
				_packHolder setVectorDirAndUp [[0,0.1,1],[0,1,0.1]]; //set the new vector direction
			};	
		}
		else
		{
			_unit allowDamage false;
			_dir = direction (leader _unit);
			waitUntil { (((getPosATL _unit) select 2) < 180) || !(alive _unit) };
			_parachute = createVehicle ["NonSteerable_Parachute_F", position _unit, [], ((_dir)-3+(random 6)), 'NONE'];
			_parachute setPos (getPos _unit);
			_unit moveindriver _parachute;
		};
		
		while {alive _unit && (((getpos _unit) select 2)> 1) && !isTouchingGround _unit} do {sleep 1};  

		if !(alive _unit) exitwith {}; 
		
		if ( isPlayer _unit ) then
		{
			if (!isnil "_packHolder") then 
			{
				detach _packHolder;
				deleteVehicle _packHolder; //delete the temp backpack and empty holder  
				_unit addBackpack _backpack;
				
				clearItemCargoGlobal unitBackpack _unit; // delete all default items from backback 
				
				// add original backpack load again
				{
					switch (true) do
						{
							case (isClass (configFile >> "CfgMagazines" >> _x)) : {(unitBackpack _unit) addMagazineCargoGlobal [_x,1]};
							case (isClass (configFile >> "CfgWeapons" >> _x)) : {(unitBackpack _unit) addItemCargoGlobal [_x,1]};
							case (isClass (configFile >> "CfgGlasses" >> _x)) : {(unitBackpack _unit) addItemCargoGlobal [_x,1]};
						}; 
				} foreach _backPackItems;
			};

			sleep 0.05;
			
			// Add parachute backpack, this will place backpack on the ground near player
			_unit addBackpack "B_Parachute";
			
			hintSilent "pickup backpack or drop parachute to change gear";
			
			//Only if player grabs backpack the change gear scenario will be started
			_timeOut = time + 600; 
			while { (alive _unit) && (backpack _unit == "B_Parachute") && (time < _timeOut) } do { sleep 0.5;};
			
			// if killed or after 10 minutes still no gear change exit HALO script
			if ( !(alive _unit) || ( time > _timeOut )) exitwith {}; 
			
			//Remove HALO gear and add normal gear
			cutText ["Changing Gear","BLACK OUT",0.5];	

			if (_headgear != "") then { removeHeadgear _unit; _unit addHeadgear _headgear };
			if (_uniform != "") then { removeUniform _unit; _unit forceAddUniform  _uniform };
			
			{
				switch (true) do
				{
					case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
					case (isClass (configFile >> "CfgWeapons" >> _x)) : {player additem _x};
					case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x};
				}; 
			} foreach _uniformItems;
			sleep 4;
			cutText ["","BLACK IN",2];
		}
		else 
		{
			if (_headgear != "") then { removeHeadgear _unit; _unit addHeadgear _headgear };
			if (_uniform != "") then { removeUniform _unit; _unit forceAddUniform  _uniform };
			
			{
				switch (true) do
				{
					case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
					case (isClass (configFile >> "CfgWeapons" >> _x)) : {player additem _x};
					case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x};
				}; 
			} foreach _uniformItems;
		
			_unit setCombatMode "AWARE";
		};		
}; 
	
if (!_halo) then 
{
	//Parachute
	_height = 500;
	_unit setpos [(_pos select 0) + (_jumperNumber*20), _pos select 1,_height];
	
	sleep 2;
	
	_dir = direction (leader _unit);
	
	_unit allowDamage false;	
	_backpack =  backpack _unit;
	
	if (_backpack != "") then 
	{
		_packHolder = createVehicle ["groundWeaponHolder", [0,0,0], [], 0, "can_collide"]; //create an empty holder 
		_packHolder addBackpackCargo [_backpack, 1]; //place your old backpack into the empty holder
		_packHolder attachTo [_unit,[0.1,0.56,-.72],"pelvis"]; //attach empty holder to unit
		_packHolder setVectorDirAndUp [[0,1,0],[0,0,-1]]; //set the vector and direction of the empty holder
	};
		
	if !(isPlayer _unit) then 
	{
		waitUntil { (((getPosATL _unit) select 2) < 225) || !(alive _unit) };
		_chute = "NonSteerable_Parachute_F";
		
		_dir = direction (leader _unit);	
		_unit setDir _dir;
	}
	else
	{
		cutText ["","BLACK IN",1]; 
		playmusic ""; 
		_chute = "Steerable_Parachute_F";
		while {alive _unit && (((getPosATL _unit) select 2) > 350) } do {playmusic "mcc_wind"; sleep 4.6}; // MCC NOTE: Check when this should end
	};
	
	_parachute = createVehicle [_chute, position _unit, [], ((_dir)-3+(random 6)), 'NONE'];
	_parachute setPos (getPos _unit);
	
	_unit moveindriver _parachute;
	_unit allowDamage true;
	
	//Opening Chute
	if (!isnil "_packHolder") then 
	{
		_packHolder attachTo [vehicle _unit,[0.1,0.72,0.52],"pelvis"]; //attach the empty holder to the new position
		_packHolder setVectorDirAndUp [[0,0.1,1],[0,1,0.1]]; //set the new vector direction
	};	
	
	while { (alive _unit) && (((getpos _unit) select 2)> 1) && !(isTouchingGround _unit) } do {sleep 1}; 
	if (!alive _unit) exitwith {}; 
	
	if (isPlayer _unit) then 
	{
		if (!isnil "_packHolder") then 
		{
			deleteVehicle _packHolder; //delete the temp backpack and empty holder  
		};
		_parachute = "B_Parachute" createVehicle (getpos _unit); 
		sleep 0.3;
		_parachute setPos (getpos _unit);
	}
	else
	{
		_unit setCombatMode "AWARE";
	};	
};
	
_unit setVariable ["mcc_isparajuming", false]; 