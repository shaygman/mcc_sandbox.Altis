//==================================================================MCC_fnc_releaseObject==============================================================================
//stop a dragging animation must be run local on the dragging unit
// Example: [] call MCC_fnc_releaseObject;
//===========================================================================================================================================================================
detach (player getVariable ["mcc_draggedObject", objNull]);
player playAction "released";
player removeEventHandler ["AnimStateChanged", player getVariable ["mcc_dragAnimEH",0]];
player forceWalk false;
sleep 2;
player setVariable ["mcc_draggedObject", objNull];

player removeAction (param [2,-1,[0,missionNamespace]]);