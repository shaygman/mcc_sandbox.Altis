//=================================================================MCC_fnc_baseResourceReduce==============================================================================
//	Remove resources
//  Parameter(s):
//     _var:string "ammo","repair","fuel","food", "med", "time"
//     _level: INTEGER the ammount of reousrces to reduce
//==============================================================================================================================================================================
private ["_resToCheck","_var","_level","_res"];
//removes resources

_res = _this select 0;
_resToCheck = call compile format ["MCC_res%1",playerSide];
{
	_var   = _x select 0;
	_level = _x select 1;

	switch (tolower _var) do
				{
					case "ammo": {_resToCheck set [0,(_resToCheck select 0)-_level]};
					case "repair": {_resToCheck set [1,(_resToCheck select 1)-_level]};
					case "fuel": {_resToCheck set [2,(_resToCheck select 2)-_level]};
					case "food": {_resToCheck set [3,(_resToCheck select 3)-_level]};
					case "med": {_resToCheck set [4,(_resToCheck select 4)-_level]};
					case "time": {};
				};
} foreach _res;

missionNameSpace setVariable [format ["MCC_res%1",playerSide],_resToCheck];
publicVariable format ["MCC_res%1",playerSide];