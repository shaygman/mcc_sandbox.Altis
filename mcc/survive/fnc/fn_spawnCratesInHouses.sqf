/*=================================================================MCC_fnc_spawnCratesInHouses==============================================================================
	Handles food and water consumption while survival is on
*/
if (!isServer) exitWith {};

private ["_worldPath","_mapSize","_mapCenter","_index","_buildings","_availablePos","_buildingPos"];
_worldPath = configfile >> "cfgworlds" >> worldname;
_mapSize = getnumber (_worldPath >> "mapSize");
if (_mapSize == 0) then {_mapSize = 10000};

_mapSize = _mapSize / 2;
_mapCenter = [_mapSize,_mapSize];

_buildings = _mapCenter nearObjects ["House",10000];
_index = 0;
{
	_availablePos = [];

	for "_i" from 0 to 20 do {
	    _buildingPos = _x buildingpos _i;
	    if (str _buildingPos == "[0,0,0]") exitwith {};
	    _availablePos pushBack _buildingPos;
	};

	{
		if (random 100 < 1) then {
			_object = (["Land_Sack_F","Land_MetalBarrel_F","Land_MetalCase_01_small_F","Land_PlasticCase_01_small_F"] call BIS_fnc_selectRandom) createVehicle _x;
			_object setPos _x;
			_object setDir (random 360);
			_index = _index +1;
			_eib_marker = createMarkerlocal [format ["itemMarker_%1", _index],_x];
			_eib_marker setMarkerTypelocal "mil_dot";
			_eib_marker setMarkerColorlocal "ColorRed";
		};
	} forEach _availablePos;
} foreach _buildings;

systemChat format ["Total of %1 items created", _index];


{
	_temploc = [_mapCenter,5000,_x] call MCC_fnc_MWbuildLocations;
	{
		_buildings = (getpos (_x select 0)) nearObjects ["House",500];

	    {
	    	_availablePos = [];

			for "_i" from 0 to 20 do {
			    _buildingPos = _x buildingpos _i;
			    if (str _buildingPos == "[0,0,0]") exitwith {};
			    _availablePos pushBack _buildingPos;
			};

			{
				if (random 100 < 3) then {
					_object = (["Land_Sack_F","Land_MetalBarrel_F","Land_MetalCase_01_small_F","Land_PlasticCase_01_small_F"] call BIS_fnc_selectRandom) createVehicle _x;
					_object setPos _x;
					_object setDir (random 360);
				};
			} forEach _availablePos;
	    } foreach _buildings;
	} forEach _temploc;
} forEach ["city","mil","nature"];

addMissionEventHandler ["HandleDisconnect",{
		private ["_tempArray","_player"];
		_player = _this select 0;

		[format ["%1_playerPos",worldname], [_this select 2,_this select 3],position _player, "ARRAY"] remoteExec ["MCC_fnc_setVariable", 2];

		//Gear
		_tempArray = [goggles _player,
					  headgear _player,
					  uniform _player,
					  vest _player,
					  backpack _player,
					  backpackItems _player,
					  primaryWeaponMagazine _player,
					  secondaryWeaponMagazine _player,
					  handgunMagazine _player,
					  items _player,
					  assignedItems _player,
					  uniformItems _player,
					  vestItems _player,
					  primaryWeapon _player,
					  secondaryWeapon _player,
					  handgunWeapon _player,
					  magazines _player,
					  primaryWeaponItems _player,
					  secondaryWeaponItems _player,
					  handgunItems _player];

		[format ["%1_playerGear",worldname], [_this select 2,_this select 3],_tempArray, "ARRAY"] remoteExec ["MCC_fnc_setVariable", 2];

		diag_log "we finished" + str _this;
	}];