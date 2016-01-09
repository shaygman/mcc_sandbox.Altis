/*==================================== MCC_fnc_interactionsBuildInteractionUI ==========================
	build interaction rose menu
	<IN>
		_actions (_this select 0):	ARRAY, arry of actions [["acionFnc","actionText","actionPic"],["acionFnc","actionText","actionPic"]] first element is middle button
		_layer (_this select 1):	INTEGER number of hirarcy in menu 0 is the first, 1 is the second, 2 is next exc. When you press back on 2 you return to 1 and so on

	<OUT>
		Nothing
===========================================================================================*/
disableSerialization;
params ["_actions","_layer"];
private ["_disp","_angle","_angleDif","_ctrl","_radius","_xPos","_yPos","_buttonCtrlGroup"];

while {dialog} do {closeDialog 0; sleep 0.01};
playSound "click";
//Create dialog
_ok = createDialog "MCC_INTERACTION_MENU";
waituntil {dialog};

_disp = uiNamespace getVariable ["MCC_INTERACTION_MENU",displayNull];
if (isNull _disp || count _actions <= 0) exitWith {};

//Save actions for back option
missionNamespace setVariable [format ["MCC_interactionLayer_%1", _layer],_actions];

_angleDif = 360/((count _actions -1) max 1);
_angle = 270;
_radius = 0.04 * safezoneW * safezoneH;
_cPos = [0.5* safezoneW + safezoneX,0.5* safezoneH + safezoneY];
_width = 0.03 * safezoneW;
_hight = 0.035 * safezoneH;

_xPos = (_cPos select 0) + _radius * cos(245)*3.65;
_yPos = (_cPos select 1) + _radius * sin(245)*1.8;
_ctrl = _disp ctrlCreate ["RscPicture",-1];
_ctrl ctrlsetText format ["%1mcc\interaction\data\metalButton.paa", MCC_path];
_ctrl ctrlSetPosition [(_cPos select 0), (_cPos select 1), 0,  0];
_ctrl ctrlCommit 0;
_ctrl ctrlSetPosition [_xPos, _yPos, _radius*3.6,  _radius*3.6];
_ctrl ctrlCommit 0.1;

{

	if (_foreachindex == 0) then {
		if ((_x select 2)=="") then {
			_ctrl = _disp ctrlCreate ["RscStructuredText",-1];
			_ctrl ctrlSetStructuredText parseText (_x select 1);
			_ctrl ctrlSetPosition [(_cPos select 0)-_width, _cPos select 1, _width*3,  _hight*3];
			_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["%1",(_x select 0)]];
			_ctrl ctrlSetTooltip "Back";
			_ctrl ctrlCommit 0;
		} else {
			_buttonCtrlGroup = _disp ctrlCreate ["RscControlsGroupNoScrollbars",111 + _foreachindex];
			_buttonCtrlGroup ctrlSetPosition [(_cPos select 0), (_cPos select 1), 0,  0];
			if ((_x select 0)!="") then {
				_buttonCtrlGroup ctrlAddEventHandler ["MouseButtonClick",format ["closeDialog 0; %1",(_x select 0)]];
			};

			_buttonCtrlGroup ctrlCommit 0;

			_ctrl = _disp ctrlCreate ["RscPicture",-1, _buttonCtrlGroup];
			_ctrl ctrlSetPosition [0, 0, _width,  _hight];
			_ctrl ctrlsetText (_x select 2);
			_ctrl ctrlSetTooltip (_x select 1);
			_ctrl ctrlCommit 0;

			_buttonCtrlGroup ctrlSetPosition [(_cPos select 0), _cPos select 1, _width*2,  _hight*2];
			_buttonCtrlGroup ctrlCommit 0.1;
		};
	} else {
		_xPos = (_cPos select 0) + _radius * cos(_angle);
		_yPos = (_cPos select 1) + _radius * sin(_angle);

		_buttonCtrlGroup = _disp ctrlCreate ["RscControlsGroupNoScrollbars",111 + _foreachindex];
		_buttonCtrlGroup ctrlSetPosition [(_cPos select 0), (_cPos select 1), 0,  0];
		if ((_x select 0)!="") then {
			_buttonCtrlGroup ctrlAddEventHandler ["MouseButtonClick",format ["closeDialog 0; %1",(_x select 0)]];
		};
		_buttonCtrlGroup ctrlCommit 0;

		_ctrl = _disp ctrlCreate ["RscPicture",-1, _buttonCtrlGroup];
		_ctrl ctrlSetPosition [0, 0, _width,  _hight];
		_ctrl ctrlsetText (_x select 2);
		_ctrl ctrlSetTooltip (_x select 1);
		if (count _x > 3) then {
			_ctrl ctrlSetTooltipColorBox (_x select 3);
			//_ctrl ctrlSetTooltipColorShade (_x select 3);
			_ctrl ctrlSetTooltipColorText (_x select 3);
		};
		_ctrl ctrlCommit 0;

		//Do a little animation
		_buttonCtrlGroup ctrlSetPosition [_xPos, _yPos, _width,  _hight];
		_buttonCtrlGroup ctrlCommit 0.1;

		_angle = (_angle + _angleDif) mod 360;
	};
} forEach _actions;