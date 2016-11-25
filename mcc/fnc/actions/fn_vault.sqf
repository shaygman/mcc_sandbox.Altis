//==================================================================MCC_fnc_vault===============================================================================================
//Vault over an obstacle
// Example: [] call MCC_fnc_vault;
//===========================================================================================================================================================================
private ["_endPos","_hight","_startAnim","_endAnim"];
_hight = player getVariable ["MCC_wallAhead",""];

player SetVariable ["MCC_vaultOver",true];

switch (_hight) do
{
	case "low":
	{
		_startAnim = "amovpercmstpsnonwnondnon_acrgpknlmstpsnonwnondnon_getinmedium";
		_endAnim = "AcrgPknlMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon_getOutMedium";
	};

	case "high":
	{
		_startAnim = "getinhemttback";
		_endAnim = "AcrgPknlMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon_getOutHigh";
	};
};

_endPos = player modelToworld [0,2.5,0];
player setpos (player modelToworld [0,-0.2,0]);
//player switchmove _startAnim;
[[player, _startAnim, true, 0], "MCC_fnc_setUnitAnim", true, false] call BIS_fnc_MP;
sleep 1;
waituntil {(animationState player) != _startAnim};
player setpos _endPos;
//player switchMove _endAnim;
[[player, _endAnim, true, 0], "MCC_fnc_setUnitAnim", true, false] call BIS_fnc_MP;
sleep 1;
player SetVariable ["MCC_vaultOver",false];
player setVariable ["MCC_wallAhead",""];