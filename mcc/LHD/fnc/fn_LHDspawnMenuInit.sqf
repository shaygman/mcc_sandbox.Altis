/*===================================================================MCC_fnc_LHDspawnMenuInit======================================================================
	Open the LHD spawn menu
 		<IN>
		0:	INTEGER - LHD level

		<OUT>
		None
==================================================================================================================================================================*/
//[0] execvm "mcc\lhd\fnc\fn_LHDspawnMenuInit.sqf";
params [
	["_deck", 0, [0,objNull,[]]],
	["_lhdType", "", ["",objNull,[]]]
];

//We came here from curator
if (typeName _deck == typeName objNull) exitWith {
	if ((local _deck) && !(isnull curatorcamera)) then {
		deleteVehicle _deck;
		while {dialog} do {closeDialog 0};

		[0] spawn MCC_fnc_LHDspawnMenuInit;
	};
};

private ["_lhd","_camera","_display","_spawnPos","_pos","_dummy","_objects","_displayname","_index","_decks","_isCUPLHD","_availableLHD"];

_availableLHD = [];
{
	if !(isNull(missionNamespace getVariable [_x,objNull])) then {
		_availableLHD pushBack _x;
	};
} forEach ["MCC_lhd","MCC_carrier"];

if (count _availableLHD == 0) exitWith {
	private ["_str","_null"];
	_str = "<t size='0.8' t font = 'puristaLight' color='#FFFFFF'>" + "Spawn CUP LHD or Carrier first" + "</t>";
	_null = [_str,0,1.1,2,0.1,0.0] spawn bis_fnc_dynamictext;
};

if (_lhdType isEqualTo "") then {
	_lhdType = (_availableLHD select 0);
};

_lhd = (missionNamespace getVariable [_lhdType,objNull]);

if (isNull _lhd) exitWith {};

_isCUPLHD = _lhd isKindOf "CUP_LHD_BASE";


MCC_fnc_LHDspawnMenuClicked = {
	disableSerialization;
	params [
		["_update","updateClass",[""]],
		["_deck", 0, [0]],
		["_selection", "", [""]],
		["_lhdType", "", [""]]
	];

	private ["_ctrl","_display","_ctrlPos","_vehiclesArray","_index"];
	_display = uiNamespace getVariable ["MCC_LHD_MENU", displayNull];
	_ctrl = _display displayCtrl 2300;

	_ctrlPos = ctrlPosition _ctrl;

	//If close open it
	if ((_ctrlPos select 2)<=0) then {
		_ctrlPos set [0,0.7 * safezoneW + safezoneX];
		_ctrlPos set [1,0.1 * safezoneH + safezoneY];
		_ctrlPos set [2,0.273281 * safezoneW];
		_ctrlPos set [3,0.154 * safezoneH];
		_ctrl ctrlSetPosition _ctrlPos;
		_ctrl ctrlCommit 0.1;
		sleep 0.1;


		//Faction
		_ctrl = _display displayCtrl 8008;
		lbClear _ctrl;
		{
			_displayname = format ["%1(%2)",_x select 0,_x select 1];
			_ctrl lbAdd _displayname;
		} foreach U_FACTIONS;
		_ctrl lbSetCurSel (missionNamespace getVariable ["MCC_faction_index",0]);

		//Type
		_ctrl = _display displayCtrl 1501;
		lbClear _ctrl;
		{
			_ctrl lbAdd _x;
		} foreach ["Vehicles", "Tracked/Static", "Motorcycle", "Helicopter", "Fixed-wing", "Ship","Ammo"];
		_ctrl lbSetCurSel 0;

		//Change faction or vehicle type
		{
			_ctrl = _display displayCtrl _x;
			_ctrl ctrlAddEventHandler ["LBSelChanged",format ["['updateClass',%1,'%2','%3'] spawn MCC_fnc_LHDspawnMenuClicked;",_deck,_selection,_lhdType]];
			_ctrl ctrlCommit 0;
		} forEach [8008,1501];

		//Change class
		_ctrl = _display displayCtrl 1502;
		_ctrl ctrlAddEventHandler ["LBSelChanged",{
														_display = ctrlParent (_this select 0);
														_vehicleClass = (switch (lbCurSel (_display displayCtrl 1501)) do
																		{
																			case 1:	{U_GEN_TANK};
																			case 2:	{U_GEN_MOTORCYCLE};
																			case 3:	{U_GEN_HELICOPTER};
																			case 4:	{U_GEN_AIRPLANE};
																			case 5:	{U_GEN_SHIP};
																			case 6:	{U_AMMO};
																			default	{U_GEN_CAR};
																		}) select (lbCurSel (_display displayCtrl 1502)) select 1;
														_ctrl = _display displayCtrl 1100;
														_ctrl ctrlSetText (getText (configfile >> "CfgVehicles" >> _vehicleClass >> "editorPreview"));
													}];
		_ctrl ctrlCommit 0;

		//class
		_index = lbCurSel (_display displayCtrl 1501);
		_vehiclesArray = switch (_index) do
							{
								case 1:	{U_GEN_TANK};
								case 2:	{U_GEN_MOTORCYCLE};
								case 3:	{U_GEN_HELICOPTER};
								case 4:	{U_GEN_AIRPLANE};
								case 5:	{U_GEN_SHIP};
								case 6:	{U_AMMO};
								default	{U_GEN_CAR};
							};
		_ctrl = _display displayCtrl 1502;
		lbClear _ctrl;
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_index = _ctrl lbAdd _displayname;
			_ctrl lbsetData [_index, (_x select 1)];
			if (_index != 6) then {_ctrl lbsetpicture [_index, (_x select 3) select 1]};
		} foreach _vehiclesArray;
		if (count _vehiclesArray > 0) then {_ctrl lbSetCurSel 0};
	};

	switch (_update) do
	{
		case "updateClass":
		{
			//class
			_index = lbCurSel (_display displayCtrl 1501);
			_vehiclesArray = switch (_index) do
								{
									case 1:	{U_GEN_TANK};
									case 2:	{U_GEN_MOTORCYCLE};
									case 3:	{U_GEN_HELICOPTER};
									case 4:	{U_GEN_AIRPLANE};
									case 5:	{U_GEN_SHIP};
									case 6:	{U_AMMO};
									default	{U_GEN_CAR};
								};
			_ctrl = _display displayCtrl 1502;
			lbClear _ctrl;
			{
				_displayname = format ["%1",(_x select 3) select 0];
				_index = _ctrl lbAdd _displayname;
				_ctrl lbsetData [_index, (_x select 1)];
				if (_index != 6) then {_ctrl lbsetpicture [_index, (_x select 3) select 1]};
			} foreach _vehiclesArray;
			if (count _vehiclesArray > 0) then {_ctrl lbSetCurSel 0};
		};

		case "updateSpawn":
		{
			/* STATEMENT */
		};
	};
	//spawn Button
	_ctrl = _display displayCtrl 2400;
	_ctrl ctrlRemoveAllEventHandlers "MouseButtonUp";
	_ctrl ctrlAddEventHandler ["MouseButtonUp",format ["['spawn',%1,'%2','%3'] spawn MCC_fnc_LHDspawnVehicle;",_deck,_selection,_lhdType]];
};

