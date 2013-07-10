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

_correctionunit = 1;  // amount of metres set by clicking on the arrows

switch _this do {
	case "Left" : {
		arty_xcorrection = arty_xcorrection - _correctionunit;
		ctrlSetText [BON_ARTY_XCORRECTION, str arty_xcorrection];
	};
	case "Right" : {
		arty_xcorrection = arty_xcorrection + _correctionunit;
		ctrlSetText [BON_ARTY_XCORRECTION, str arty_xcorrection];
	};
	case "Down" : {
		arty_ycorrection = arty_ycorrection - _correctionunit;
		ctrlSetText [BON_ARTY_YCORRECTION, str arty_ycorrection];
	};
	case "Up" : {
		arty_ycorrection = arty_ycorrection + _correctionunit;
		ctrlSetText [BON_ARTY_YCORRECTION, str arty_ycorrection];
	};
};


if(true) exitWith{};