//Made by Shay_Gman (c) 09.10
#define MCC_CONSOLEWPBCKGR 9157
#define MCC_CONSOLEWPCOMBO 9158
#define MCC_CONSOLEWPFORMATIONCOMBO 9166
#define MCC_CONSOLEWPSPEEDCOMBO 9167
#define MCC_CONSOLEWPBEHAVIORCOMBO 9168
#define MCC_CONSOLEWPADD 	9159
#define MCC_CONSOLEWPREPLACE 9160
#define MCC_CONSOLEWPCLEAR 9161
private ["_wp","_wpType","_groups","_wpFormation","_wpSpeed","_wpBehavior"];

_action 	= _this select 0;
_wpType 	= lbCurSel MCC_CONSOLEWPCOMBO;
_groups		= [];
_wpFormation = ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"] select (lbCurSel MCC_CONSOLEWPFORMATIONCOMBO);
_wpSpeed =  ["UNCHANGED", "LIMITED", "NORMAL", "FULL"] select (lbCurSel MCC_CONSOLEWPSPEEDCOMBO);
_wpBehavior = ["UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"] select (lbCurSel MCC_CONSOLEWPBEHAVIORCOMBO);

{
	if (MCC_ConsoleCanCommandAI || (!MCC_ConsoleCanCommandAI && isplayer leader _x)) then
		{
			_groups set [count _groups, _x];
		};
} foreach MCC_ConsoleGroupSelected;

//Call the server to handle WP
[[_action,MCC_ConsoleWPpos,[_wpType,"NO CHANGE",_wpFormation,_wpSpeed,_wpBehavior,"true","",0],_groups,true],"MCC_fnc_manageWp", false, false] spawn BIS_fnc_MP;

ctrlShow [MCC_CONSOLEWPBCKGR,false];
ctrlShow [MCC_CONSOLEWPCOMBO,false];
ctrlShow [MCC_CONSOLEWPFORMATIONCOMBO,false];
ctrlShow [MCC_CONSOLEWPSPEEDCOMBO,false];
ctrlShow [MCC_CONSOLEWPBEHAVIORCOMBO,false];
ctrlShow [MCC_CONSOLEWPADD,false];
ctrlShow [MCC_CONSOLEWPREPLACE,false];
ctrlShow [MCC_CONSOLEWPCLEAR,false];
