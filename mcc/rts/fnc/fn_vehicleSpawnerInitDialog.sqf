//=================================================================MCC_fnc_vehicleSpawnerInitDialog====================================================================
//  Open vehicle spawner Dialog
//=======================================================================================================================================================================
 private ["_simTypesUnits","_side","_CfgVehicles","_CfgVehicle","_vehicleDisplayName","_cfgclass","_cfgSide","_simulation","_vehicleArray","_comboBox","_mccdialog","_displayname","_index","_array","_rtsAnchor","_caller","_vehicleType","_spawnPad","_arguments","_commadner"];

//We got here from the addaction
_caller = param [0, objNull, [objNull]];
_arguments = param [1, [], [[]]];
_commadner = param [2, false, [false]];
_vehicleType = _arguments select 0;
_spawnPad = _arguments select 1;

missionNamespace setVariable ["MCC_vehicleSpawner_IsCommadner",_commadner];

//If it is an RTS spawner and we don't have elec on
_rtsAnchor = if (MCC_isMode) then {
         getText (configFile >> "cfgRtsBuildings" >> "MCC_rts_workshop1" >> "anchorType");
    } else {
         getText (missionconfigFile >> "cfgRtsBuildings" >> "MCC_rts_workshop1" >> "anchorType");
    };

if ((attachedTo _spawnPad) isKindOf _rtsAnchor && !((missionNamespace getVariable [format ["MCC_rtsElecOn_%1", playerSide],false]) || (missionNamespace getVariable [format ["MCC_rtsAllowPlayersPurchase_%1", playerSide],false]))) exitWith {
   titleText ["Workshop Offline","PLAIN"];
};

createDialog "MCC_VEHICLESPAWNER";
waitUntil {!isnull (uiNamespace getVariable ["MCC_VEHICLESPAWNER_IDD", displayNull])};

if (_commadner) then {
    ctrlshow [1003,false];
    ctrlshow [1103,false];
    ctrlshow [84,false];
    ctrlshow [94,false];
} else {
    for "_i" from 0 to 2 step 1 do {
        ctrlshow [_i+1000,false];
        ctrlshow [_i+1100,false];
        ctrlshow [_i+81,false];
        ctrlshow [_i+91,false];
    };
};

_simTypesUnits = switch (tolower _vehicleType) do {
                            case "vehicle": {["car","carx", "motorcycle"]};
                            case "tank":  {["tank","tankX"]};
                            case "heli":  {["helicopter","helicopterX", "helicopterrtd"]};
                            case "jet":  {["airplane","airplanex"]};
                            case "ship":  {["ship","shipx", "shipX","submarinex"]};
                            default  {["car","carx", "motorcycle"]};
                        };

_side = side _caller;
if (isNil "_side") exitWith {};

//Is there a user designed vehicle costs?
_vehicleArray = missionNamespace getVariable ([format["MCC_RTS_%1_%2",tolower _vehicleType,side _caller],[]]);

if (count _vehicleArray == 0) then {
    _CfgVehicles        = configFile >> "CfgVehicles" ;

    for "_i" from 1 to (count _CfgVehicles - 1) do {
        _CfgVehicle = _CfgVehicles select _i;

        //Keep going when it is a public entry
        if ((getNumber(_CfgVehicle >> "scope") == 2)) then {

            _vehicleDisplayName = getText(_CfgVehicle >> "displayname");
            _cfgclass           = (configName (_CfgVehicle));
            _cfgSide            = (getNumber(_CfgVehicle >> "side")) call BIS_fnc_sideType;
            _simulation         = getText(_CfgVehicle >> "simulation");
            _cost               = floor (getNumber(_CfgVehicle >> "cost")/700);
            _vehicleDisplayName = [_vehicleDisplayName, gettext(_CfgVehicle >> "picture")];

            if (_simulation in _simTypesUnits) then  {
                if ((_cfgSide == _side) && !(tolower(getText(_CfgVehicle >> "vehicleClass")) in ["static","support","autonomous"])) then {
                    _vehicleArray pushback [_cfgclass,_vehicleDisplayName,_cost];
                };
            };
        };
    };

    missionNamespace setVariable [format["MCC_RTS_%1_%2",tolower _vehicleType,_side],_vehicleArray];
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

while {(str (_mccdialog displayCtrl 101) != "No control")} do {
    //Load available resources
    _array = call compile format ["MCC_res%1",playerside];

    {_mccdialog displayCtrl _x ctrlSetText str floor (_array select _forEachIndex)} foreach [81,82,83];
    _mccdialog displayCtrl 84 ctrlSetText str floor (player getVariable ["MCC_valorPoints",50]);
    sleep 1;
};