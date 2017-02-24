/*========================================= MCC_fnc_interactDoorGrenadeThrow ========================================================================

	Throw a grenade into a house
*/
private ["_door","_animation","_phase","_closed","_magazine","_params","_object","_doorStatus","_eh","_magMuzzle"];
_unit = param [0, objNull, [objNull]];
_params = param [2, [], [[]]];
_magazine = _params param [0, "", [""]];
_object = _params param [1, objNull, [objNull]];

if (!alive _unit || isNull _object || !(_magazine in magazines _unit)) exitWith {};

_doorStatus = [_object]  call MCC_fnc_isDoor;
_door = _doorStatus select 0;
_animation = _doorStatus select 1;
_phase = _doorStatus select 2;
_closed = _doorStatus select 3;

if (_door == "") exitWith {};

closeDialog 0;

_object animate [_animation, 0.7];
sleep 0.2;

_eh = _unit addEventHandler ["Fired", {
			_velocity = velocity (_this select 6);
			_velocity = [
				0.4 * (_velocity select 0),
				0.4 * (_velocity select 1),
				1*(_velocity select 2) min 10
			  ];

			 (_this select 6) setVelocity _velocity;
		}];

_magMuzzle = configName ((format ["'%1' in getArray( _x >> 'magazines' )",_magazine] configClasses ( configFile >> "CfgWeapons" >> "Throw" )) select 0);
_unit forceWeaponFire [_magMuzzle,_magMuzzle];
sleep 0.8;
_object animate [_animation, 0];
if (!isnil "_eh") then {_unit removeEventHandler ["fired",_eh]};