//==================================================================MCC_fnc_interactSelf========================================================================================
// Interaction with self
// Example: [] spawn MCC_fnc_interactSelf;
//=================================================================================================================================================================================
private ["_suspect","_men","_rand","_factor","_null","_suspectCorage","_keyName","_pos","_server"];
_suspect 	= _this select 0;
//if ((MCC_isACE && MCC_isMode)) exitWith {};

disableSerialization;
if (missionNamespace getVariable ["MCC_interactionKey_down",false]) exitWith {MCC_interactionKey_holding = false};
MCC_interactionKey_down = true;
if (dialog || vehicle player != player || missionNamespace getvariable ["MCC_interactionKey_holding",false]) exitWith {};

_array = [["closeDialog 0",format ["<t size='0.8' align='center' color='#ffffff'>%1</t>",if (name _suspect == "Error: No unit") then {"John Doe"} else {name _suspect}],""]];

//If MCC medic system off
if (missionNamespace getVariable ["MCC_medicSystemEnabled",false]) then {
	_array pushBack  ["[(_this select 0),'medic'] spawn MCC_fnc_interactSelfClicked","Medical Examine",format ["%1data\IconMed.paa",MCC_path]];
};

//Needed at least two in squad to spot and build
if (leader player == player && count units player >= 2) then {
	_array pushBack ["[(_this select 0),'enemy'] spawn MCC_fnc_interactSelfClicked","Spot Enemy","\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"];
	_array pushBack ["[(_this select 0),'support'] spawn MCC_fnc_interactSelfClicked","Call Support",format ["%1data\IconAmmo.paa",MCC_path]];

	if (missionNamespace getvariable ["MCC_allowlogistics",true]) then {
		_array pushBack ["[(_this select 0),'build'] spawn MCC_fnc_interactSelfClicked","Construct",format["%1data\IconRepair.paa",MCC_path]];
	};

	_array pushBack ["createDialog 'MCC_SQLPDA'","Squad Leader PDA","\A3\Ui_f\data\IGUI\Cfg\VehicleToggles\wheelbreakiconon_ca.paa"];

	//Rally point
	if ((missionNamespace getVariable ["MCC_allowSQLRallyPoint",false]) &&
		isNull(player getVariable ["MCC_rallyPoint",objNull]) &&
		isNull(player getVariable ["MCC_rallyPoint",objNull]) &&
		((tolower (player getvariable ["CP_role","n/a"])) == "officer" ) &&
		{_x distance player < 15} count units player > 2) then {
		_array pushBack [format ["[player,player,nil] execVM '%1mcc\general_scripts\respawnTents\DeployRespawnTents.sqf';",MCC_path],"Deploy Rally Point","\a3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa"];
	};
};

//Commander Console
_server = missionNamespace getVariable ["MCC_server",objNull];
if (((_server getVariable [format ["CP_commander%1",playerside],""]) == getPlayerUID player) && (missionNamespace getVariable ["MCC_allowConsole",true])) then {
	_array pushBack [format["_null = [nil,nil,nil,nil,1] execVM '%1mcc\dialogs\mcc_PopupMenu.sqf'",MCC_path],"Commander Console",format ["%1mcc\interaction\data\call_ca.paa", MCC_path]];
};

//Attached gear
_array pushBack  ["[(_this select 0),'gear'] spawn MCC_fnc_interactSelfClicked","Attach",format ["%1mcc\roleSelection\data\ui\uniform_ca.paa", MCC_path]];

if (count _array == 1) exitWith {};

[_array,0] call MCC_fnc_interactionsBuildInteractionUI;
player setVariable ["interactWith",[_suspect]];