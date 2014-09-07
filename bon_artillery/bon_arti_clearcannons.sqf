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

_dlg = findDisplay BON_ARTY_DIALOG;
_listbox = _dlg displayCtrl BON_ARTY_CANNONLIST;

_requestor = player;

//Clear VR	
_req_cannons = player getVariable ["requesting_cannons",[]];
_cannons_to_clear = _req_cannons;
_cannons_cleared = [];
{
	_cannons_to_clear = _cannons_to_clear - [_x+1];
	_cannons_cleared = _cannons_cleared + [_x+1];

	_old_conf = _requestor getVariable format["Arti_%2_Cannon%1",_x+1,side player];
	if(not isNil "_old_conf") then{
		_old_shells = _old_conf select 3;
		arty_CurrNrShellsTotal = arty_CurrNrShellsTotal - _old_shells;
	};

	_requestor setVariable [format["Arti_%2_Cannon%1Summary",_x+1,side player],nil,false];
	_requestor setVariable [format["Arti_%2_Cannon%1",_x+1,side player],nil,true];
} foreach lbSelection _listbox;
_requestor setVariable ["requesting_cannons",_cannons_to_clear,true];

//Clear Real	
_req_cannons = player getVariable ["requesting_cannonsReal",[]];
_cannons_to_clear = _req_cannons;
_cannons_cleared = [];
{
	_cannons_to_clear = _cannons_to_clear - [_x+1];
	_cannons_cleared = _cannons_cleared + [_x+1];

	_old_conf = _requestor getVariable format["Arti_%2_Cannon%1",_x+1,side player];
	if(not isNil "_old_conf") then{
		_old_shells = _old_conf select 3;
		arty_CurrNrShellsTotal = arty_CurrNrShellsTotal - _old_shells;
	};

	_requestor setVariable [format["Arti_%2_Cannon%1Summary",_x+1,side player],nil,false];
	_requestor setVariable [format["Arti_%2_Cannon%1",_x+1,side player],nil,true];
} foreach lbSelection _listbox;
_requestor setVariable ["requesting_cannonsReal",_cannons_to_clear,true];

ctrlSetText [BON_ARTY_SUMMARY,format["\n\nCannons %1 resetted.",_cannons_cleared]];

if(arty_CurrNrShellsTotal > (MCC_server getVariable format["Arti_%1_shellsleft",side player])) then{
	ctrlEnable [BON_ARTY_REQUESTBUTTON,false];
	(_dlg displayCtrl BON_ARTY_SHELLSLEFT) ctrlSetTextColor [1,0,0,1];
} else{
	ctrlEnable [BON_ARTY_REQUESTBUTTON,true];
	(_dlg displayCtrl BON_ARTY_SHELLSLEFT) ctrlSetTextColor [1,1,1,1];
};

if(true) exitwith{};