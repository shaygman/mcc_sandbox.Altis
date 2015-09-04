private ["_mccdialog","_comboBox","_displayname","_pic", "_index", "_array", "_class","_boxName","_tempBox","_displayArray","_sel"];
waituntil {dialog};
disableSerialization;

_mccdialog = _this select 0;
uiNamespace setVariable ["MCC_rtsMainBox", _mccdialog];

//Do we have a box for our side?
_boxName = format ["MCC_rtsMainBox%1",playerSide];
if (isnil _boxName) then
{
	_tempBox = "ReammoBox_F" createvehicle [0,0,(random 200)+200];
	_tempBox enableSimulation false;
	_tempBox allowDamage false;
	missionNamespace setVariable [_boxName, _tempBox];
	publicVariable _boxName;
};

//Don't have the box exit
_tempBox = missionNamespace getVariable [_boxName, objNull];
if (isNull _tempBox) exitWith {};

//Get valor points
(_mccdialog displayCtrl 4) ctrlSetText str (player getVariable ["MCC_valorPoints",50]);
//index load

_comboBox = _mccdialog displayCtrl 2;
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["Binoculars", "Items","Uniforms", "Launchers", "Machine Guns", "Pistols", "Rifles","Sniper Rifles","Magazines","Under Barrel","Grenades","Explosive","Survival"];

_comboBox lbSetCurSel 0;


_displayArray = [];
_sel   = lbCurSel 2;

{
	disableSerialization;
	_array = [_sel, _x==0, _tempBox] call MCC_fnc_boxMakeWeaponsArray;
	_comboBox = _mccdialog displayCtrl _x;
	lbClear _comboBox;

	{
		_displayname 	= _x select 0;
		_class 			= _x select 1;
		_pic 			= _x select 2;
		_valor			= _x select 3;
		_valor = _valor * (switch _sel  do
							{
							    case 0: {10};
							    case 1: {10};
							    case 2: {15};
							    case 3: {40};
							    case 4: {30};
							    case 5: {20};
							    case 6: {25};
							    case 7: {45};
							    case 8: {10};
							    case 9: {5};
							    case 10: {5};
							    case 11: {20};
							    default {1};
							});
		if !(_displayname in _displayArray) then
		{
			_index 			= _comboBox lbAdd (format ["%1 X %2",_displayname, ({_displayname== (_x select 0)} count _array)]);
			_comboBox lbSetPicture [_index, _pic];
			_comboBox lbSetData [_index, _class];
			_comboBox lbSetTooltip [_index,format ["%1 Valor points", _valor]];
			_displayArray pushback _displayname;
		};

	} foreach _array;

	_comboBox lbSetCurSel 0;
} foreach [0,1];

_mccdialog spawn
{
	private ["_array"];
	disableSerialization;

	while {(str (_this displayCtrl 0) != "No control")} do
	{
		//Load available resources
		_array = call compile format ["MCC_res%1",playerside];
		{_this displayCtrl _x ctrlSetText str floor (_array select _forEachIndex)} foreach [81,82,83,84,85];
	};
};

