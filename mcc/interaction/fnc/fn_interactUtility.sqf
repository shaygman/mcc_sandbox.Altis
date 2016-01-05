//==================================================================MCC_fnc_interactUtility==================================================================================
// Interaction with utility object
// Example: [_object] spawn MCC_fnc_interactUtility;
//============================================================================================================================================================================
private ["_object","_array","_ok","_ctrl","_class","_displayname","_pic","_index","_item"];
disableSerialization;
_object 	= _this select 0;
if (vehicle player != player) exitWith {};

if (MCC_interactionKey_holding && !(_object getVariable ["MCC_isInteracted",false]) && (player distance  _object < 5) && !dialog) exitWith
{
	MCC_fnc_ManMenuClicked =
	{
		private ["_ctrl","_index","_ctrlData","_object"];
		disableSerialization;

		_ctrl 		= _this select 0;
		_index 		= _this select 1;
		_ctrlData	= _ctrl lbdata _index;

		_object = (player getVariable ["interactWith",[]]) select 0;
		closeDialog 0;

		switch (_ctrlData) do
		{
			case "resupply": {
				[_object] call MCC_fnc_resupply;
			};

			case "breakdown": {
				[_object] call MCC_fnc_breakdown;
			};
		};
	};

	_array = [["resupply","Resupply",format ["%1data\IconAmmo.paa",MCC_path]],
			  ["breakdown","Break Down",format ["%1data\IconAmmo.paa",MCC_path]],
			  ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]];


	//Manage array
	if (typeof _object in ["MCC_crateSupply","MCC_crateFuel"]) then {_array set [0,-1]};		//Can't resupply from fuel or ammo
	if !(typeof _object in ["MCC_crateAmmo","MCC_crateSupply","MCC_crateFuel"]) then {_array set [1,-1]};

	_array = _array - [-1];

	_object setVariable ["MCC_isInteracted",true,true];
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

	player setVariable ["interactWith",[_object]];
	_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_ManMenuClicked"];
	waituntil {!dialog};
	player setVariable ["MCC_interactionActive",false];
	_object setVariable ["MCC_isInteracted",false,true];
};

player setVariable ["MCC_interactionActive",false];