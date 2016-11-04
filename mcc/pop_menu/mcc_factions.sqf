private ["_mcc_config","_mcc_faction_idx","_mcc_sides","_unitCfg","_cfgname","_cfgdisplayname","_side","_sidename", "_check"];
_mcc_config 		= configFile >> "CfgFactionClasses";
_mcc_faction_idx 	= 0;
_mcc_sides      	= ["EAST","WEST","GUER","CIV"];
u_factions			= [];
U_FACTIONSCIV 		= [];

for "_i" from 1 to ((count _mcc_config) - 1) do
{

  _unitCfg = (_mcc_CONFIG select _i);


	if ((((getnumber((_unitCfg >> "side")))== 0) || ((getnumber((_unitCfg >> "side")))== 1) || ((getnumber((_unitCfg >> "side")))== 2) ||
	((getnumber((_unitCfg >> "side")))== 3)) && (getText (_unitCfg >> "displayName") != "") ) then
	{
	   _cfgname        = (configName(_unitcfg));

		_cfgdisplayname = (gettext(_unitCfg >> "displayname"));
		_side           = (getnumber((_unitCfg >> "side")));
		_sidename       = (_mcc_sides select _side);

	   //-------------------------------------------------------------------
		diag_log format ["factions: [%1] - [%2] - [%3] - [%4] - [%5] - [%6]", _unitCfg, _cfgname, _cfgdisplayname, _side, _sidename];  //DEBUG
	   //-------------------------------------------------------------------

		U_FACTIONS set [_mcc_faction_idx,[_cfgdisplayname, _sidename, _cfgname ]];
		if (_sidename == "CIV") then {
			U_FACTIONSCIV pushBack [_cfgdisplayname, _sidename, _cfgname];

			//Init faction groups and units to save time
		};
		_mcc_faction_idx = _mcc_faction_idx + 1;

	};
};