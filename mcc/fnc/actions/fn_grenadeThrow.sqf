//==================================================================MCC_fnc_grenadeThrow===============================================================================================
// Example: [] call MCC_fnc_grenadeThrow;
//===========================================================================================================================================================================	
private ["_utility","_vel","_dir","_handPos","_item","_speed","_magData","_magClass","_magMuzzle","_precise","_eh"];
_primaryMod = _this select 0;
_item 		= ((player getVariable ["MCC_utilityItem",[objnull,objnull]]) select 0);
_magData 	= ((player getVariable ["MCC_utilityItem",[objnull,objnull]]) select 1);
_precise 	= player getVariable ["MCC_falseGrenadePrecise",true];

if (isNull _item) exitWith {[2] call MCC_fnc_weaponSelect};
_magClass	= _magData select 0;
_magMuzzle	= _magData select 4;

if (player getVariable ["MCC_busy",false]) exitWith {};
player setVariable ["MCC_busy",true];

if (!_primaryMod) exitWith
{
	if (_precise) then 
	{
		_item setVectorDirAndUp [[0,1,0],[-1,0,1]];
		_item attachto [player,[-0.8,0.6,0.2],"head"];
	} 
	else 
	{
		detach _item ;
		_item attachto [player,[-0.4,0.6,0.5],"head"];
	};
	player setVariable ["MCC_falseGrenadePrecise",!_precise];
	player setVariable ["MCC_busy",false];				
};

player removeMagazineGlobal _magClass;

if !(_precise) then
{
	_eh = player addEventHandler ["Fired", {
			_velocity = velocity (_this select 6);
			_velocity = [
				0.4 * (_velocity select 0),
				0.4 * (_velocity select 1),
				1*(_velocity select 2) min 10
			  ];
			  
			 (_this select 6) setVelocity _velocity;
		}];				
};
player forceWeaponFire [_magMuzzle,_magMuzzle];
sleep 1;
if !(_magClass in (magazines player)) then 
{
	deleteVehicle _item;
	player setVariable ["MCC_utilityItem",[objnull,objnull]];
};


if (!isnil "_eh") then {player removeEventHandler ["fired",_eh]};
player setVariable ["MCC_busy",false];