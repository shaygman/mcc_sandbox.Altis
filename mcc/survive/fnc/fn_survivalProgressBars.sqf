/*=================================================================MCC_fnc_survivalProgressBars===============================================================================
	Handles survivals progress bars
*/
if ((missionNamespace getVariable ["MCC_isLocalHC",false]) || !hasInterface) exitWith {};

private ["_ctrl"];

while {(missionNamespace getVariable ["MCC_surviveMod",false])} do 	{

	waitUntil {time > 10};
	waituntil {!(isnull (finddisplay 602))};

	disableSerialization;

	//Create progress bar
	(["mcc_rscSurviveStats"] call BIS_fnc_rscLayer) cutRsc ["mcc_rscSurviveStats", "PLAIN"];

	_ctrl = (uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 1;
	_ctrl progressSetPosition ((player getVariable ["MCC_calories",4000])/4000);

	_ctrl = (uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 2;
	_ctrl progressSetPosition ((player getVariable ["MCC_water",200])/200);

	//Is sick
	if (player getVariable ["MCC_surviveIsSick",false]) then {((uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 3) ctrlSetText "Sick"};

	if (missionNamespace getVariable ["MCC_surviveMod",false]) then {

		{
			((findDisplay 602) displayCtrl _x) ctrlSetEventHandler ["LBDblClick", "_this call MCC_fnc_handleInventoryClick"];
		} forEach [638,633,619,640];

		{
			((findDisplay 602) displayCtrl _x) ctrlSetEventHandler ["MouseButtonDblClick", "_this call MCC_fnc_handleInventoryClick"];
		} forEach [6191,6238,6216,612,630,628,629,6240,610,622,620,621,641,611,6331,6381,6217];
	};

	waituntil {isnull (finddisplay 602)};

	//Close bars
	(["mcc_rscSurviveStats"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];


	sleep 1;
};