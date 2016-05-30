#define MCC_JUKEBOX_VOLUME 3059
#define MCC_JUKEBOX_TRACK 3060
#define MCC_JUKEBOX_ACTIVATE 3061
#define MCC_JUKEBOX_CONDITION 3062
#define MCC_JUKEBOX_ZONE 3063

disableSerialization;
private ["_type","_track","_trigger","_zone","_zoneX","_zoneY","_activate","_cond","_mccdialog","_markerName","_jukeBoxMusic","_trackArray","_tracksCfg","_cfgname","_cfgclass"];

_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");
_type = _this select 0;

missionNamespace setVariable ["MCC_musicTracks_index",lbCurSel MCC_JUKEBOX_TRACK];

//Build Array
_jukeBoxMusic = missionNamespace getvariable ["MCC_jukeboxMusic",true];
_trackArray = [];

_tracksCfg = if (_jukeBoxMusic) then {[missionConfigFile >> "CfgMusic",configFile >> "CfgMusic"]} else {[missionConfigFile >> "CfgSounds",ConfigFile >> "CfgSounds",configFile >> "CfgSFX"]};

{
	for "_i" from 0 to ((count _x) - 1) do {
		_track = _x select _i;
		if (isClass _track) then {
			_cfgname = getText (_track >> "name");
			_cfgclass = configName(_track);
			_trackArray pushBack [_cfgname,_cfgclass,_foreachindex];
		};
	};
} forEach _tracksCfg;

//What are we doing
_track = (_trackArray select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;

switch (_type) do {
	//Previous
  	case 0:	 {
		if (lbCurSel MCC_JUKEBOX_TRACK == 0) then {
			lbSetCurSel [MCC_JUKEBOX_TRACK, (lbSize MCC_JUKEBOX_TRACK)-1];
		} else {
			lbSetCurSel [MCC_JUKEBOX_TRACK, (lbCurSel MCC_JUKEBOX_TRACK)-1];
		};

		if (_jukeBoxMusic) then {
			[[2,compile format ["playMusic '%1'",_track]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		};
	};

	//Play
    case 1:	{
		if (_jukeBoxMusic) then	{
			[[2,compile format ["playMusic '%1'",_track]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		} else {
			if (isClass(configFile >> "CfgSounds" >> _track) || isClass(missionconfigFile >> "CfgSounds" >> _track)) then {
				[[2,compile format ["playSound '%1'",_track]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			};
		};
	};

	//Forward
   	case 2:	{
		if (lbCurSel MCC_JUKEBOX_TRACK == (lbSize MCC_JUKEBOX_TRACK)-1) then {
			lbSetCurSel [MCC_JUKEBOX_TRACK, 0];
		} else {
			lbSetCurSel [MCC_JUKEBOX_TRACK, (lbCurSel MCC_JUKEBOX_TRACK)+1];
		};

		if (_jukeBoxMusic) then {
			[[2,compile format ["playMusic '%1'",_track]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		};
	};

	//Stop
   	case 3:	{
		[[2,compile "playMusic ''"], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
	};

	//Volume slider
   	case 4:	{
		if (_jukeBoxMusic) then {0 fadeMusic (1 - sliderPosition MCC_JUKEBOX_VOLUME)} else {0 fadesound (1 - sliderPosition MCC_JUKEBOX_VOLUME)};
	};

	//Link to zone
   	case 5:	{
		_zone = (missionNamespace getVariable ["MCC_zones_numbers",[]]) select (lbCurSel MCC_JUKEBOX_ZONE);
		if (count mcc_zone_pos < _zone) exitWith {hint "Invalid zone slected"};
		_zonePos = mcc_zone_pos select _zone;
		_zoneX = mcc_zone_size select (_zone) select 0;
		_zoneY = mcc_zone_size select (_zone) select 1;
		_activate = MCC_musicActivateby_array select (lbCurSel MCC_JUKEBOX_ACTIVATE);
		_cond = MCC_musicCond_array select (lbCurSel MCC_JUKEBOX_CONDITION);

		mcc_safe=mcc_safe + FORMAT ["
						  _zone=%1;
						  _zonePos=%2;
						  _zoneX=%3;
						  _zoneY=%4;
						  _activate='%5';
						  _cond='%6';
						  _track='%7';
						  _jukeBoxMusic=%8;
						  [[_zone, _zonePos, _zoneX, _zoneY, _activate, _cond,_track,_jukeBoxMusic ],'MCC_fnc_MusicTrigger',true,false] spawn BIS_fnc_MP;
						   sleep 1;
						  "
						  ,_zone
						  , _zonePos
						  , _zoneX
						  , _zoneY
						  , _activate
						  , _cond
						  , _track
						  , _jukeBoxMusic
						  ];
		hint format ["Trigger linked to zone: %1 \nCondition: %2, %3 \nOn activation play: %4",_zone,_activate,_cond,_track];

		//create  marker for MM
		_markerName = format ["%1: %2", _zone, _track];
		createmarkerlocal [_markerName, _zonePos];
		_markerName setMarkerColorLocal "ColorBlue";
		_markerName setMarkerTypeLocal  "mil_box";
		_markerName setmarkertextlocal _markerName;

		//execute on all clients
		[[_zone, _zonePos, _zoneX, _zoneY, _activate, _cond,_track,_jukeBoxMusic ],'MCC_fnc_MusicTrigger',true,false] spawn BIS_fnc_MP;
	};

	//Switch to music tracks
	case 6:	 {
		missionNamespace setvariable ["MCC_jukeboxMusic",true];
		_null = [13] execVM format ["%1mcc\general_scripts\groupGen\controlsHandle.sqf",MCC_path];
	};

	//Switch to sound tracks
	case 7:	{
		missionNamespace setvariable ["MCC_jukeboxMusic",false];
		_null = [13] execVM format ["%1mcc\general_scripts\groupGen\controlsHandle.sqf",MCC_path];
	};
};