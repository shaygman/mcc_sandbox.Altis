//==================================================================CP_fnc_buildSpawnPoint======================================================================================
//Create a spawn point to the given side - SERVER ONLY
// Example: [[pos, dir, side,size,destructable], "CP_fnc_buildSpawnPoint", false, false] spawn BIS_fnc_MP;
// pos: Array, position
// dir; number, direction 
// side: string, "west", "east" or "RESISTANCE"
// size: string  "FOB" or  "HQ"
// destructable: Boolean
//==============================================================================================================================================================================
private ["_side","_size","_destructable","_building","_dummy","_sphere","_dir"];
_pos			= _this select 0; 
_dir			= _this select 1; 
_side 			= toupper (_this select 2);			
_size 			= toupper (_this select 3);			
_destructable	= _this select 4; 

if (isServer) then 
{
	switch (_side) do
		{
			case "WEST":	//west
			{ 
				if (_size == "FOB") then {_building = "Land_Cargo_House_V1_F"} else {_building = "ProtectionZone_Invisible_F"}; 
			};
			
			case "EAST":	//east
			{ 
				if (_size == "FOB") then {_building = "Land_Cargo_House_V1_F"} else {_building = "ProtectionZone_Invisible_F"}; 
			};
			case "RESISTANCE":	//east
			{ 
				if (_size == "FOB") then {_building = "Land_Cargo_House_V1_F"} else {_building = "ProtectionZone_Invisible_F"}; 
			};
		};
		
	_dummy = _building createvehicle _pos;
	_dummy setdir _dir;
	_dummy setvariable ["type",_size,true]; 
	_dummy setvariable ["side",_side,true]; 
	_dummy addEventHandler ["handledamage", { 							//Only destroyable with satchel or demo charges
											if ((_this select 4) == "SatchelCharge_Remote_Ammo" || (_this select 4) == "DemoCharge_Remote_Ammo") then {(_this select 0) setVariable ["dead",true,true]; 1}; 
										}];  
	if (!_destructable) then {_sphere = "ProtectionZone_Invisible_F" createvehicle (getpos _dummy);_sphere setpos (getpos _dummy)};
	switch (_side) do	{
						case "WEST":		{[west, _dummy] call BIS_fnc_addRespawnPosition;};
						case "EAST":		{[east, _dummy] call BIS_fnc_addRespawnPosition;};
						case "RESISTANCE":	{[resistance, _dummy] call BIS_fnc_addRespawnPosition;};
						};
					
}; 