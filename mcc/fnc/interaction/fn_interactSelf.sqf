//==================================================================MCC_fnc_interactSelf========================================================================================
// Interaction with self
// Example: [] spawn MCC_fnc_interactSelf;
//=================================================================================================================================================================================
private ["_suspect","_men","_rand","_factor","_null","_suspectCorage","_keyName","_pos","_server"];
_suspect 	= _this select 0;
//if ((MCC_isACE && MCC_isMode)) exitWith {};

disableSerialization;

if (!dialog) exitWith {
	_array = [["",format ["-= %1 =-",if (name _suspect == "Error: No unit") then {"John Doe"} else {name _suspect}],""]];

	//If MCC medic system off
	if (missionNamespace getVariable ["MCC_medicSystemEnabled",false]) then {
		_array pushBack  ["medic","Medical Examine",format ["%1data\IconMed.paa",MCC_path]];
	};

	//Needed at least two in squad to spot and build
	if (leader player == player && count units player >= 2) then {
		_array pushBack ["enemy","Spot Enemy","\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"];
		_array pushBack ["support","Call Support",format["%1data\ammo_icon.paa",MCC_path]];
		_array pushBack ["build","Construct",format["%1data\IconRepair.paa",MCC_path]];
		_array pushBack ["sqlpda","Squad Leader PDA","\A3\Ui_f\data\IGUI\Cfg\VehicleToggles\wheelbreakiconon_ca.paa"];

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

	//Close dialog
	_array pushBack ["close","Exit Menu","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"];
	if (count _array == 2) exitWith {};

	//Create dialog
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
