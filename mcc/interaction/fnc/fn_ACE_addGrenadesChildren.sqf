/*=============================================================== MCC_fnc_ACE_addGrenadesChildren=============================================================

	Build ACE childrens for grenades

*/
params ["_unit"];
private ["_grenadesType","_grenade","_grenadePic","_grenadeText","_children","_itemCount"];

_children = [];
_grenadesType = [];
{
	_grenade = _x;
	if (count ( format ["'%1' in getArray( _x >> 'magazines' )",_grenade] configClasses ( configFile >> "CfgWeapons" >> "Throw" ) ) > 0 &&
	    !(_grenade in _grenadesType)) then {
		_grenadesType pushBack _grenade;
		_grenadePic = getText(configFile >> "CfgMagazines">> _grenade >> "picture");
		_grenadeText = getText(configFile >> "CfgMagazines">> _grenade >> "displayName");
		_itemCount = {_x isEqualTo _grenade} count (magazines _unit);


		_children pushBack
        [
            [
                format ["Grenade_%1", _forEachIndex],
                format [_grenadeText + " (%1)", _itemCount],
                _grenadePic,
                {_this spawn MCC_fnc_interactDoorGrenadeThrow},
                {true},
                {},
                [_grenade,cursorTarget]
            ] call ace_interact_menu_fnc_createAction,
            [],
            _unit
        ];
	};
} forEach (magazines _unit);

_children