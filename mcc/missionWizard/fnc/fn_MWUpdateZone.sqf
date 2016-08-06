//==================================================MCC_fnc_MWUpdateZone=================================================================================================
// Create a zone
// Example:[_zoneNumber,_pos,_radius] call MCC_fnc_MWUpdateZone;
// Return - handler
//======================================================================================================================================================================
private ["_zoneNumber","_script_handler","_pos","_radius","_zone_marker_X","_zone_marker_Y","_ar","_zones","_dir"];
_zoneNumber = _this select 0;
_pos		= _this select 1;
_radius		= _this select 2;

_zone_marker_X		= if (typeName _radius == typeName []) then {_radius select 0} else {_radius};
_zone_marker_Y		= if (typeName _radius == typeName []) then {_radius select 1} else {_radius};
_dir = if (typeName _radius == typeName []) then {
			if (count _radius > 2) then {
				_radius select 2
			} else {0};
		} else {0};

//safe the zone size in the array for later use
_zones = (missionNamespace getVariable ["MCC_zones_numbers",[]]);
_zones set [(_zoneNumber-1), _zoneNumber];
missionNamespace setVariable ["MCC_zones_numbers",_zones];

mcc_zone_pos  set [_zoneNumber, _pos];
mcc_zone_size set [_zoneNumber,[_zone_marker_X,_zone_marker_Y]];
mcc_zone_dir set [_zoneNumber,0];
mcc_zone_locations set [_zoneNumber,0];

publicVariable "mcc_zone_pos";
publicVariable "mcc_zone_size";
publicVariable "mcc_zone_dir";
publicVariable "mcc_zone_locations";
publicVariable "MCC_zones_numbers";

//time to request something so lets number it
mcc_request= (missionNamespace getVariable ["mcc_request",0])+1;
publicVariable "mcc_request";

_ar =	[ 		  ''
				, ''
				, true
				, false
				, ''
				, ''
				, _zoneNumber
				, 'NOTHING'
				, str _zoneNumber
				, 'MOVE'
				, _pos
				, [_zone_marker_X,_zone_marker_Y]
				, (_zone_marker_X+_zone_marker_X)/2
				, sideLogic
				, objNull
				, mcc_request
				, false
				, false
				, "server"
				, 'default'
				, 0
				, [0,0,0]
				, 0 //(mcc_zonetype select 0 ) select 1
				, 0 //(mcc_zonetypenr select 0 ) select 1
				, _dir
				, [-500,-500,0]
				, false
				, false
				];

// Send data over the network, or when on server, execute directly
if ( (isServer) && ( (mcc_hc == 0) || !(MCC_isHC) ) ) then {
	[_ar, "mcc_setup", false, false] spawn BIS_fnc_MP;
	diag_log "MCC: attemping to spawn";

} else {
	if ( ( mcc_hc == 0 ) || !(MCC_isHC) ) then	{
		[_ar, "mcc_setup", false, false] spawn BIS_fnc_MP;
	};

	if (( mcc_hc == 1 ) && (MCC_isHC)) then	{

		[_ar, "mcc_setup_hc", MCC_ownerHC, false] spawn BIS_fnc_MP;
	};
};

true;



