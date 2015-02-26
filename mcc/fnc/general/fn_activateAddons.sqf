private ["_cfg","_newAddons"];
_cfg = (configFile >> "CfgPatches");
_newAddons = [];

for "_i" from 0 to ((count _cfg) - 1) do
{
	_name = configName (_cfg select _i);
	if (! (["a3_", (configName (_cfg select _i))] call BIS_fnc_inString)) then {_newAddons pushBack _name};
};

if (count _newAddons > 0) then
{
		//activateAddons _newAddons;
		_newAddons call BIS_fnc_activateAddons;
};

