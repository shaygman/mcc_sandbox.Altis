#define MCC_FACTION 8008
MCC_mcc_screen = _this select 0;

if (MCC_faction_index != (lbCurSel MCC_FACTION)) then	{
	mcc_sidename = (U_FACTIONS select (lbCurSel MCC_FACTION)) select 1;
	mcc_faction = (U_FACTIONS select (lbCurSel MCC_FACTION)) select 2;
	MCC_faction_index = lbCurSel MCC_FACTION;
	[] call mcc_fnc_faction_choice;
};




