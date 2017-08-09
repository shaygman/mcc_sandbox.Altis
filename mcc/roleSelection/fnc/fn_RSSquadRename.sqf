/*==================================================================MCC_fnc_RSSquadRename======================================================================================
// Rename sqaud
	<IN>
		_this select 0:			STRING group NetID

	<OUT>
==============================================================================================================================================================================*/
private ["_group","_groups","_idc","_ctrlGroupIdc","_ctrl","_disp","_hight","_groupsNamesArray","_groupsNames"];
disableSerialization;

_idc = param [0,0,[0]];
_ctrlGroupIdc = param [1,0,[0]];
_disp = ctrlParent (_this select 2);
_hight = 0.03* safezoneH;

if (isNull (_disp displayCtrl _ctrlGroupIdc+700)) then {
	_ctrl = _disp ctrlCreate ["RscEdit",_ctrlGroupIdc+700,_disp displayCtrl _ctrlGroupIdc];
	_ctrl ctrlSetPosition [0*safezoneW, 0.0* safezoneH, 0.04 * safezoneW, _hight];
	_ctrl ctrlSetBackgroundColor [0.692,0.692,0.692,0.9];
	(_disp displayCtrl _ctrlGroupIdc+700) ctrlShow false;
	(_disp displayCtrl _ctrlGroupIdc+700) ctrlCommit 0;
};

if !(ctrlShown (_disp displayCtrl _ctrlGroupIdc+700)) then {
	(_disp displayCtrl _ctrlGroupIdc+700) ctrlShow true;
	(_disp displayCtrl _ctrlGroupIdc+700) ctrlCommit 0;
	ctrlSetFocus (_disp displayCtrl _ctrlGroupIdc+700);
} else {
	_name = ctrlText (_disp displayCtrl _ctrlGroupIdc+700);

	if (_name == "") exitWith {
		[9999,"Squad name can't be empty",3,true] spawn MCC_fnc_setIDCText;
		ctrlDelete (_disp displayCtrl _ctrlGroupIdc+700);
	};

	if (count (toArray _name) < 3) exitWith {
		[9999,"Squad name is too short",3,true] spawn MCC_fnc_setIDCText;
		ctrlDelete (_disp displayCtrl _ctrlGroupIdc+700);
	};

	if (count (toArray _name) > 12) exitWith {
		[9999,"Squad name is too long",3,true] spawn MCC_fnc_setIDCText;
		ctrlDelete (_disp displayCtrl _ctrlGroupIdc+700);
	};

	_groups	 = switch (player getVariable ["CP_side", playerside]) do {
					case east:{missionNamespace getVariable ["CP_eastGroups",[]]};
					case resistance:{missionNamespace getVariable ["CP_guarGroups",[]]};
					default {missionNamespace getVariable ["CP_westGroups",[]]};
				};

	_groupsNames = [];
	{_groupsNames pushBack (toLower (_x select 1))} forEach _groups;

	if (toLower _name in _groupsNames) exitWith {
		[9999,"Squad name is already taken",3,true] spawn MCC_fnc_setIDCText;
		ctrlDelete (_disp displayCtrl _ctrlGroupIdc+700);
	};

	_group = ((_groups) select _idc) select 0;

	if (player == leader _group) then {

		_group setVariable ["name",_name,true];

		switch (player getVariable ["CP_side",playerside]) do {
			case east:{
				CP_eastGroups set [_idc,[_group,_name]];
				publicvariable "CP_eastGroups";
			};

			case resistance:{
				CP_guarGroups set [_idc,[_group,_name]];
				publicvariable "CP_guarGroups";
			};

			case default {
				CP_westGroups set [_idc,[_group,_name]];
				publicvariable "CP_westGroups";
			};
		};
	};

	(_disp displayCtrl _ctrlGroupIdc+700) ctrlShow false;
};
