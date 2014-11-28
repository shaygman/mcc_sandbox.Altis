private ["_disp","_pressed","_shift","_ctrlKey","_alt","_selectedGroup"];
#define MCC_CONSOLEINFOTEXT 9150
#define MCC_CONSOLEINFOLIVEFEED 9151
#define MCC_CONSOLEINFOUAVCONTROL 9162

#define MCC_CONSOLEWPBCKGR 9157
#define MCC_CONSOLEWPCOMBO 9158
#define MCC_CONSOLEWPADD 	9159
#define MCC_CONSOLEWPREPLACE 9160
#define MCC_CONSOLEWPCLEAR 9161
#define MCC_ConsoleMapRulerDir 9164
#define MCC_ConsoleMapRulerDis 9165

disableSerialization;
 
_disp = _this select 0;
_pressed = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;

if !(_pressed in [2,3,4,5,6,7,8,9,10,11]) exitWith {};
//hint str _this; 

//assign group to a number
if (_ctrlKey && _pressed == 2) then {MCC_ConsoleGroups1 = MCC_ConsoleGroupSelected}; //1
if (_ctrlKey && _pressed == 3) then {MCC_ConsoleGroups2 = MCC_ConsoleGroupSelected}; //2
if (_ctrlKey && _pressed == 4) then {MCC_ConsoleGroups3 = MCC_ConsoleGroupSelected}; //3
if (_ctrlKey && _pressed == 5) then {MCC_ConsoleGroups4 = MCC_ConsoleGroupSelected}; //4
if (_ctrlKey && _pressed == 6) then {MCC_ConsoleGroups5 = MCC_ConsoleGroupSelected}; //5
if (_ctrlKey && _pressed == 7) then {MCC_ConsoleGroups6 = MCC_ConsoleGroupSelected}; //6
if (_ctrlKey && _pressed == 8) then {MCC_ConsoleGroups7 = MCC_ConsoleGroupSelected}; //7
if (_ctrlKey && _pressed == 9) then {MCC_ConsoleGroups8 = MCC_ConsoleGroupSelected}; //8
if (_ctrlKey && _pressed == 10) then {MCC_ConsoleGroups9 = MCC_ConsoleGroupSelected}; //9
if (_ctrlKey && _pressed == 11) then {MCC_ConsoleGroups10 = MCC_ConsoleGroupSelected}; //0

//select group from a number
if (((_pressed >= 2) && (_pressed <=11)) && !_shift && !_ctrlKey && !_alt && !isnil "MCC_ConsoleGroupSelected") then
	{
		{_x removeGroupIcon (_x getvariable "MCCgroupIconDataSelected")} foreach MCC_ConsoleGroupSelected;
		_selectedGroup = call compile format ["MCC_ConsoleGroups%1",_pressed -1];
		MCC_ConsoleGroupSelected = []; 
		{
			MCC_ConsoleGroupSelected set [count MCC_ConsoleGroupSelected, _x];
			_icon = _x addGroupIcon ["selector_selectedFriendly",[0,0]];
			_x setvariable ["MCCgroupIconDataSelected",_icon,false]; 
		} foreach _selectedGroup;
	};

true; 