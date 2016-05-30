//============================================================MCC_fnc_setResources====================================================================================
// Starts MCC Campaign
//===========================================================================================================================================================================
private ["_pos","_module","_side","_argName","_resualt"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

//did we get here from the 2d editor?
if (typeName (_module getVariable ["side",true]) == typeName 1) exitWith {

	_side = [_module getVariable ["side",7]] call BIS_fnc_sideType;
	_res = [(_module getVariable ["repair",0]),
	        (_module getVariable ["ammo",0]),
	        (_module getVariable ["fuel",0]),
	        (_module getVariable ["food",0]),
	        (_module getVariable ["meds",0])
	        ];
	waitUntil {time > 1};
	_argName = format ["MCC_res%1",_side];
	missionNamespace setVariable [_argName,_res];
};

_pos = getpos _module;

 _resualt = ["Set Resources",[
 						["Side",["East","West","Resistance"]],
 						["Supplies",3000],
 						["Ammo",3000],
 						["Fuel",3000],
 						["Food",1000],
 						["Meds",1000]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

_side = [east,west,resistance] select (_resualt select 0);
_res = [(_resualt select 1),
        (_resualt select 2),
        (_resualt select 3),
        (_resualt select 4),
        (_resualt select 5)
        ];

_argName = format ["MCC_res%1",_side];
missionNamespace setVariable [_argName,_res];
publicVariable _argName;

deleteVehicle _module;