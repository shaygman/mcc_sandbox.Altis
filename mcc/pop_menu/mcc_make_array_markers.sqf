private ["_cfgComp", "_k", "_comp", "_cfgComp", "_cfgname", "_cfgicon", "_cfgclass"];
_cfgComp = configFile >> "CfgMarkers";
_k = 0;

for "_i" from 0 to ((count _cfgComp) - 1) do 	//make array markers
	{
		_comp = _cfgComp select _i;
		//Make sure we selected a class.
		if (isClass _comp) then
		{
			_cfgname  = (getText(_comp >> "name"));
			_cfgicon  = (getText(_comp >> "icon"));
			_cfgclass = configName(_comp);
			MCC_markerarray set[(_k),[_cfgname,_cfgicon,_cfgclass]];
			_k = _k + 1;
        };
	};

_cfgComp = configFile >> "CfgMarkerBrushes";	//Make array brushes
_k = 0;

for "_i" from 0 to ((count _cfgComp) - 1) do {
	_comp = _cfgComp select _i;
	_cfgname  = (getText(_comp >> "name"));
	_cfgicon  = (getText(_comp >> "texture"));
	_cfgclass = configName(_comp);
	MCC_brushesarray set[(_k),[_cfgname,_cfgicon,_cfgclass]];
	_k = _k + 1;

};
