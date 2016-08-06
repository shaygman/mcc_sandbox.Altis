private ["_marker","_nul","_markerlabel","_zones"];


MCC_Marker_type = "RECTANGLE";
MCC_MarkerZoneColor = "colorYellow";
MCC_MarkerZoneType = "mil_join";


//safe the zone size in the array for later use
_zones = (missionNamespace getVariable ["MCC_zones_numbers",[]]);
_zones set [(mcc_zone_number-1), mcc_zone_number];
(missionNamespace setVariable ["MCC_zones_numbers",_zones]);

mcc_zone_pos  set [mcc_zone_number, mcc_zone_markposition];
mcc_zone_size set [mcc_zone_number,[mcc_zone_marker_X,mcc_zone_marker_Y]];
mcc_zone_dir set [mcc_zone_number,MCC_Marker_dir];
mcc_zone_locations set [mcc_zone_number,mcc_hc];

publicVariable "mcc_zone_pos";
publicVariable "mcc_zone_size";
publicVariable "mcc_zone_dir";
publicVariable "mcc_zone_locations";
publicVariable "MCC_zones_numbers";

//obviously when we are loading there is no need to safe it again since that will influence the load process by double output
if (!MCC_capture_state) then
	{
		deleteMarkerLocal mcc_zone_markername;
		_marker = createMarkerLocal [mcc_zone_markername, mcc_zone_markposition];
		_marker setMarkerShapeLocal MCC_Marker_type;
		_marker setMarkerDirLocal MCC_Marker_dir;
		_marker setMarkerSizeLocal (mcc_zone_size select mcc_zone_number);
		_marker setMarkerAlphalocal 0.2;
		mcc_zone_markername	setMarkerColorLocal MCC_MarkerZoneColor;

		deleteMarkerLocal (format["LABEL_%1",mcc_zone_markername]);
		_markerlabel = createMarkerLocal [(format["LABEL_%1",mcc_zone_markername]), mcc_zone_markposition];
		_markerlabel setMarkerShapeLocal "ICON";
		(format["LABEL_%1",mcc_zone_markername]) setMarkerTypeLocal MCC_MarkerZoneType;
		(format["LABEL_%1",mcc_zone_markername]) setMarkerTextLocal mcc_zone_markername;
		(format["LABEL_%1",mcc_zone_markername]) setMarkerColorLocal "ColorRed";

		mcc_isnewzone = true;

		_nul= [0] execVM MCC_path + "mcc\general_scripts\mcc_SpawnStuff.sqf";
	};

	if (MCC_capture_state) then {
		MCC_capture_var=MCC_capture_var + FORMAT ["
									mcc_zone_markposition=%1;
									mcc_zone_number=%2;
									mcc_zone_marker_X=%3;
									mcc_zone_marker_Y=%4;
									mcc_zone_markername='%5';
									mcc_hc=%6;
									MCC_Marker_dir = %7;
									MCC_zones_numbers = (missionNamespace getVariable ['MCC_zones_numbers',[]]);
									MCC_zones_numbers set [(mcc_zone_number-1),mcc_zone_number];
									mcc_zone_pos  set [mcc_zone_number,mcc_zone_markposition];
									mcc_zone_size set [mcc_zone_number,[mcc_zone_marker_X,mcc_zone_marker_Y]];
									mcc_zone_dir set [mcc_zone_number,MCC_Marker_dir];
									publicVariable 'MCC_zones_numbers';
									publicVariableServer 'mcc_zone_pos';
									publicVariableServer 'mcc_zone_size';
									publicVariableServer 'MCC_Marker_dir';
									mcc_zone_locations set [mcc_zone_number,mcc_hc];
									script_handler = [0] execVM '"+MCC_path+"mcc\general_scripts\mcc_make_the_marker.sqf';
								  "
								,mcc_zone_markposition
								,mcc_zone_number
								,mcc_zone_marker_X
								,mcc_zone_marker_Y
								,mcc_zone_markername
								,mcc_hc
								,MCC_Marker_dir
								];
		hint "Action captured";
	};