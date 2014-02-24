#define MCC_JUKEBOX_VOLUME 3059
#define MCC_JUKEBOX_TRACK 3060
#define MCC_JUKEBOX_ACTIVATE 3061
#define MCC_JUKEBOX_CONDITION 3062
#define MCC_JUKEBOX_ZONE 3063

disableSerialization;
private ["_type","_track","_trigger","_zone","_zoneX","_zoneY","_activate","_cond","_mccdialog","_markerName"];

_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");
_type = _this select 0;

switch (_type) do
{
   case 0:	//Previous
	{ 
		if (lbCurSel MCC_JUKEBOX_TRACK == 0) then 
			{
			lbSetCurSel [MCC_JUKEBOX_TRACK, (lbSize MCC_JUKEBOX_TRACK)-1];
			} else 
				{
				lbSetCurSel [MCC_JUKEBOX_TRACK, (lbCurSel MCC_JUKEBOX_TRACK)-1];
				};
		if (MCC_jukeboxMusic) then 
			{
				_track = (MCC_musicTracks_array select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;
				MCC_musicTracks_index = lbCurSel MCC_JUKEBOX_TRACK;
				[[2,compile format ["playMusic '%1'",_track]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			} else 
			{
				_track = (MCC_soundTracks_array select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;
				MCC_musicTracks_index = lbCurSel MCC_JUKEBOX_TRACK;
			};
	};
	
   case 1:	//Play
	{ 
		if (MCC_jukeboxMusic) then 
			{
				_track = (MCC_musicTracks_array select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;
				MCC_musicTracks_index = lbCurSel MCC_JUKEBOX_TRACK;
				[[2,compile format ["playMusic '%1'",_track]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
				copyToClipboard format ["%1",_track];
			} else 
			{
				_track = (MCC_soundTracks_array select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;
				MCC_musicTracks_index = lbCurSel MCC_JUKEBOX_TRACK;
			};
	};
	
   case 2:	//Forward
    { 
		if (lbCurSel MCC_JUKEBOX_TRACK == (lbSize MCC_JUKEBOX_TRACK)-1) then 
			{
			lbSetCurSel [MCC_JUKEBOX_TRACK, 0];
			} else 
				{
				lbSetCurSel [MCC_JUKEBOX_TRACK, (lbCurSel MCC_JUKEBOX_TRACK)+1];
				};
		if (MCC_jukeboxMusic) then 
			{
				_track = (MCC_musicTracks_array select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;
				MCC_musicTracks_index = lbCurSel MCC_JUKEBOX_TRACK;
				[[2,compile format ["playMusic '%1'",_track]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			} else 
			{
				_track = (MCC_soundTracks_array select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;
				MCC_musicTracks_index = lbCurSel MCC_JUKEBOX_TRACK;
			};
	};
	
   case 3:	//Stop
	{
		[[2,compile "playMusic ''"], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
	}; 

   case 4:	//Volume slider
	{
		if (MCC_jukeboxMusic) then {0 fadeMusic (1 - sliderPosition MCC_JUKEBOX_VOLUME)} else {0 fadesound (1 - sliderPosition MCC_JUKEBOX_VOLUME)};
	};	
	
   case 5:	//Link to zone
	{
		_zone = MCC_zones_numbers select (lbCurSel MCC_JUKEBOX_ZONE);
		if (count mcc_zone_pos < _zone) exitWith {hint "Invalid zone slected"}; 
		_zonePos = mcc_zone_pos select _zone;
		_zoneX = mcc_zone_size select (_zone) select 0;
		_zoneY = mcc_zone_size select (_zone) select 1;
		_activate = MCC_musicActivateby_array select (lbCurSel MCC_JUKEBOX_ACTIVATE);
		_cond = MCC_musicCond_array select (lbCurSel MCC_JUKEBOX_CONDITION);
		if (MCC_jukeboxMusic) then {_track = (MCC_musicTracks_array select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;} else {_track = (MCC_soundTracks_array select (lbCurSel MCC_JUKEBOX_TRACK)) select 1;};
		mcc_safe=mcc_safe + FORMAT ["
						  _zone=%1;
						  _zonePos=%2;
						  _zoneX=%3;
						  _zoneY=%4;
						  _activate='%5';
						  _cond='%6';
						  _track='%7';
						  MCC_jukeboxMusic=%8;
						  [[_zone, _zonePos, _zoneX, _zoneY, _activate, _cond,_track,MCC_jukeboxMusic ],'MCC_fnc_MusicTrigger',true,false] spawn BIS_fnc_MP;
						   sleep 1;
						  "								 
						  ,_zone
						  , _zonePos
						  , _zoneX
						  , _zoneY
						  , _activate
						  , _cond
						  , _track
						  , MCC_jukeboxMusic
						  ];
		hint format ["Trigger linked to zone: %1 \nCondition: %2, %3 \nOn activation play: %4",_zone,_activate,_cond,_track];
		_markerName = format ["%1: %2", _zone, _track];
		createmarkerlocal [_markerName, _zonePos];	//create  marker for MM
		_markerName setMarkerColorLocal "ColorBlue";
		_markerName setMarkerTypeLocal  "mil_box";
		_markerName setmarkertextlocal _markerName;
		[[_zone, _zonePos, _zoneX, _zoneY, _activate, _cond,_track,MCC_jukeboxMusic ],'MCC_fnc_MusicTrigger',true,false] spawn BIS_fnc_MP;
	};
	
	case 6:	//Switch to music tracks
	{
	MCC_jukeboxMusic = true;	
	_comboBox = _mccdialog displayCtrl MCC_JUKEBOX_TRACK; //fill combobox tracks
	lbClear _comboBox;
		{
			_displayname = format ["%1",_x  select 0];
			_comboBox lbAdd _displayname;
		} foreach MCC_musicTracks_array;
	_comboBox lbSetCurSel MCC_musicTracks_index;
	};
	
	case 7:	//Switch to sound tracks
	{
	MCC_jukeboxMusic = false;	
	_comboBox = _mccdialog displayCtrl MCC_JUKEBOX_TRACK; //fill combobox tracks
	lbClear _comboBox;
		{
			_displayname = format ["%1",_x  select 0];
			_comboBox lbAdd _displayname;
		} foreach MCC_soundTracks_array;
	_comboBox lbSetCurSel MCC_musicTracks_index;
	};
};