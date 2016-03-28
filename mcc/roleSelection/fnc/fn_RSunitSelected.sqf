/*==================================================================MCC_fnc_RSunitSelected======================================================================================
// Call from a listbox only
==============================================================================================================================================================================*/
disableSerialization;

params ["_listBoxCtrl","_unit","_index","_parentCtrl"];
private ["_disp","_ctrl","_array","_class","_displayname","_pic","_index","_ctrlPos"];
_unit = objectFromNetId _unit;
_disp = ctrlParent _listBoxCtrl;
_ctrlPos = ctrlPosition (_disp displayCtrl _parentCtrl);

_hight = 0.023* safezoneH;

_array = [];
if (player == leader _unit && _unit != player) then {
	_array pushBack ["kick","Kick",format ["%1data\IconPhysical.paa",MCC_path]];
};

if (player == leader _unit && _unit != player) then {
	_array pushBack ["commander","Promot to Leader","\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"];
};

if ((missionNamespace getVariable ["MCC_teleportToTeam",false]) && _unit in (units player) && _unit != player) then {
	_array pushBack ["teleport","Teleport","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"];
};

//Create Listbox
_ctrlPos = [(_ctrlPos select 0)+(_ctrlPos select 2),(_ctrlPos select 1)+(ctrlPosition _listBoxCtrl select 1)+(_index*_hight),0.1 * safezoneW,_hight*count _array];
if !(isNull (_disp displayCtrl 4343)) then {
	(_disp displayCtrl 4343) ctrlShow false;
	ctrlDelete (_disp displayCtrl 4343);
};

_ctrl = _disp ctrlCreate ["RscListbox",4343];
(_disp displayCtrl 4343) ctrlSetPosition _ctrlPos;
(_disp displayCtrl 4343) ctrlCommit 0;

lbClear (_disp displayCtrl 4343);
{
	_class			= _x select 0;
	_displayname 	= _x select 1;
	_pic 			= _x select 2;
	_index 			= (_disp displayCtrl 4343) lbAdd _displayname;
	(_disp displayCtrl 4343) lbSetPicture [_index, _pic];
	(_disp displayCtrl 4343) lbSetData [_index, _class];
} foreach _array;
(_disp displayCtrl 4343) lbSetCurSel -1;

player setVariable ["interactWith",_unit];
(_disp displayCtrl 4343) ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_RSunitSelectedClicked"];