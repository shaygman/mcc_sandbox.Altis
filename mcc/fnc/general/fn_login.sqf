/*======================================================================= MCC_fnc_login =========================================================
=================================================================================================================================================*/
#define MCCMISSIONMAKERNAME 1020
private ["_p_mcc_player","_p_mcc_player_name","_p_mcc_request","_isAdmin","_mccChat","_missionMaker"];

disableSerialization;

_p_mcc_player = _this select 0;
_p_mcc_player_name = _this select 1;
_p_mcc_request = _this select 2;
_isAdmin = _this select 3;
_mccChat = missionNamespace getVariable ["MCC_Chat",true];
_missionMaker = missionNamespace getVariable ["mcc_missionmaker",""];

//MM is logging out
if (_missionMaker == _p_mcc_player_name) exitWith {
	if (_mccChat) then {
		[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> %2 Logged out as Misson Maker.",_p_mcc_request,mcc_missionMaker], false],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
	};
	missionNamespace setVariable ["mcc_missionmaker",""];
	unassignCurator MCC_curator;
	publicVariable "mcc_missionmaker";
	ctrlSetText [MCCMISSIONMAKERNAME, format["%1",""]];
};

//MM is logging in
if ((_missionMaker == "") || _isAdmin) exitWith {
	missionNamespace setVariable ["mcc_missionmaker",_p_mcc_player_name];
	_missionMaker = missionNamespace getVariable ["mcc_missionmaker",""];
	if (_mccChat) then {
		[[[netId _p_mcc_player,_p_mcc_player], format["MCC ID %1-> Access granted to: %2",_p_mcc_request,mcc_missionMaker], false],"MCC_fnc_groupchat",true,false] spawn BIS_fnc_MP;
	};
	unassignCurator MCC_curator;
	sleep 0.1;
	_p_mcc_player assignCurator MCC_curator;

	publicVariable "mcc_missionmaker";
	publicVariable "mcc_zone_pos";
	publicVariable "mcc_zone_size";
	publicVariable "mcc_zone_dir";
	publicVariable "mcc_zone_locations";
	publicVariable "MCC_zones_numbers";

	publicvariable (format ["MCC_evacVehicles_%1",playerside]);

	ctrlSetText [MCCMISSIONMAKERNAME, format["%1",_missionMaker]];

	//load custom units arrays
	//helicopters
	missionNamespace setVariable ["MCC_vehicles_helicopters" ,["all","helicopterrtd","air"] call MCC_fnc_makeUnitsArray];
	publicVariable "MCC_vehicles_helicopters";

	//planes
	missionNamespace setVariable ["MCC_vehicles_airplanes" ,["all","airplanex","air"] call MCC_fnc_makeUnitsArray];
	publicVariable "MCC_vehicles_airplanes";

	//cars
	missionNamespace setVariable ["MCC_vehicles_vehicles" ,["all","carx"] call MCC_fnc_makeUnitsArray];
	publicVariable "MCC_vehicles_vehicles";

	//armor
	missionNamespace setVariable ["MCC_vehicles_tanks" ,["all","tankx"] call MCC_fnc_makeUnitsArray];
	publicVariable "MCC_vehicles_tanks";

	//motorcycle
	missionNamespace setVariable ["MCC_vehicles_motorcycles" ,["all","motorcyclex"] call MCC_fnc_makeUnitsArray];
	publicVariable "MCC_vehicles_motorcycle";

	//ships
	missionNamespace setVariable ["MCC_vehicles_ships" ,["all","shipx"] call MCC_fnc_makeUnitsArray];
	publicVariable "MCC_vehicles_ships";
};

