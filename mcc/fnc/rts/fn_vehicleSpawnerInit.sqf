//=================================================================MCC_fnc_vehicleSpawnerInit==================================================================================
//  [] call MCC_fnc_vehicleSpawnerInit
//  Init an object as a vehicle spawner and add an add action to it
//  Parameter(s):
//     0: OBJECT - objct to which items will be added
//     1: ARRAY of STRINGS - first argument type "tank","vehicle","heli","jet","ship"
//                           secon argument - helipad spawn name - string
//==============================================================================================================================================================================
private ["_object","_arguments","_null","_caller","_syncItems","_vehicleType","_spawnPad"];

if (count _this <3) then {
    //We got here from the object
    _object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
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
    //We got here from the addaction
    _object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
    _caller = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
    _arguments = [_this, 3, [], [[]]] call BIS_fnc_param;
    _vehicleType = _arguments select 0;
    _spawnPad = _arguments select 1;

    if (isNull _caller) exitWith {};

    createDialog "MCC_VEHICLESPAWNER";
    waitUntil {dialog};

    private ["_simTypesUnits","_faction","_CfgVehicles","_CfgVehicle","_vehicleDisplayName","_cfgclass","_cfgFaction","_simulation","_vehicleArray","_comboBox","_mccdialog","_displayname","_index","_array"];
    _simTypesUnits = switch (tolower _vehicleType) do {
                                case "vehicle": {["car","carx", "motorcycle"]};
                                case "tank":  {["tank","tankX"]};
                                case "heli":  {["helicopter","helicopterX", "helicopterrtd"]};
                                case "jet":  {["airplane","airplanex"]};
                                case "ship":  {["ship","shipx", "shipX","submarinex"]};
                                default  {["car","carx", "motorcycle"]};
                            };

    _faction = faction _caller;
    if (isNil "_faction") exitWith {};

    //Is there a user designed vehicle costs?
    _vehicleArray = missionNamespace getVariable ([format["%1_%2",tolower _vehicleType,_faction],[]]);

    if (count _vehicleArray == 0) then {
        _CfgVehicles        = configFile >> "CfgVehicles" ;

        for "_i" from 1 to (count _CfgVehicles - 1) do {
            _CfgVehicle = _CfgVehicles select _i;

            //Keep going when it is a public entry
            if ((getNumber(_CfgVehicle >> "scope") == 2)) then {

                _vehicleDisplayName     = getText(_CfgVehicle >> "displayname");
                _cfgclass           = (configName (_CfgVehicle));
                _cfgFaction             = getText(_CfgVehicle >> "faction");
                _simulation             = getText(_CfgVehicle >> "simulation");
                _cost                   = floor (getNumber(_CfgVehicle >> "cost"))/1000;
                _vehicleDisplayName = [_vehicleDisplayName, gettext(_CfgVehicle >> "picture")];

                if (_simulation in _simTypesUnits) then  {
                    if (toUpper(_cfgFaction) == _faction && !(tolower(getText(_CfgVehicle >> "vehicleClass")) in ["static","support","autonomous"])) then {
                        _vehicleArray pushback [_cfgclass,_vehicleDisplayName,_cost];
                    };
                };
            };
        };
    };

    missionNamespace setVariable ["MCC_private_vehicleArray",_vehicleArray];
    missionNamespace setVariable ["MCC_private_spawnPad",_spawnPad];

    disableSerialization;
    _mccdialog = uiNamespace getVariable "MCC_VEHICLESPAWNER_IDD";

    //Fill comboBox
    _comboBox = _mccdialog displayCtrl 101;
    lbClear _comboBox;
    {
        _displayname = (_x select 1) select 0;
        _index = _comboBox lbAdd _displayname;
        _comboBox lbSetPicture [_index,(_x select 1) select 1];
    } foreach _vehicleArray;
    _comboBox lbSetCurSel 0;

    while {(str (_mccdialog displayCtrl 101) != "No control")} do
    {
        //Load available resources
        _array = call compile format ["MCC_res%1",playerside];
        {_mccdialog displayCtrl _x ctrlSetText str floor (_array select _forEachIndex)} foreach [81,82,83,84,85];
        sleep 1;
    };
};