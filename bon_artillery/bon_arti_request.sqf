//by Bon_Inf*
#define BON_ARTY_DIALOG 999900
#define BON_ARTY_SHELLSLEFT 999901
#define BON_ARTY_XRAY 999902
#define BON_ARTY_YANKEE 999903
#define BON_ARTY_CANNONLIST 999904
#define BON_ARTY_XRAYEDIT 999905
#define BON_ARTY_YANKEEEDIT 999906
#define BON_ARTY_DIRECTION 999907
#define BON_ARTY_DISTANCE 999908
#define BON_ARTY_HEIGHT 999909
#define BON_ARTY_HEIGHTINDEX 999910
#define BON_ARTY_DELAYEDIT 999911
#define BON_ARTY_SUMMARY 999913
#define BON_ARTY_REQUESTBUTTON 999914
#define BON_ARTY_TYPE 999915
#define BON_ARTY_NRSHELLS 999916
#define BON_ARTY_SPREAD 999917
#define BON_ARTY_XCORRECTION 999918
#define BON_ARTY_YCORRECTION 999919
#define BON_ARTY_ADJUSTBUTTON 999920
#define BON_ARTY_MISSIONTYPE 999921
disableSerialization;

_requestor = _this;

// read out the dialog input
_dlg = findDisplay BON_ARTY_DIALOG;
_x_correction = parseNumber ctrlText (_dlg displayCtrl BON_ARTY_XCORRECTION);
_y_correction = parseNumber ctrlText (_dlg displayCtrl BON_ARTY_YCORRECTION);
_missiontype = lbText [BON_ARTY_MISSIONTYPE,lbCurSel BON_ARTY_MISSIONTYPE];
_spreadtype = lbText [BON_ARTY_SPREAD,lbCurSel BON_ARTY_SPREAD];

_cannons_to_fireVR 		= _requestor getVariable ["requesting_cannons",[]];
_cannons_to_fireReal 	= _requestor getVariable ["requesting_cannonsReal",[]];

if (count _cannons_to_fireReal > 0) then {[_requestor,_x_correction,_y_correction] call MCC_fnc_consoleFireArtillery};
if (count _cannons_to_fireVR == 0) exitWith {};

if (isnil "MCC_bonFire") then {MCC_bonFire = false};
if (isnil "MCC_bonSplash") then {MCC_bonSplash = false};

if (MCC_bonFire || MCC_bonSplash) exitWith {};

_message = "Polar,";
if(_x_correction != 0 || _y_correction != 0) then{
	_message = "SHIFT";
	if(_x_correction < 0) then{_message =  format["%1 Left %2,",_message,abs _x_correction]};
	if(_x_correction > 0) then{_message =  format["%1 Right %2,",_message,_x_correction]};
	if(_y_correction < 0) then{_message =  format["%1 Drop %2,",_message,abs _y_correction]};
	if(_y_correction > 0) then{_message =  format["%1 Add %2,",_message,_y_correction]};
};

if(_spreadtype == "LASER") then{_message = "Polar Laser,"};

_requestor spawn {
	[[[netid _this,_this], "requestO1"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	sleep (5 + random 2);
	[[[netid _this,_this], "requestS1"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	sleep (5 + random 2);
};
sleep (6 + random 6);
MCC_bonFire = true; 
MCC_bonSplash = true; 

publicVariable "MCC_bonFire"; 
publicVariable "MCC_bonSplash"; 

switch _missiontype do 
{
	case "ADJUSTMENT" : 
	{
		[[[netid _requestor,_requestor], "gridO2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (10 + random 2);
		[[[netid _requestor,_requestor], "gridS2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (9 + random 2);
		[[[netid _requestor,_requestor], "splashO3"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (3 + random 1);
		[[[netid _requestor,_requestor], "splashS3"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (2.5 + random 1);
		[[[netid _requestor,_requestor], "messegeS4"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (9 + random 2);
		[[[netid _requestor,_requestor], "messegeO4"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (9 + random 2);
		[] execVM (BON_ARTI_PATH+"bon_arti_adjustfire.sqf");
	};

	case "FOR EFFECT" : 
	{
		CloseDialog 0;	
		// initiate fire mission
		[[[netid _requestor,_requestor], "gridO2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (10 + random 2);
		[[[netid _requestor,_requestor], "gridS2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (9 + random 2);
		[[[netid _requestor,_requestor], "splashO3"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (3 + random 1);
		[[[netid _requestor,_requestor], "splashS3"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep (2.5 + random 1);
		if(isServer) then{[_requestor,side player] execVM (BON_ARTI_PATH+"bon_arti_fire.sqf")}
		else{bon_arti_execution = [_requestor,side player]; publicVariable "bon_arti_execution";};
		arty_LastData = nil;
	};
};

if(true) exitWith{};