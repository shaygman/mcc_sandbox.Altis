#define mcc_playerConsole3_IDD 5010

#define MCC_CONSOLE_AC_MISSILE_COUNT 5012
#define MCC_CONSOLE_AC_MISSILE_COUNT2 5019
#define MCC_CONSOLE_AC_MISSILE_COUNT3 5020

#define	 AMMO1 "gatling_20mm_VTOL_01"
#define	 AMMO2 "autocannon_40mm_VTOL_01"
#define	 AMMO3 "cannon_105mm_VTOL_01"

//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_pressed","_posX","_posY","_shift","_ctrlKey","_alt","_mccdialog","_control1","_control2","_control3","_ac","_center","_uav"];
disableSerialization;

_params = _this select 0;

_ctrl = _params select 0;
_pressed = _params select 1;
_posX = _params select 2;
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;

_ac = missionNamespace getVariable ["MCC_fakeAC",objNull];
_center = missionNamespace getVariable ["MCC_fakeACCenter",objNull];
_uav = missionNamespace getVariable ["MCC_ACConsoleUp",objNull];

if (isNull _ac || isNull _center || isNull _uav) exitWith {};

_mccdialog = findDisplay mcc_playerConsole3_IDD;
_control1 = _mccdialog displayCtrl MCC_CONSOLE_AC_MISSILE_COUNT;
_control2 = _mccdialog displayCtrl MCC_CONSOLE_AC_MISSILE_COUNT2;
_control3 = _mccdialog displayCtrl MCC_CONSOLE_AC_MISSILE_COUNT3;

//Control camera
if (_pressed==1) then {
	if (MCC_ConsoleACMouseButtonDown) then {
		MCC_ConsoleACMouseButtonDown = false;
	} else {
		setMousePosition [0.5,0.44];
		MCC_ConsoleACMouseButtonDown = true;
	};
};


/*
 ["20mm",_uav ammo "gatling_20mm_VTOL_01","4000Rnd_20mm_Tracer_Red_shells","B_20mm_Tracer_Red"],
							 ["40mm",_uav ammo "autocannon_40mm_VTOL_01","240Rnd_40mm_GPR_Tracer_Red_shells","B_40mm_GPR_Tracer_Red"],
							 ["105mm",_uav ammo "cannon_105mm_VTOL_01","100Rnd_105mm_HEAT_MP","Sh_105mm_HEAT_MP"]


gunner MCC_ACConsoleUp forceWeaponFire ["gatling_20mm_VTOL_01", "medium"];
gunner MCC_ACConsoleUp forceWeaponFire ["cannon_105mm_VTOL_01", "medium"];
gunner MCC_ACConsoleUp forceWeaponFire ["HE", "medium"];


							 */

//Fire
if (_pressed==0) then {
	MCC_consoleACmousebuttonUp = false;

	switch (MCC_ConsoleACweaponSelected) do {
		// 25mm
		case 0: {
			if (!MCC_consoleACgunReady1 || (_uav ammo "gatling_20mm_VTOL_01") <=0 ) exitwith {};
			while {!MCC_consoleACmousebuttonUp && (_uav ammo "gatling_20mm_VTOL_01") >0} do {
				MCC_consoleACgunReady1 = false;

				//Fire
				playSound "gun1";
				gunner _uav forceWeaponFire ["gatling_20mm_VTOL_01", "manual"];
				[_center, getpos _ac, "B_25mm",1500,1] execVM MCC_path + "mcc\general_scripts\console\ac_fire.sqf";

				//Update UI
				ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT, ("20mm: " + str (_uav ammo "gatling_20mm_VTOL_01"))];

				_control1 ctrlSetTextColor [1, 0, 0, 0.4];
				sleep 0.05;
				MCC_consoleACgunReady1 = true;
				_control1 ctrlSetTextColor [1, 1, 1, 1];
			};
		};

		// 40mm
		case 1: {
			if (!MCC_consoleACgunReady2 || (((crew _uav) select 3) ammo "HE") <=0 ) exitwith {};
			while {!MCC_consoleACmousebuttonUp && (((crew _uav) select 3) ammo "HE") >0} do {
				MCC_consoleACgunReady2 = false;

				//Fire
				playSound "gun2";
				_uav fire "HE";
				[_center, getpos _ac, "B_40mm_GPR_Tracer_Red",1500,1] execVM MCC_path + "mcc\general_scripts\console\ac_fire.sqf";

				//Update UI
				ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT2, ("40mm: " + str (((crew _uav) select 3) ammo "HE"))];

				_control2 ctrlSetTextColor [1, 0, 0, 0.4];
				sleep 0.5;
				MCC_consoleACgunReady2 = true;
				_control2 ctrlSetTextColor [1, 1, 1, 1];
			};
		};

		// 105mm
		case 2: {
			if (!MCC_consoleACgunReady3 || (_uav ammo "cannon_105mm_VTOL_01") <=0 ) exitwith {};
			MCC_consoleACgunReady3 = false;

			//Fire
			playSound "gun3";
			gunner _uav forceWeaponFire ["cannon_105mm_VTOL_01", "medium"];
			[_center, getpos _ac, "Sh_105mm_HEAT_MP",1500,1] execVM MCC_path + "mcc\general_scripts\console\ac_fire.sqf";

			//Update UI
			ctrlSetText [MCC_CONSOLE_AC_MISSILE_COUNT3, ("105mm: " + str (_uav ammo "cannon_105mm_VTOL_01"))];


			_control3 ctrlSetTextColor [1, 0, 0, 0.4];
			sleep 4;
			playSound "gunReload";
			sleep 2;
			MCC_consoleACgunReady3 = true;
			_control3 ctrlSetTextColor [1, 1, 1, 1];
		};
	};
};