//==================================================================MCC_fnc_interactSelf========================================================================================
// Interaction with self
// Example: [] spawn MCC_fnc_interactSelf;
//=================================================================================================================================================================================
private ["_suspect","_men","_rand","_factor","_null","_suspectCorage","_keyName","_pos"];
_suspect 	= _this select 0;
if (MCC_isACE) exitWith {};

disableSerialization;

if (!dialog) exitWith
{
	_array = [["",format ["-= %1 =-",if (name _suspect == "Error: No unit") then {"John Doe"} else {name _suspect}],""],
			  ["medic","Medical Examine",format ["%1data\IconMed.paa",MCC_path]],
			  ["enemy","Spot Enemy","\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"],
			  ["support","Call Support",format["%1data\ammo_icon.paa",MCC_path]],
			  ["build","Construct",format["%1data\IconRepair.paa",MCC_path]],
			  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];

	//If MCC medic system off
	if !(missionNamespace getVariable ["MCC_medicSystemEnabled",false]) then
	{
		_array set [1,-1];
	};

	if (leader player != player) then
	{
		_array set [3,-1];
		_array set [4,-1];
	};

	_array = _array - [-1];

	if (count _array == 2) exitWith {};
	_ok = createDialog "MCC_INTERACTION_MENU";
	waituntil {dialog};

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
};
