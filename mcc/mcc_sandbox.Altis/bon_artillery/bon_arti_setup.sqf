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

private ['_splashpos','_artitype','_artispread_value','_artispread'];

_requestor = player;
_dlg = findDisplay BON_ARTY_DIALOG;

// read out the dialog input
_spotter_xpos = (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_XRAYEDIT)) mod 100000;
_spotter_ypos = (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_YANKEEEDIT)) mod 100000;
_degrees = (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_DIRECTION)) mod 360;
_distance = abs (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_DISTANCE));
_height_disp = abs sliderPosition BON_ARTY_HEIGHT;
_firedelay = abs (parseNumber ctrlText (_dlg displayCtrl BON_ARTY_DELAYEDIT));
_x_correction = parseNumber ctrlText (_dlg displayCtrl BON_ARTY_XCORRECTION);
_y_correction = parseNumber ctrlText (_dlg displayCtrl BON_ARTY_YCORRECTION);

// resolve artillery type, -spread and nr shells
_artitype = (HW_arti_types select (lbCurSel BON_ARTY_TYPE)) select 1; 
_artispread = (HW_arti_spreads select (lbCurSel BON_ARTY_SPREAD)) select 0;
_artispread_value = (HW_arti_spreads select (lbCurSel BON_ARTY_SPREAD)) select 1;
_arty_nrshells = (lbCurSel BON_ARTY_NRSHELLS) + 1;

arty_LastData = [_spotter_xpos,_spotter_ypos,_degrees,_distance,_height_disp,_firedelay];

_splashpos = _requestor getVariable "Arti_adj_splashpos";
if(isNil "_splashpos") then{
	_splashpos = [_spotter_xpos,_spotter_ypos,_degrees,_distance,_height_disp] call arti_func_getSplashPos;
	if(_artispread_value == 0) then{
		_splashpos = [(_splashpos select 0) + 25 - random 50,(_splashpos select 1) + 25 - random 50,_splashpos select 2];
	};
} else {
	_modelpos = _requestor worldToModel _splashpos;
	_modelpos = [(_modelpos select 0) + _x_correction, (_modelpos select 1) + _y_correction, _modelpos select 2];
	_splashpos = _requestor modelToWorld _modelpos;
};

_arty_cannonsummary = format["\nPosition\nx-ray %1\nyankee %2\ndirection %3\ndistance %4m\nheight dispersion %5m\n\n\nCannon set with:\n\nRounds: %6\nShells: %7\nSpread: %8\n\nFiredelay: %9 seconds",
                           	_spotter_xpos,	// summary[0]
				_spotter_ypos,	// summary[1]
				_degrees,	// summary[2]
				_distance,	// summary[3]
				_height_disp,	// summary[4]
				_artitype,	// summary[5]
				_arty_nrshells,	// summary[6]
				_artispread,	// summary[7]
				_firedelay	// summary[8]
];
ctrlSetText [BON_ARTY_SUMMARY,_arty_cannonsummary];

// We reserve the cannons we want to have fired,
// and set the cannonspecific data.
_listbox = _dlg displayCtrl BON_ARTY_CANNONLIST;
_req_cannons = _requestor getVariable "requesting_cannons";
if(isNil "_req_cannons") then{_req_cannons = []};
{
	_shells2subtract = _requestor getVariable format["Arti_%2_Cannon%1",_x+1,playerSide];
	if(not isNil "_shells2subtract") then{
		_shells2subtract = _shells2subtract select 3;
		if(not isNil "arty_CurrNrShellsTotal") then{arty_CurrNrShellsTotal = arty_CurrNrShellsTotal - _shells2subtract};
	};
	arty_CurrNrShellsTotal = arty_CurrNrShellsTotal + _arty_nrshells;

	_req_cannons = (_req_cannons - [_x+1]) + [_x+1];
	_requestor setVariable ["requesting_cannons",_req_cannons,true];
	_requestor setVariable [format["Arti_%2_Cannon%1",_x+1,playerSide],[_splashpos,_firedelay,_artitype,_arty_nrshells,_artispread_value],true];
	_requestor setVariable [format["Arti_%2_Cannon%1Summary",_x+1,playerSide],_arty_cannonsummary,false];
} foreach lbSelection _listbox;

if(arty_CurrNrShellsTotal > (Server getVariable format["Arti_%1_shellsleft",playerSide])) then{
	ctrlEnable [BON_ARTY_REQUESTBUTTON,false];
	(_dlg displayCtrl BON_ARTY_SHELLSLEFT) ctrlSetTextColor [1,0,0,1];
} else{
	ctrlEnable [BON_ARTY_REQUESTBUTTON,true];
	(_dlg displayCtrl BON_ARTY_SHELLSLEFT) ctrlSetTextColor [1,1,1,1];
	_requestor setVariable ["Arti_adj_splashpos",nil,false];
};

if(true) exitWith{};