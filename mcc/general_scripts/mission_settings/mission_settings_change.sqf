//Made by Shay_Gman (c) 09.11

while {dialog} do {closeDialog 0};

private _logic = "logic" createVehiclelocal [0,0,0];

switch (_this select 0) do
{
	case 0:	{[_logic] spawn MCC_fnc_missionSettings};
	case 1:	{[_logic] spawn MCC_fnc_inGameUICurator};
	case 2:	{[_logic] spawn MCC_fnc_settingsCover};
	case 3:	{[_logic] spawn MCC_fnc_settingsMedical};
	case 4:	{[_logic] spawn MCC_fnc_missionSettingsRS};
	case 5:	{[_logic] spawn MCC_fnc_GAIASettings};
};