//Close all dialogs
while {dialog} do {
	closeDialog 0;
	sleep 0.1;
};

//CLose Curator
if ( !isNull(findDisplay 312) ) then {
	(findDisplay 312) closeDisplay 1;
	sleep 1;
};

if (isnil "MCC_LHD_CAM") then {
	_camera = "camera" camcreate [0,0,0];
	_camera cameraeffect ["internal","back"];
	_camera camPrepareFOV 0.900;
	_camera campreparefocus [-1,-1];
	_camera camSetTarget _lhd;
	cameraEffectEnableHUD false;
	showCinemaBorder false;
	_camera camCommitPrepared 0;


	MCC_LHD_CAM = _camera;
};
createDialog "MCC_LHDSpawn";
_camera = missionNamespace getVariable ["MCC_LHD_CAM",objNull];

switch (_deck) do
{
	case 0:
	{
		_camera camSetRelPos [100,0,100];

		if (_isCUPLHD) then {
			_spawnPos = ["fd_cargo_pos_2","fd_cargo_pos_3","fd_cargo_pos_4","fd_cargo_pos_5","fd_cargo_pos_6","fd_cargo_pos_7","fd_cargo_pos_8","fd_cargo_pos_9","fd_cargo_pos_10","fd_cargo_pos_11","fd_cargo_pos_12","fd_cargo_pos_13","fd_cargo_pos_14","fd_cargo_pos_15","fd_cargo_pos_16","fd_cargo_pos_17","fd_cargo_pos_18","fd_cargo_pos_19"];
		} else {
			_spawnPos = [[20,50,28],[37,70,28],[-22,-55,28],[5,-55,28],[-30,70,28],[-30,50,28],[-30,30,28],[-30,10,28],[-30,-10,28]];
		};
	};

	case 1:
	{
		_camera camSetRelPos [-4,50,-8];
		_spawnPos = ["veh_cargo_pos_8","veh_cargo_pos_9","veh_cargo_pos_13","veh_cargo_pos_14","veh_cargo_pos_18","veh_cargo_pos_19","veh_cargo_pos_10","veh_cargo_pos_11","veh_cargo_pos_12","veh_cargo_pos_15"];
	};

	case 2:
	{
		_camera camSetRelPos [-5,98,-8];
		_spawnPos = ["veh_cargo_pos_1","veh_cargo_pos_2","veh_cargo_pos_3","veh_cargo_pos_4","veh_cargo_pos_5"];
	};

	case 3:
	{
		_camera camSetRelPos [-4,50,-16];
		_spawnPos = ["veh_cargo_pos_29","veh_cargo_pos_30","veh_cargo_pos_31","veh_cargo_pos_32","veh_cargo_pos_33","veh_cargo_pos_34","veh_cargo_pos_35","veh_cargo_pos_36","veh_cargo_pos_37","veh_cargo_pos_38","veh_cargo_pos_39","veh_cargo_pos_40"];
	};

	case 4:
	{
		_camera camSetRelPos [0,110,-16];
		_spawnPos = ["veh_cargo_pos_41","veh_cargo_pos_42","veh_cargo_pos_43","veh_cargo_pos_44","veh_cargo_pos_45","veh_cargo_pos_46"];
	};
};

