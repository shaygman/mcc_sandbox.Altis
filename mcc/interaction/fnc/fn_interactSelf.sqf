//==================================================================MCC_fnc_interactSelf========================================================================================
// Interaction with self
// Example: [] spawn MCC_fnc_interactSelf;
//=================================================================================================================================================================================
private ["_suspect","_men","_rand","_factor","_null","_suspectCorage","_keyName","_pos","_server"];
_suspect 	= _this select 0;
//if ((MCC_isACE && MCC_isMode)) exitWith {};

disableSerialization;

if (dialog) exitWith {};

_array = [["closeDialog 0",format ["<t size='0.8' align='center' color='#ffffff'>%1</t>",if (name _suspect == "Error: No unit") then {"John Doe"} else {name _suspect}],""]];

//If MCC medic system off
if (missionNamespace getVariable ["MCC_medicSystemEnabled",false]) then {
	_array pushBack  ["[(_this select 0),'medic'] spawn MCC_fnc_interactSelfClicked","Medical Examine",format ["%1data\IconMed.paa",MCC_path]];
};

//Needed at least two in squad to spot and build
if (leader player == player && count units player >= 2) then {
	_array pushBack ["[(_this select 0),'enemy'] spawn MCC_fnc_interactSelfClicked","Spot Enemy","\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"];
	_array pushBack ["[(_this select 0),'support'] execVM 'mcc\interaction\fnc\fn_interactSelfClicked.sqf'","Call Support",format ["%1data\IconAmmo.paa",MCC_path]];
	_array pushBack ["build","Construct",format["%1data\IconRepair.paa",MCC_path]];
	_array pushBack ["closeDialog 0; createDialog 'MCC_SQLPDA'","Squad Leader PDA","\A3\Ui_f\data\IGUI\Cfg\VehicleToggles\wheelbreakiconon_ca.paa"];

	//Rally point
	if ((missionNamespace getVariable ["MCC_allowSQLRallyPoint",false]) &&
		isNull(player getVariable ["MCC_rallyPoint",objNull]) &&
		isNull(player getVariable ["MCC_rallyPoint",objNull]) &&
		((tolower (player getvariable ["CP_role","n/a"])) == "officer" ) &&
		{_x distance player < 15} count units player > 2) then {
		_array pushBack ["rallypoint","Deploy Rally","\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa"];
	};
};

//Commander Console
_server = missionNamespace getVariable ["MCC_server",objNull];
if (((_server getVariable [format ["CP_commander%1",playerside],""]) == getPlayerUID player) && (missionNamespace getVariable ["MCC_allowConsole",true])) then {
	_array pushBack ["commander","Commander Console","\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"];
};

//Attached gear
if (isNull(player getVariable ["MCC_playerAttachedGearItem",objNull])) then {

	//Attach
	if  (({_x in magazines player} count ["Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade","O_IR_Grenade","I_IR_Grenade"]) > 0) then {
		_array pushBack  ["gear","Attach",format ["%1data\IconAmmo.paa",MCC_path]];
	};
} else {
	//detah
	_array pushBack ["detach","Detach Item",format ["%1data\IconAmmo.paa",MCC_path]];
};

if (count _array == 1) exitWith {};

MCC_fnc_interactionsBuildInteractionUI = {
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
	_width = 0.022 * safezoneW;
	_hight = 0.022 * safezoneH;

	_xPos = (_cPos select 0) + _radius * cos(245)*3.85;
	_yPos = (_cPos select 1) + _radius * sin(245)*1.9;
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
				_ctrl ctrlCommit 0.1;
			} else {
				_buttonCtrlGroup = _disp ctrlCreate ["RscControlsGroupNoScrollbars",111 + _foreachindex];
				_buttonCtrlGroup ctrlSetPosition [(_cPos select 0), (_cPos select 1), 0,  0];
				_buttonCtrlGroup ctrlAddEventHandler ["MouseButtonClick",format ["%1",(_x select 0)]];
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
			_buttonCtrlGroup ctrlAddEventHandler ["MouseButtonClick",format ["%1",(_x select 0)]];
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
};

[_array,0] call MCC_fnc_interactionsBuildInteractionUI;
player setVariable ["interactWith",[_suspect]];

/*
_ctrl = ((uiNameSpace getVariable "MCC_INTERACTION_MENU") displayCtrl 0);
_ctrl ctrlSetPosition [0.4,0.4,0.15 * safezoneW, 0.025* count _array* safezoneH];
_ctrl ctrlCommit 0;

_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";

lbClear _ctrl;
{
	_class			= _x select 0;
	_displayname 	= _x select 1;
	_pic 			= _x select 2;
	_index 			= _ctrl lbAdd _displayname;
	_ctrl lbSetPicture [_index, _pic];
	_ctrl lbSetData [_index, _class];
} foreach _array;
_ctrl lbSetCurSel 0;

player setVariable ["interactWith",[_suspect]];
_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_interactSelfClicked"];
waituntil {!dialog};
*/