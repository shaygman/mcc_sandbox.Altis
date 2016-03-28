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
if (!(missionNamespace getVariable ["MCC_interactionKey_holding",false]) && ((_suspect getVariable ["MCC_disarmed",false]) || ((_suspect getVariable ["MCC_neutralize",false])) && !(_suspect in units group player))) then {
	_pos = getpos _suspect;
	_pos set [2, (_pos select 2) + 1.5];
	missionNameSpace setVariable ["MCC_interactionObjects", [[_pos, format ["Hold %1 to interact",_keyName]]]];
} else {
	missionNameSpace setVariable ["MCC_interactionObjects", []];
};

if ((missionNamespace getVariable ["MCC_interactionKey_holding",false]) && (player distance  _suspect < 2) && !dialog) exitWith {
	_suspectName = if (name _suspect == "Error: No unit") then {"John Doe"} else {name _suspect};
	_array = [["closeDialog 0","<t size='1' align='center' color='#ffffff'>"+_suspectName+"</t>",""],
			  ["['zip'] spawn MCC_fnc_interactManClicked","Restrain",format ["%1data\iconHandcuffs.paa",MCC_path]],
			  ["['follow'] spawn MCC_fnc_interactManClicked","Order Around",format ["%1data\iconOrder.paa",MCC_path]],
			  ["['pickKit'] spawn MCC_fnc_interactManClicked","Pick Up Kit",format ["%1data\IconAmmo.paa",MCC_path]],
			  ["['medic'] spawn MCC_fnc_interactManClicked","Examine",format ["%1data\IconMed.paa",MCC_path]],
			  ["['drag'] spawn MCC_fnc_interactManClicked","Drag",format ["%1data\IconDrag.paa",MCC_path]]];

	//Load wounded
	private ["_nearVehicles","_vehicle","_vehicleName"];
	_nearVehicles = [];
	if (_suspect getVariable ["MCC_medicUnconscious",false] && alive _suspect) then {
		_nearVehicles = (_suspect nearObjects ["Helicopter",5]) + (_suspect nearObjects ["LandVehicle",5]);

		for [{_x=0},{_x<count _nearVehicles},{_x=_x+1}] do {
			_vehicle = _nearVehicles select _x;
			if ((_vehicle emptyPositions "cargo")==0 || ((vectorUp _vehicle) select 2) <=0 || locked _vehicle >1) then {_nearVehicles set [_x,-1]};
		};

		_nearVehicles = _nearVehicles - [-1];
	};

	{
		_vehicleName = getText (configfile >> "CfgVehicles" >> typeof _x >> "displayName");
		_array pushBack [format ["['load_%1'] spawn MCC_fnc_interactManClicked",_foreachIndex],format ["Load into %1",_vehicleName],"\A3\ui_f\data\igui\cfg\actions\getincargo_ca.paa"];
	} forEach _nearVehicles;

	//Manage array
	if !((_suspect getVariable ["MCC_disarmed",false]) && !(_suspect in units group player) && alive _suspect) then {_array set [1,-1]};
	if !((_suspect getVariable ["MCC_neutralize",false]) && !(_suspect in units group player) && ((({_x getVariable ["MCC_neutralize",false]} count units group player)<2)) && alive _suspect) then {_array set [2,-1]};
	if (alive _suspect) then {_array set [3,-1]};
	if (MCC_isACE) then {_array set [4,-1]};
	if (!(_suspect getVariable ["MCC_medicUnconscious",false]) || !(alive _suspect)) then {_array set [5,-1]};

	_array = _array - [-1];

	//Open dialog
	if (count _array == 1) exitWith {player setVariable ["MCC_interactionActive",false]};
	[_array,0] call MCC_fnc_interactionsBuildInteractionUI;
	waituntil {dialog};

	_suspect spawn {
		while {dialog} do {
			if (_this distance player > 7) exitWith {};
			sleep 0.1;
		};
		closedialog 0;
	};

	player setVariable ["interactWith",[_suspect]];
	waituntil {!dialog};
	player setVariable ["MCC_interactionActive",false];
};

//Cant neturalize friendly units
if !([_suspect] call MCC_fnc_canHaltAI) exitWith {player setVariable ["MCC_interactionActive",false]};

//Try to halt AI
[_suspect] call MCC_fnc_doHaltAI;

player setVariable ["MCC_interactionActive",false];