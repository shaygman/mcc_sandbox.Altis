private ["_ok"];
CP_screen= _this select 0;

closeDialog 0;
waituntil {!dialog};

switch (CP_screen) do {
    case 0:
   {_ok = createDialog "CP_RESPAWNPANEL";
 	if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create respawn Dialog failed";};};
   case 1:
   { _ok = createDialog "CP_GEARPANEL";
	 if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create gear Dialog failed";};};
};