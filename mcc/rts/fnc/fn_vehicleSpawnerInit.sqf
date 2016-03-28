//=================================================================MCC_fnc_vehicleSpawnerInit==================================================================================
//  [_this,"vehicle"] call MCC_fnc_vehicleSpawnerInit
//  Init an object as a vehicle spawner and add an add action to it
//  Parameter(s):
//     0: OBJECT - objct to which items will be added
//     1: ARRAY of STRINGS - first argument type "tank","vehicle","heli","jet","ship"
//                           secon argument - helipad spawn name - string
//==============================================================================================================================================================================
private ["_object","_arguments","_null","_syncItems","_syncedObjects","_billboard","_helipad","_type"];

_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

//We came here from a moudle
if (_object isKindOf "mcc_sandbox_modulevehicleSpawner" || _object isKindOf "MCC_Module_vehicleSpawnerCurator") exitWith {
    _syncedObjects = synchronizedObjects _object;

    //No synced Objects?
    if (count _syncedObjects <2) then {
        _billboard = "Land_Noticeboard_F" createVehicle (_object modelToWorld [0,5,0]);
        _helipad = "Land_HelipadEmpty_F" createVehicle (_object modelToWorld [0,15,0]);
    } else {
        _billboard = _syncedObjects select 0;
        _helipad = _syncedObjects select 1;
    };

    _type = _object getVariable ["type","vehicle"];
    //Add the objects to curator
    [_billboard,_helipad,_type] spawn {
        private ["_billboard","_helipad","_type"];
        _billboard = _this select 0;
        _helipad = _this select 1;
        _type = _this select 2;

        //[_billboard,[_type,_helipad]] call MCC_fnc_vehicleSpawnerInit;
       [[_billboard,[_type,_helipad]], "MCC_fnc_vehicleSpawnerInit", true, false] spawn BIS_fnc_MP;

        waitUntil {!isNil "MCC_curator"};
        {
            [[[_x], {MCC_curator addCuratorEditableObjects [[_this select 0],false];}], "BIS_fnc_spawn", false, false, false] call BIS_fnc_MP;
        } forEach [_billboard,_helipad];
    };
};

if (count _this <=3) then {
    //We got here from the object
    _arguments = [_this, 1, [], [[]]] call BIS_fnc_param;

    if (local _object) then {_object allowDamage false; _object enableSimulation false};
    _object setObjectTexture (switch (tolower (_arguments select 0)) do {
                                case "vehicle": {[0,"\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa"]};
                                case "tank": {[0,"\A3\armor_f_gamma\MBT_01\Data\UI\Slammer_M2A1_Base_ca.paa"]};
                                case "heli": {[0,"\A3\Air_F_Beta\Heli_Attack_01\Data\UI\Heli_Attack_01_CA.paa"]};
                                case "jet": {[0,"\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Plane_CAS_01_CA.paa"]};
                                case "ship": {[0,"\A3\boat_f\Boat_Armed_01\data\ui\Boat_Armed_01_minigun.paa"]};
                                default {[0,"\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa"]};
                            });
    _object setObjectTexture [1,'#(rgb,8,8,3)color(0.5,0.5,0.5,0.1)'];
    _object setObjectTexture [2,'#(rgb,8,8,3)color(0.5,0.5,0.5,0.1)'];
    _null = _object addAction [format ["<t color=""#ff1111"">Purchase %1</t>",_arguments select 0], {call MCC_fnc_vehicleSpawnerInit}, _arguments,10,true,true];
} else {
    private ["_simTypesUnits","_faction","_CfgVehicles","_CfgVehicle","_vehicleDisplayName","_cfgclass","_cfgFaction","_simulation","_vehicleArray","_comboBox","_mccdialog","_displayname","_index","_array","_rtsAnchor","_caller","_vehicleType","_spawnPad"];

    //We got here from the addaction
    _caller = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
    _arguments = [_this, 3, [], [[]]] call BIS_fnc_param;
    _vehicleType = _arguments select 0;
    _spawnPad = _arguments select 1;

    if (isNull _caller) exitWith {};


    [_caller, _arguments] spawn MCC_fnc_vehicleSpawnerInitDialog;
};