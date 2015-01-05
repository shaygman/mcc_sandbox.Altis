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
}
else
{
	missionNameSpace setVariable ["MCC_interactionObjects", []];
};

if (MCC_interactionKey_holding && (player distance  _suspect < 2) && !dialog) exitWith
{
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
if (((side _suspect != civilian && (side _suspect getFriend  side player)>0.6)) || isPlayer _suspect || (_suspect getVariable ["MCC_neutralize",false]) || (_suspect getVariable ["MCC_disarmed",false]) || !(alive _suspect) || (captive _suspect)) exitWith {player setVariable ["MCC_interactionActive",false]};

//shout
[[[netid _men,_men], format ["dontmove%1",floor (random 20)]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
sleep 1;

_factor = if (side _suspect == civilian) then {6} else {11};
if (primaryWeapon player == "") then {_factor = _factor*2};
_rand= random 20;

[[2,getpos _suspect,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _suspect)]],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;

//Stop and look at the player
[[[_suspect, _men],
  {
	_suspect = _this select 0;
	_men = _this select 1;

	(group _suspect) setFormDir ([_suspect,_men] call BIS_fnc_dirTo);
	doStop _suspect;
	_suspect disableAI "MOVE";
  }],"BIS_fnc_spawn", _suspect, false] spawn BIS_fnc_MP;

//Get courage
_suspectCorage = _suspect getVariable "MCC_courage";
if (isnil "_suspectCorage") then
{
	_suspectCorage = (rankId _suspect + (random 10 + _factor) + count units group _suspect);
	_suspect setVariable ["MCC_courage",_suspectCorage,true];
};
_suspectCorage = _suspectCorage * (1-(getdammage _suspect));

//If comply
if (random 25 > _suspectCorage || (_suspect getVariable ["MCC_Stunned", false])) then
{
	[[[netid _suspect,_suspect], format ["enough%1",floor random 14]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	[[_suspect,"amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon"], "MCC_fnc_disarmUnit", _suspect, false] spawn BIS_fnc_MP;

	//if is armed civilian
	if ((_suspect getVariable ["MCC_IEDtype",""]) == "ac") then
	{
		_suspect setvariable ["armed",false,true];
		sleep 1;
		{
		  deleteVehicle _x;
		} forEach attachedObjects _suspect;
	};

	//If left unintended for long will break free
	_suspect spawn
	{
		private ["_escapeChance","_suspect"];
		_suspect		= _this;
		_escapeChance 	= 0.01;

		while {alive _suspect && !(_suspect getVariable ["MCC_neutralize",false])} do
		{
			if (random 1 < _escapeChance) exitWith {_suspect setVariable ["MCC_disarmed",false,true]};
			_escapeChance = _escapeChance + 0.01;
		};

		_suspect setVariable ["MCC_disarmed",false];
		[_suspect] spawn MCC_fnc_deleteHelper;
	};
}
else
{
	[[[netid _suspect,_suspect], format ["alone%1",floor random 10]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	if ((stance _suspect == "STAND") && (side _suspect == civilian)) then
	{
		[[_suspect,"Acts_Kore_Introducing",true,4], "MCC_fnc_setUnitAnim", true, false] spawn BIS_fnc_MP;
	};
};

[[[_suspect],{(_this select 0) enableAI "MOVE";}],"BIS_fnc_spawn", _suspect, false] spawn BIS_fnc_MP;
player setVariable ["MCC_interactionActive",false];