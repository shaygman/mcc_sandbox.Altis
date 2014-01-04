#define mcc_playerConsole3_IDD 5010

#define MCC_CONSOLE_AC_MISSILE_COUNT 5012
#define MCC_CONSOLE_AC_MISSILE_COUNT2 5019
#define MCC_CONSOLE_AC_MISSILE_COUNT3 5020
//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_mccdialog","_control1","_control2","_control3"];
disableSerialization;
 
_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2; 
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;


_mccdialog = findDisplay mcc_playerConsole3_IDD;
_control1 = _mccdialog displayCtrl MCC_CONSOLE_AC_MISSILE_COUNT;
_control2 = _mccdialog displayCtrl MCC_CONSOLE_AC_MISSILE_COUNT2;
_control3 = _mccdialog displayCtrl MCC_CONSOLE_AC_MISSILE_COUNT3;

if (_pressed==1) then //Control camera
	{
		MCC_ACPos = [0.5,0.44];
		if (MCC_ConsoleACMouseButtonDown) then {MCC_ConsoleACMouseButtonDown = false} else {
			setMousePosition [0.5,0.44];MCC_ConsoleACMouseButtonDown = true};
	};

if (_pressed==0) then //Fire
	{
		MCC_consoleACmousebuttonUp = false; 
		switch (MCC_ConsoleACweaponSelected) do {
			// 25mm
			case 0: {
				if (!MCC_consoleACgunReady1 || (MCC_ConsoleACAmmo select 0) <=0 ) exitwith {}; 
				while {!MCC_consoleACmousebuttonUp && (MCC_ConsoleACAmmo select 0) >0} do {
					MCC_consoleACgunReady1 = false;
					MCC_ConsoleACAmmo set [0, (MCC_ConsoleACAmmo select 0)-1];
					ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT, format ["25mm: %1",MCC_ConsoleACAmmo select 0]];
					playSound "gun1";
					[[[netid MCC_fakeAC,MCC_fakeAC], "gun1"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
					[MCC_fakeACCenter, getpos MCC_fakeAC, "B_19mm_HE",1000,1] execVM MCC_path + "mcc\general_scripts\console\ac_fire.sqf";
					_control1 ctrlSetTextColor [1, 0, 0, 0.4];
					sleep 0.15;
					MCC_consoleACgunReady1 = true;
					_control1 ctrlSetTextColor [1, 1, 1, 1];
				};
			};
			
			// 40mm
			case 1: {
				if (!MCC_consoleACgunReady2 || (MCC_ConsoleACAmmo select 1) <=0 ) exitwith {}; 
				while {!MCC_consoleACmousebuttonUp && (MCC_ConsoleACAmmo select 1) >0} do {
					MCC_consoleACgunReady2 = false;
					MCC_ConsoleACAmmo set [1, (MCC_ConsoleACAmmo select 1)-1];
					ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT2, format ["40mm: %1",MCC_ConsoleACAmmo select 1]];
					playSound "gun2";
					[[[netid MCC_fakeAC,MCC_fakeAC], "gun2"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
					[MCC_fakeACCenter, getpos MCC_fakeAC, "G_40mm_HE",1000,1] execVM MCC_path + "mcc\general_scripts\console\ac_fire.sqf";
					_control2 ctrlSetTextColor [1, 0, 0, 0.4];
					sleep 0.5;
					MCC_consoleACgunReady2 = true;
					_control2 ctrlSetTextColor [1, 1, 1, 1];
				};
			};
			
			// 105mm
			case 2: {
				if (!MCC_consoleACgunReady3 || (MCC_ConsoleACAmmo select 2) <=0 ) exitwith {}; 
				MCC_consoleACgunReady3 = false;
				MCC_ConsoleACAmmo set [2, (MCC_ConsoleACAmmo select 2)-1];
				ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT3, format ["105mm: %1",MCC_ConsoleACAmmo select 2]];
				playSound "gun3";
				[[[netid MCC_fakeAC,MCC_fakeAC], "gun3"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
				[MCC_fakeACCenter, getpos MCC_fakeAC, "Bo_Mk82",1000,1] execVM MCC_path + "mcc\general_scripts\console\ac_fire.sqf";
				_control3 ctrlSetTextColor [1, 0, 0, 0.4];
				sleep 4;
				playSound "gunReload";
				sleep 2;
				MCC_consoleACgunReady3 = true;
				_control3 ctrlSetTextColor [1, 1, 1, 1];
			};
		};
	};
