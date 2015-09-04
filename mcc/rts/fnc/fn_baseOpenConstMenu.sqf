//=================================================================MCC_fnc_baseOpenConstMenu==============================================================================
//	What happened when clicking on a base's building action
//  Parameter(s):
//     _center: POSITION
//     _radius: INTEGER
//==============================================================================================================================================================================
private ["_disp"];
disableSerialization;
_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

//Hide upgrades
for "_i" from 9160 to 9163 do
{
	(_disp displayCtrl _i) ctrlShow false;
};

//Hide actions
for "_i" from 9101 to 9112 do
{
	(_disp displayCtrl _i) ctrlShow false;
};