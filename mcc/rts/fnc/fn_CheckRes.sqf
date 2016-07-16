//=================================================================MCC_fnc_checkRes==============================================================================
//	Check if side have enough resources
//  Parameter(s):
//     _side: SIDE side
//     _res: ARRAY ["ammo",120]
//
//	OUT <BOOLEAN>
//==============================================================================================================================================================================
private ["_side","_res","_resToCheck","_var","_level","_available"];

_side = param [0,missionnamespace,[missionnamespace,sideLogic]];
_res = param [1,missionnamespace,[[]]];

_available = false;

//Do we have the needed resources
_resToCheck = call compile format ["MCC_res%1",_side];

_var   = _res select 0;
_level = _res select 1;
_available = switch (tolower _var) do
			{
				case "ammo": {(_resToCheck select 0)>=_level};
				case "repair": {(_resToCheck select 1)>=_level};
				case "fuel": {(_resToCheck select 2)>=_level};
				case "food": {(_resToCheck select 3)>=_level};
				case "med": {(_resToCheck select 4)>=_level};
				case "time": {true};
				default {
					false
				};
			};

_available