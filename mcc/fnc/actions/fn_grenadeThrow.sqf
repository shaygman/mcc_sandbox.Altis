//==================================================================MCC_fnc_grenadeThrow===============================================================================
// Example: [] call MCC_fnc_grenadeThrow;
//===========================================================================================================================================================================
private ["_utility","_vel","_dir","_handPos","_speed","_magData","_magClass","_magMuzzle","_precise","_eh","_ctrl"];
disableSerialization;

_primaryMod = _this select 0;
_magData 	= player getVariable ["MCC_utilityItem",[]];
_precise 	= player getVariable ["MCC_falseGrenadePrecise",2];
_ctrl 		= ((uiNamespace getVariable "mcc_3dObject") displayCtrl 0);

if (count _magData == 0 || str _ctrl == "no control") exitWith {[2] call MCC_fnc_weaponSelect};
_magClass	= _magData select 0;
_magMuzzle	= _magData select 4;

if (player getVariable ["MCC_busy",false]) exitWith {};
player setVariable ["MCC_busy",true];

if (!_primaryMod) exitWith
{
	_precise = (_precise+1) mod 3;
	switch (_precise) do
	{
		case 0: {_ctrl ctrlSetModelDirAndUp [[0,1,0.4],[-1,0,1]]};	//tilt
		case 1: {_ctrl ctrlSetModelDirAndUp [[-0.4,1,0.4],[-1,0,0]]};	//horzintal
		default {_ctrl ctrlSetModelDirAndUp [[0,1,0.4],[0,0,1]]}; //default orientation
	};

	player setVariable ["MCC_falseGrenadePrecise",_precise];
	player setVariable ["MCC_busy",false];
};

switch (_precise) do
{
	case 0:	//Defensive
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
	case 1:	//roll
	{
		_eh = player addEventHandler ["Fired", {
					_velocity = velocity (_this select 6);
					_velocity = [
						0.8 * (_velocity select 0),
						0.8 * (_velocity select 1),
						-0.5*(_velocity select 2)
					  ];

					 (_this select 6) setVelocity _velocity;
				}];

	};
};

player forceWeaponFire [_magMuzzle,_magMuzzle];
sleep 1;
//player removeMagazineGlobal _magClass;
if !(_magClass in (magazines player)) then
{
	player setVariable ["MCC_utilityItem",[]];
	(["mcc_3dObject"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
};


if (!isnil "_eh") then {player removeEventHandler ["fired",_eh]};
player setVariable ["MCC_busy",false];