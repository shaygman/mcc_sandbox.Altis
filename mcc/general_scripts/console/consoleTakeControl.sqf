private ["_uav"];

if (isnil "MCC_ConolseUAV") exitWith {};
if (!alive MCC_ConolseUAV) exitWith {};

while {dialog} do {closeDialog 0};

_uav = MCC_ConolseUAV;
player action ["SwitchToUAVGunner",_uav];

/*
player remoteControl gunner _uav;
gunner _uav switchCamera "Internal";
player remoteControl gunner _uav;
*/