#define MCC_CONSOLE_UAV_MISSILE 9109

private ["_target","_source","_mode"];
disableSerialization;

if (MCC_ConsoleUAVmissiles > 0) then {
	MCC_ConsoleUAVmissiles = MCC_ConsoleUAVmissiles - 1;
	publicvariable "MCC_ConsoleUAVmissiles";
	MCC_ConsoleUAVmissilesArmed = true; 
	ctrlEnable [MCC_CONSOLE_UAV_MISSILE,false];
	};
