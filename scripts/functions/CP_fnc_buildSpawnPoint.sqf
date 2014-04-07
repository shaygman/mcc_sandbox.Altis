//==================================================================CP_fnc_buildSpawnPoint======================================================================================
//Create a spawn point to the given side - SERVER ONLY
// Example: [[pos, dir, side,size,destructable], "CP_fnc_buildSpawnPoint", false, false] spawn BIS_fnc_MP;
// pos: Array, position
// dir; number, direction 
// side: string, "west", "east"
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
				if (_size == "FOB") then {_building = "Land_Cargo_House_V2_F"} else {_building = "ProtectionZone_Invisible_F"}; 
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
											if ((_this select 4) == "SatchelCharge_Remote_Ammo" || (_this select 4) == "DemoCharge_Remote_Ammo") then [{_this select 2},{0}]; 
										}];  
	if (!_destructable) then {_sphere = "ProtectionZone_Invisible_F" createvehicle (getpos _dummy);_sphere setpos (getpos _dummy)};
	switch (_side) do	{
						case "WEST":		{CP_westSpawnPoints set [count CP_westSpawnPoints, _dummy]; publicvariable "CP_westSpawnPoints"};
						case "EAST":		{CP_eastSpawnPoints set [count CP_eastSpawnPoints, _dummy]; publicvariable "CP_eastSpawnPoints"};
						case "RESISTANCE":	{CP_guarSpawnPoints set [count CP_guarSpawnPoints, _dummy]; publicvariable "CP_guarSpawnPoints"};
					};
}; 