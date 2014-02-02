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

private ['_splashpos'];

_requestor = player;
_dlg = findDisplay BON_ARTY_DIALOG;

arti_already_adjusting = true;

// read out the dialog input
_spotter_xpos = (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_XRAYEDIT)) mod 100000;
_spotter_ypos = (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_YANKEEEDIT)) mod 100000;
_degrees = (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_DIRECTION)) mod 360;
_distance = abs (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_DISTANCE));
_height_disp = abs sliderPosition BON_ARTY_HEIGHT;
_firedelay = abs (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_DELAYEDIT));
_x_correction = parseNumber ctrlText (_dlg displayCtrl BON_ARTY_XCORRECTION);
_y_correction = parseNumber ctrlText (_dlg displayCtrl BON_ARTY_YCORRECTION);

arty_LastData = [_spotter_xpos,_spotter_ypos,_degrees,_distance,_height_disp,_firedelay];

_splashpos = _requestor getVariable "Arti_adj_splashpos";
if(isNil "_splashpos") then{
	_splashpos = [_spotter_xpos,_spotter_ypos,_degrees,_distance,_height_disp] call arti_func_getSplashPos;
	_splashpos = [(_splashpos select 0) + 25 - random 50,(_splashpos select 1) + 25 - random 50,_splashpos select 2];
};

_modelpos = _requestor worldToModel _splashpos;
_modelpos = [(_modelpos select 0) + _x_correction, (_modelpos select 1) + _y_correction, _modelpos select 2];
_splashpos = _requestor modelToWorld _modelpos;
_requestor setVariable ["Arti_adj_splashpos",_splashpos,false];

closeDialog 0;

sleep (15 + random 5);
_adjustround = "G_40mm_SmokeRed" createVehicle [_splashpos select 0,_splashpos select 1,50];
sleep 10;
deleteVehicle _adjustround;
sleep 20;
arti_already_adjusting = false;

if(true) exitWith{};