_camera camCommitPrepared 0;
camUseNVG (sunOrMoon < 0.5);
disableSerialization;

_display = uiNamespace getVariable ["MCC_LHD_MENU", displayNull];

_decks = if (_isCUPLHD) then {["Flight Deck","Upper Deck Front","Upper Deck Back","Lower Deck","Well Deck"]} else {["Flight Deck"]};

//Add decks control
{
	_ctrl = _display ctrlCreate ["RscButtonMenu", -1];
	_ctrl ctrlSetPosition [0.05*safezoneW+safezoneX, 0.05*safezoneH+safezoneY + (_foreachindex*0.06*safezoneH),0.1*safezoneW,0.05*safezoneH];
	_ctrl ctrlsetText _x;


	_ctrl ctrlAddEventHandler ["MouseButtonUp",format [
	    "
	   closeDialog 0;
	   [%1,'%2'] spawn MCC_fnc_LHDspawnMenuInit;
	",_foreachindex,_lhdType]];

	_ctrl ctrlCommit 0;
} forEach _decks;

//If more then one carrier
{
	_ctrl = _display ctrlCreate ["RscButtonMenu", -1];
	_ctrl ctrlSetPosition [0.21*safezoneW+safezoneX + (_foreachindex*0.11*safezoneW), 0.05*safezoneH+safezoneY ,0.1*safezoneW,0.05*safezoneH];
	_ctrl ctrlsetText (if (_x == "MCC_lhd") then {"LHD"} else {"Carrier"});


	_ctrl ctrlAddEventHandler ["MouseButtonUp",format [
	    "
	   closeDialog 0;
	   [%1,'%2'] spawn MCC_fnc_LHDspawnMenuInit;
	",0,_x]];

	_ctrl ctrlCommit 0;
} forEach _availableLHD;

//Add exit ctrl
_ctrl = _display ctrlCreate ["RscButtonMenu", -1];
_ctrl ctrlSetPosition [0.85*safezoneW+safezoneX, 0.85*safezoneH+safezoneY,0.1*safezoneW,0.05*safezoneH];
_ctrl ctrlsetText "Exit";
_ctrl ctrlAddEventHandler ["MouseButtonUp","closeDialog 0"];
_ctrl ctrlCommit 0;

sleep 0.1;
//Build SpawnPos
_objects = [];
{
	_dummy = "HeliH" createVehicle [0,0,0];
	waitUntil {alive _dummy};
	if (_isCUPLHD) then {
		_dummy attachTo [_lhd,[0,0,0],_x];
	} else {
		_dummy attachTo [_lhd,_x];
	};
	_pos = worldToScreen (getPosASL _dummy);
	_pos set [2,0.02*safezoneW];
	_pos set [3,0.03*safezoneH];

	if ((typeName (_pos select 0) isEqualTo typeName 0)) then {
		_ctrl = _display ctrlCreate ["RscButtonMenu", -1];
		_ctrl ctrlSetPosition _pos;
		_ctrl ctrlsetText (str _foreachindex);
		_ctrl ctrlSetBackgroundColor [0, 0, 0, 0.5];
		_ctrl ctrlAddEventHandler ["MouseButtonUp",format ["['updateSpawn',%1,'%2','%3'] spawn MCC_fnc_LHDspawnMenuClicked",_deck,_x,_lhdType]];
		_ctrl ctrlCommit 0;
		_objects pushBack _dummy;
	};
	sleep 0.001;
} forEach _spawnPos;

{deleteVehicle _dummy} forEach _objects;

waitUntil {!dialog};

if !(isnil "MCC_LHD_CAM") then {MCC_LHD_CAM cameraeffect ["terminate","back"];camdestroy MCC_LHD_CAM;};
MCC_LHD_CAM = nil;