/*=================================================================MCC_fnc_supressionFiredEH================================================================================
  create projectile pos loc
  IN <>
    Nothing
*/

params [
        "_unit",
        "_weapon",
        "_muzzle",
        "_mode",
        "_ammo",
        "_magazine",
        "_projectile"
    ];
private ["_cfg","_hit","_distance","_projectiles","_dirTo"];

if (isNull _projectile) then {
     _projectile = nearestObject [_unit, _ammo];
};

if (isNull _projectile) exitWith {};

_cfg = configFile >> "CfgAmmo" >> _ammo;
_hit  = getNumber (_cfg >> "hit");
_distance = (getNumber (_cfg >> "suppressionRadiusHit")) max 8;

//No damage or a grenade/explosive
if ((_weapon in ["throw","put"]) || _hit <=0) exitWith {};

_dirTo = [_projectile,player] call BIS_fnc_relativeDirTo;

//Manage only bulltes that are aimed on the player
if (_dirTo > 310 || _dirTo < 50) then {
    _projectiles = missionNamespace getVariable ["MCC_supressionHitPos",[]];
    _projectiles pushBack [_projectile, _distance, _unit];
    missionNamespace setVariable ["MCC_supressionHitPos",_projectiles];
};

