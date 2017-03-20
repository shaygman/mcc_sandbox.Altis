/*======================================================================= MCC_fnc_login =========================================================
=================================================================================================================================================*/
#define MCCMISSIONMAKERNAME 1020
private ["_p_mcc_player","_p_mcc_player_name","_p_mcc_request","_isAdmin","_mccChat","_missionMaker","_array"];

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
	_array = ["all","helicopterrtd","air"] call MCC_fnc_makeUnitsArray;
	_array = _array + (["all","helicopter","air"] call MCC_fnc_makeUnitsArray);

	missionNamespace setVariable ["MCC_vehicles_helicopters" ,_array];
	publicVariable "MCC_vehicles_helicopters";

	//planes
	_array = ["all","airplanex","air"] call MCC_fnc_makeUnitsArray;
	_array = _array + (["all","airplane","air"] call MCC_fnc_makeUnitsArray);

	missionNamespace setVariable ["MCC_vehicles_airplanes" ,_array];
	publicVariable "MCC_vehicles_airplanes";

	//cars
	_array = ["all","carx"] call MCC_fnc_makeUnitsArray;
	_array = _array + (["all","car"] call MCC_fnc_makeUnitsArray);

	missionNamespace setVariable ["MCC_vehicles_vehicles" ,_array];
	publicVariable "MCC_vehicles_vehicles";

	//armor
	_array = ["all","tankx"] call MCC_fnc_makeUnitsArray;
	_array = _array + (["all","tank"] call MCC_fnc_makeUnitsArray);

	missionNamespace setVariable ["MCC_vehicles_tanks" ,_array];
	publicVariable "MCC_vehicles_tanks";

	//motorcycle
	_array = ["all","motorcyclex"] call MCC_fnc_makeUnitsArray;
	_array = _array + (["all","motorcycle"] call MCC_fnc_makeUnitsArray);

	missionNamespace setVariable ["MCC_vehicles_motorcycles" ,_array];
	publicVariable "MCC_vehicles_motorcycle";

	//ships
	_array = ["all","shipx"] call MCC_fnc_makeUnitsArray;
	_array = _array + (["all","ship"] call MCC_fnc_makeUnitsArray);

	missionNamespace setVariable ["MCC_vehicles_ships" ,_array];
	publicVariable "MCC_vehicles_ships";
};

