//==================================================================MCC_fnc_interactMan===============================================================================================
// Interaction with man type
// Example: [_suspect,_men] spawn MCC_fnc_interactMan;
//=================================================================================================================================================================================
private ["_suspect","_men","_rand","_factor","_null","_suspectCorage","_keyName","_pos","_suspectName"];
_suspect 	= _this select 0;
_men 		= _this select 1;
_keyName	= _this select 2;

disableSerialization;
player setVariable ["MCC_interactionActive",true];

//Release dragged objects
if !(isNull (player getVariable ["mcc_draggedObject", objNull])) then {[] call MCC_fnc_releaseObject};

//draw interaction text
if (!MCC_interactionKey_holding && ((_suspect getVariable ["MCC_disarmed",false]) || ((_suspect getVariable ["MCC_neutralize",false])) && !(_suspect in units group player))) then
{
	_pos = getpos _suspect;
	_pos set [2, (_pos select 2) + 1.5];
	missionNameSpace setVariable ["MCC_interactionObjects", [[_pos, format ["Hold %1 to interact",_keyName]]]];
} else {
	missionNameSpace setVariable ["MCC_interactionObjects", []];
};

if (MCC_interactionKey_holding && (player distance  _suspect < 2) && !dialog) exitWith {
	_suspectName = if (name _suspect == "Error: No unit") then {"John Doe"} else {name _suspect};
	_array = [["",format ["-= %1 =-",_suspectName],""],
			  ["zip","Restrain",format ["%1data\iconHandcuffs.paa",MCC_path]],
			  ["follow","Order Around",format ["%1data\iconOrder.paa",MCC_path]],
			  ["pickKit","Pick Up Kit",format ["%1data\IconAmmo.paa",MCC_path]],
			  ["medic","Examine",format ["%1data\IconMed.paa",MCC_path]],
			  ["drag","Drag",format ["%1data\IconDrag.paa",MCC_path]]];

	//Load wounded
	private ["_nearVehicles","_vehicle","_vehicleName"];
	_nearVehicles = [];
	if (_suspect getVariable ["MCC_medicUnconscious",false] && alive _suspect) then
	{
		_nearVehicles = (_suspect nearObjects ["Helicopter",5]) + (_suspect nearObjects ["LandVehicle",5]);

		for [{_x=0},{_x<count _nearVehicles},{_x=_x+1}] do
		{
			_vehicle = _nearVehicles select _x;
			if ((_vehicle emptyPositions "cargo")==0 || ((vectorUp _vehicle) select 2) <=0 || locked _vehicle >1) then {_nearVehicles set [_x,-1]};
		};

		_nearVehicles = _nearVehicles - [-1];
	};

	{
		_vehicleName = getText (configfile >> "CfgVehicles" >> typeof _x >> "displayName");
		_array set [count _array, [format ["load_%1",_foreachIndex],format ["Load into %1",_vehicleName],"\A3\ui_f\data\igui\cfg\actions\getincargo_ca.paa"]];
	} forEach _nearVehicles;

	//Manage array
	if !((_suspect getVariable ["MCC_disarmed",false]) && !(_suspect in units group player) && alive _suspect) then {_array set [1,-1]};
	if !((_suspect getVariable ["MCC_neutralize",false]) && !(_suspect in units group player) && ((({_x getVariable ["MCC_neutralize",false]} count units group player)<2)) && alive _suspect) then {_array set [2,-1]};
	if (alive _suspect) then {_array set [3,-1]};
	if (MCC_isACE) then {_array set [4,-1]};
	if (!(_suspect getVariable ["MCC_medicUnconscious",false]) || !(alive _suspect)) then {_array set [5,-1]};

	_array = _array - [-1];

	 _array pushBack ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"];
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
	_ctrl ctrlAddEventHandler ["LBSelChanged","_this spawn MCC_fnc_interactManClicked"];
	waituntil {!dialog};
	player setVariable ["MCC_interactionActive",false];
};

//Cant neturalize friendly units
if !([_suspect] call MCC_fnc_canHaltAI) exitWith {player setVariable ["MCC_interactionActive",false]};

//Try to halt AI
[_suspect] call MCC_fnc_doHaltAI;

player setVariable ["MCC_interactionActive",false];