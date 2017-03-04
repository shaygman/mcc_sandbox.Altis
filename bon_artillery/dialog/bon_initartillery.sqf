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
private ["_newArray","_vehicle","_isArty","_cannon","_displayName","_index","_realCannons","_isCommander"];

//is the player the commander or just using the artillery computer
_isCommander = ((MCC_server getVariable [format ["CP_commander%1",side player],""]) == getPlayerUID player) or ("MCC_itemConsole" in (assignedItems player));

//Clear stuff
player setVariable ["requesting_cannons",[]];
player setVariable ["requesting_cannonsReal",[]];

arty_Type = 0;
arty_NrShells = 1;
arty_Spread = 0;
arty_CurrNrShellsTotal = 0;
arty_xcorrection = 0;
arty_ycorrection = 0;

if (isnil "arti_already_adjusting") then {arti_already_adjusting = false};
_artidialog = findDisplay BON_ARTY_DIALOG;

_shellsleft = MCC_server getVariable format["Arti_%1_shellsleft",side player];
if (isNil "_shellsleft" || !_isCommander) then {_shellsleft = 0};
ctrlSetText [BON_ARTY_SHELLSLEFT,format["Shells left: %1",_shellsleft]];
ctrlSetText [BON_ARTY_XRAY,format["x-ray: %1",round (getPos player select 0)]];
ctrlSetText [BON_ARTY_YANKEE,format["yankee: %1",round (getPos player select 1)]];

_ctrlListBox = _artidialog displayCtrl BON_ARTY_CANNONLIST;
lbClear _ctrlListBox;

if (_isCommander) then
{
	//Get real art pieces
	_realCannons = [];
	{
		_vehicle = vehicle _x;
		_isArty= if ((getNumber (configfile >> "CfgVehicles" >> typeof _vehicle >> "artilleryScanner")) == 0) then {false} else {true};
		if (_vehicle != _x && _isArty && alive _vehicle && _x == gunner _vehicle && side _x == side player && (isplayer _x || (!isplayer _x && group _x getvariable ["MCC_canbecontrolled",false]))) then
		{
			_realCannons set [count _realCannons, _x];
		};
	} foreach allUnits;

	MCC_bonCannons = [];
	//Load cannons
	for "_i" from 1 to (HW_Arti_CannonNumber + count _realCannons)  do
	{
		//Virtual cannon
		if (_i <= HW_Arti_CannonNumber) then
		{
			_index = _ctrlListBox lbAdd format["Cannon %1",_i];
			MCC_bonCannons set [_index, objNull];
			_ctrlListBox lbsetData [_index, "vr"];
			_cannon_available = MCC_server getVariable format["Arti_%2_Cannon%1_available",_i,side player];
			if(not _cannon_available) then{_ctrlListBox lbSetColor [_i-1,[1.0, 0.35, 0.3, 1]];};

			[_i,_ctrlListBox] spawn
			{
				disableSerialization;
				_cannon2update = _this select 0;
				_ctrlListBox = _this select 1;

				While{sleep 1; dialog} do
				{
					_cannon_available = MCC_server getVariable format["Arti_%2_Cannon%1_available",_cannon2update,side player];
					if(_cannon_available) then{_ctrlListBox lbSetColor [_cannon2update-1,[1, 1, 1, 1]]};
				};
			};
		}
		//real cannon
		else
		{
			_cannon = _realCannons select (_i-HW_Arti_CannonNumber-1);
			_displayName = getText (configfile >> "CfgVehicles" >> typeof (vehicle _cannon) >> "displayName");
			_index = _ctrlListBox lbAdd format["%1 (%2)", _displayName, name _cannon];
			MCC_bonCannons set [_index, _cannon];
			_ctrlListBox lbsetData [_index, typeof (vehicle _cannon)];

			[_i,_ctrlListBox,_cannon] spawn
			{
				disableSerialization;
				_cannon2update = _this select 0;
				_ctrlListBox = _this select 1;
				_cannon = _this select 2;

				While{sleep 1; dialog} do
				{
					if(!alive _cannon || vehicle _cannon == _cannon) then{_ctrlListBox lbSetColor [_cannon2update-1,[1, 1, 1, 1]]};
				};
			};
		};
	};

	[] spawn
		{
			while{dialog} do
			{
				if(arti_already_adjusting) then{
					ctrlEnable [BON_ARTY_ADJUSTBUTTON, false];
				} else {
					ctrlEnable [BON_ARTY_ADJUSTBUTTON, true];
				};
				sleep 1;
			};
		};
}
else
{
	//Hide controls
	for "_i" from 0 to 4 do {ctrlShow [_i,false]};
	//Get real art pieces
	_cannon = vehicle player;
	_displayName = getText (configfile >> "CfgVehicles" >> typeof (vehicle _cannon) >> "displayName");
	_index = _ctrlListBox lbAdd format["%1 (%2)", _displayName, name _cannon];
	MCC_bonCannons set [_index, _cannon];
	_ctrlListBox lbsetData [_index, typeof (vehicle _cannon)];
	_ctrlListBox lbSetCurSel 0;
	_ctrlListBox lbSetSelected [0,true];
};


_comboBox = _artidialog displayCtrl BON_ARTY_NRSHELLS;
lbClear _comboBox;
for "_i" from 1 to HW_arti_maxnrshells do {
	_comboBox lbAdd str _i
};
_comboBox lbSetCurSel 0;

_comboBox = _artidialog displayCtrl BON_ARTY_SPREAD;
lbClear _comboBox;
{
	_displayname = _x select 0;
	_comboBox lbAdd _displayname;
} foreach HW_arti_spreads;
_comboBox lbSetCurSel 0;

_comboBox = _artidialog displayCtrl BON_ARTY_MISSIONTYPE;
lbClear _comboBox;
{
	_displayname = _x;
	_comboBox lbAdd _displayname;
} foreach ["FOR EFFECT","ADJUSTMENT"];
_comboBox lbSetCurSel 0;

sliderSetRange [BON_ARTY_HEIGHT,-50,0];
sliderSetPosition [BON_ARTY_HEIGHT,0];

[] spawn
{
	While{sleep 0.12; dialog} do{
		ctrlSetText [BON_ARTY_HEIGHTINDEX,format["%1m",round abs sliderPosition BON_ARTY_HEIGHT]];
	};
};

if(not isNil "arty_LastData") then
{
	_req_cannons = player getVariable "requesting_cannons";
	ctrlSetText [BON_ARTY_XRAYEDIT,format["%1",arty_LastData select 0]]; //xpos
	ctrlSetText [BON_ARTY_YANKEEEDIT,format["%1",arty_LastData select 1]]; //ypos
	ctrlSetText [BON_ARTY_DIRECTION,format["%1",arty_LastData select 2]]; //degrees
	ctrlSetText [BON_ARTY_DISTANCE,format["%1",arty_LastData select 3]]; //distance
	sliderSetPosition [BON_ARTY_HEIGHT,(arty_LastData select 4)*-1]; //height_disp
	ctrlSetText [BON_ARTY_DELAYEDIT,format["%1",arty_LastData select 5]]; //firedelay
};