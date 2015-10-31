//=================================================================MCC_fnc_vehicleSpawner==================================================================================
//  manage the actull spawning
//==============================================================================================================================================================================
private ["_vehicleArray","_action","_selectedVehicle","_cost","_cfgclass","_costAmmo","_costRepair","_costFuel","_ctrl","_array","_mccdialog","_disableCtrl","_costValor"];

_vehicleArray = missionNamespace getVariable ["MCC_private_vehicleArray",[]];
if (count _vehicleArray == 0 || (lbCurSel 101) == -1) exitWith {};

disableSerialization;
_mccdialog = uiNamespace getVariable "MCC_VEHICLESPAWNER_IDD";

_selectedVehicle = _vehicleArray select (lbCurSel 101);
_cfgclass = _selectedVehicle select 0;
_cost = _selectedVehicle select 2;
_costAmmo = floor (_cost*0.3);
_costRepair = floor (_cost*0.5);
_costFuel = floor (_cost*0.2);
_costValor = floor (_cost*0.25);

_array = call compile format ["MCC_res%1",playerside];

_action =  [_this, 0, 0, [0]] call BIS_fnc_param;

//Change value
if (_action == 0) exitWith {
    _ctrl = 1000;
    _disableCtrl = true;

    //Do we have enough personal resources
    {
        ctrlSetText [_ctrl, str _x];
        if (_x <= (_array select _foreachindex)) then {
            (_mccdialog displayctrl _ctrl) ctrlSetTextColor [1,1,1,1];
        } else {
            (_mccdialog displayctrl _ctrl) ctrlSetTextColor [1,0,0,1];
            _disableCtrl = false;
        };
        _ctrl = _ctrl +1;
    } forEach [_costAmmo,_costRepair,_costFuel];

    //Do we have enough personal fame
    _ctrl = _mccdialog displayctrl 1003;
    _ctrl ctrlSetText str _costValor;

    if ((player getVariable ["MCC_valorPoints",50]) >= _costValor) then {
        _ctrl ctrlSetTextColor [1,1,1,1];
    } else {
        _ctrl ctrlSetTextColor [1,0,0,1];
        _disableCtrl = false;
    };

    ctrlEnable [102,_disableCtrl];
};

//Spawn value
if (_action == 1) then {
    private ["_spawnPad","_spawnPadPos","_check","_vehicle"];

    _spawnPad = missionNamespace getVariable ["MCC_private_spawnPad",objNull];

    if (isNull _spawnPad) exitWith {};
    _spawnPadPos = getpos _spawnPad;

    //can we spawn?
    _check = _spawnPadPos nearObjects ["LandVehicle", 5];
    if (count _check > 0) exitWith {systemChat "Can't spawn. Spawn point isn't clear"};
    _check = _spawnPadPos nearObjects ["Ship", 5];
    if (count _check > 0) exitWith {systemChat "Can't spawn. Spawn point isn't clear"};
    _check = _spawnPadPos nearObjects ["Air", 5];
    if (count _check > 0) exitWith {systemChat "Can't spawn. Spawn point isn't clear"};

    _array = [(_array select 0) -_costAmmo,(_array select 1) -_costRepair,(_array select 2) -_costFuel,(_array select 3),(_array select 4)];
    missionNamespace setVariable [format ["MCC_res%1",playerside],_array];
    publicVariable format ["MCC_res%1",playerside];

    //Reduce valor
    player setVariable ["MCC_valorPoints",(player getVariable ["MCC_valorPoints",50])-_costValor,true];

    _vehicle = _cfgclass createVehicle _spawnPadPos;

    _vehicle setpos _spawnPadPos;
    _vehicle setdir getdir _spawnPad;
    _vehicle setVariable ["mcc_delete",false,true];
    _vehicle setVariable ["MCC_rtsObject",true,true];

    //clear cargo
    clearMagazineCargoGlobal _vehicle;
    clearWeaponCargoGlobal _vehicle;
    clearBackpackCargoGlobal _vehicle;
    clearItemCargoGlobal _vehicle;

    [[[_vehicle], {MCC_curator addCuratorEditableObjects [[_this select 0],false];}], "BIS_fnc_spawn", false, false, false] call BIS_fnc_MP;
    closeDialog 0;
};