//======================================================MCC_fnc_MWSpawnInZone=========================================================================================================
// Create a pick intel objective
// Example:[_zoneNumber,_spawnType,_classtype,_spawnwithcrew,_spawnname,_spawnfaction,_spawnbehavior,_spawndisplayname] call MCC_fnc_MWSpawnInZone;
// Return - handler
//========================================================================================================================================================================================
private ["_zoneNumber","_script_handler","_spawnType","_classtype","_spawnwithcrew","_spawnname","_spawnfaction","_spawnbehavior","_spawndisplayname",
         "_previusZone","_side","_safe_pos","_p_mcc_zone_markposition","_p_maxrange","_ar"];

_zoneNumber 		= _this select 0;
_spawnType			= _this select 1;
_classtype			= _this select 2;
_spawnwithcrew		= _this select 3;
_spawnname			= _this select 4;
_spawnfaction		= _this select 5;
_spawnbehavior		= _this select 6;
_spawndisplayname	= _this select 7;
_side				= _this select 8;

_previusZone = format ["%1", mcc_active_zone];
_previusZone setMarkerColorLocal "colorBlack";
_previusZone setMarkerBrushLocal "Solid";

//time to request something so lets number it
mcc_request= (missionNamespace getVariable ["mcc_request",0])+1;
publicVariable "mcc_request";

// What ever we do, we need a good position
_p_mcc_zone_markposition = (mcc_zone_pos select (_zoneNumber));
_p_maxrange				 = ((mcc_zone_size select (_zoneNumber)) select 1);


switch (_classtype) do
{
	case "AIR":
	{
		if !_spawnwithcrew then
		{_safe_pos     =[_p_mcc_zone_markposition,1,_p_maxrange,2,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos; }
		else
		{_safe_pos     =[_p_mcc_zone_markposition ,1,_p_maxrange,2,1,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;};
	};

	case "Reinforcement":
	{
		_safe_pos     =[_p_mcc_zone_markposition,1,_p_maxrange,2,1,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	};

	case "DIVER":
	{
		_safe_pos     =[_p_mcc_zone_markposition,1,_p_maxrange,2,1,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	};

	case "LAND":
	{
		_safe_pos     =[_p_mcc_zone_markposition,1,_p_maxrange,2,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	};

	case "WATER":
	{
		_safe_pos     =[_p_mcc_zone_markposition,1,_p_maxrange,2,2,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	};

	default
	{
		_safe_pos     =[_p_mcc_zone_markposition,1,_p_maxrange,2,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	};
};

_ar =	[ 		  _spawnType
				, _classtype
				, false
				, _spawnwithcrew
				, _spawnname
				, _spawnfaction
				, _zoneNumber
				, 'NOTHING'
				, str _zoneNumber
				, _spawnbehavior
				, (mcc_zone_pos select (_zoneNumber))
				, (mcc_zone_size select (_zoneNumber))
				, ((mcc_zone_size select (_zoneNumber)) select 1)
				, _side
				, objNull
				, mcc_request
				, false
				, false
				, "server"
				, 'default'
				, 1
				, [0,0,0]
				, 0 //(mcc_zonetype select 0 ) select 1
				, 0 //(mcc_zonetypenr select 0 ) select 1
				, 0
				, _safe_pos
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
