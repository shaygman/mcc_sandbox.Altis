/*==================================================================MCC_fnc_tagSystem======================================================================================
// Init MCC 3d markers - tagging system. Adds 3D markers when tagging an enemy
//===================================================================================================================================================================*/

if (!hasInterface) exitWith {};

["MCC_tagSystem", "onEachFrame", {
	if !(missionNamespace getVariable ["MCC_allow3DSpotting",true]) exitWith {};
	_sidePlayer = side player;

	{
		_unit = _x;

		if (alive _unit) then {
			if (((worldToScreen (visiblePosition _unit)) select 0 > (0 * safezoneW + safezoneX)) && ((worldToScreen (visiblePosition _unit)) select 0 <(1 * safezoneW + safezoneX)) && player distance _unit < 3500) then {

				if !(lineIntersects [ eyePos player, getPosASL _unit, player, _unit]) then {
					private ["_size"];
					_texture = [_unit getVariable ["icon",""]] call BIS_fnc_textureMarker;

					_markerColor = [0.8,0,0,0.8];
					_pos = getpos _unit;
					_pos set [2,(_pos select 2) + 1];
					_size = (1 - ((((player distance _unit)*0.001) max 0.1) min 0.6));

					drawIcon3D [
						_texture,
						_markerColor,
						_pos,
						_size,
						_size,
						0
					];
				};
			};
		};
	} foreach (missionNamespace getVariable ["MCC_knownTargetsTags",[]]);
}] call BIS_fnc_addStackedEventHandler;


/*
// Battlefield tagging system a bit to much for an arma game


waituntil {!(isnull (finddisplay 602))};
//Delete it please
["MCC_tagSystem", "onEachFrame", {
	{
		_unit = _x;
		_sidePlayer = side player;
		_sideUnit = side _unit;

		if ([_sidePlayer , _sideUnit] call BIS_fnc_sideIsEnemy) then {
			if (vehicle _unit == _unit || ((vehicle _unit != _unit) && (_unit == driver vehicle _unit))) then {

				if (((worldToScreen (visiblePosition _unit)) select 0 > (0 * safezoneW + safezoneX)) && ((worldToScreen (visiblePosition _unit)) select 0 <(1 * safezoneW + safezoneX)) && player distance _unit < 1000) then {

				if !(lineIntersects [ eyePos player, getPosASL _unit, player, _unit]) then {
					_texture = gettext (configfile >> "CfgVehicles" >> typeof (vehicle _unit) >> "Icon");
					_markerColor = [_sideUnit] call BIS_fnc_sideColor;
					_unit = vehicle _unit;


					private ["_size"];
					_bbr = boundingBoxReal _unit;
					_p1 = _bbr select 0;
					_p2 = _bbr select 1;
					_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
					_pos = getpos _unit;
					_pos set [2,(_pos select 2) + _maxHeight];
					_size = (1 - ((((player distance _unit)*0.001) min 0.8) max 0.4))* (if (_unit iskindof "man") then {1} else {1.3});

						drawIcon3D [
							_texture,
							_markerColor,
							_pos,
							_size,
							_size,
							0
						];
					};
				};
			};
		};
	} foreach allUnits;
}] call BIS_fnc_addStackedEventHandler;
*/