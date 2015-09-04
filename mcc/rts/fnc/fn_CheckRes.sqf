//=================================================================MCC_fnc_resCheck==============================================================================
//	Check if side have enough resources
//  Parameter(s):
//     _side: SIDE side
//     _res: ARRAY ["ammo",120]
//
//	OUT <BOOLEAN>
//==============================================================================================================================================================================
private ["_side","_res","_resToCheck","_var","_level","_available"];

_side = [_this,0,missionnamespace,[missionnamespace,sideLogic]] call bis_fnc_param;
_res = [_this,1,missionnamespace,[[]]] call bis_fnc_param;

_available = false;

//Do we have the needed resources
_resToCheck = call compile format ["MCC_res%1",_side];

_var   = _res select 0;
_level = _res select 1;
_available = switch (tolower _var) do
			{
				case "ammo": {if ((_resToCheck select 0)>=_level) then {true} else {false}};
				case "repair": {if ((_resToCheck select 1)>=_level) then {true} else {false}};
				case "fuel": {if ((_resToCheck select 2)>=_level) then {true} else {false}};
				case "food": {if ((_resToCheck select 3)>=_level) then {true} else {false}};
				case "med": {if ((_resToCheck select 4)>=_level) then {true} else {false}};
				case "time": {true};
				default {
					false
				};
			};

_available