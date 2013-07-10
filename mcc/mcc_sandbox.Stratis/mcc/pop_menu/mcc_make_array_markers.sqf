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

for "_i" from 0 to ((count _cfgComp) - 1) do 
	{
		_comp = _cfgComp select _i;
		_cfgname  = (getText(_comp >> "name"));
		_cfgicon  = (getText(_comp >> "texture"));
		_cfgclass = configName(_comp);
		MCC_brushesarray set[(_k),[_cfgname,_cfgicon,_cfgclass]];
		_k = _k + 1;
     
	};

_tracks = configFile >> "CfgMusic";	//Make array music tracks
_k = 0;
for "_i" from 0 to ((count _tracks) - 1) do
	{
		_track = _tracks select _i;
		if (isClass _track) then
		{
			_cfgname = getText (_track >> "name");
			_cfgclass = configName(_track);
			MCC_musicTracks_array set[(_k),[_cfgname,_cfgclass]];
			_k = _k + 1;			
		};
	};

_tracks = configFile >> "CfgSFX";	//Make array sound tracks
_k = 0;
for "_i" from 0 to ((count _tracks) - 1) do
	{
		_track = _tracks select _i;
		if (isClass _track) then
		{
			_cfgname = getText (_track >> "name");
			_cfgclass = configName(_track);
			MCC_soundTracks_array set[(_k),[_cfgname,_cfgclass]];
			_k = _k + 1;			
		};
	};
