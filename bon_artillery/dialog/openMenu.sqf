// by Bon_Inf*

// First we register for the artillery.
// There won't be two units setting up arty at the same time for the same side.
/*
_arty_requestor = MCC_server getVariable format["Arti_%1_requestor",playerSide];
if(not (isNull _arty_requestor) && alive _arty_requestor && isPlayer _arty_requestor && not (player == _arty_requestor)) exitWith{[playerSide,"HQ"] sidechat format["Negative. %1 has registered for a fire mission already.",name _arty_requestor]; CloseDialog 0;};
*/
MCC_server setVariable [format["Arti_%1_requestor",playerSide],player,true];
/*
if(_arty_requestor != player) then{
	bon_arti_registration_message = [name player, playerSide];
	publicVariable "bon_arti_registration_message";
};
*/
_dlg = createDialog "ArtilleryDialog";