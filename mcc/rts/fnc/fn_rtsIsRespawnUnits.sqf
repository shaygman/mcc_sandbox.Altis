//=================================================================MCC_fnc_rtsIsRespawnUnits==============================================================================
//	checks if we can respawn units
//  Parameter(s):
//     	_ctrl: CONTROL
//==============================================================================================================================================================================
private ["_target","_unitsArray","_groupCfg"];
_target = param [0,grpNull,[missionNamespace,grpNull]];

_groupCfg = _target getVariable ["MCC_rtsGroupCfg",""];

if (isClass (missionconfigFile >> "cfgMCCRtsGroups")) then {
	_unitsArray = getArray (missionconfigFile >> "cfgMCCRtsGroups" >> _groupCfg >> format ["units%1",playerSide]);
} else {
	_unitsArray = getArray (configFile >> "cfgMCCRtsGroups" >> _groupCfg >> format ["units%1",playerSide]);
};

if (count units _target < count _unitsArray) then {true} else {false};