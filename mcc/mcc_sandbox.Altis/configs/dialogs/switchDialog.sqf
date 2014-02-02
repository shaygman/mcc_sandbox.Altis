private ["_ok"];
CP_screen= _this select 0;

closeDialog 0;
waituntil {!dialog};

switch (CP_screen) do
{
    case 0:
   {_ok = createDialog "CP_RESPAWNPANEL";
 	if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create respawn Dialog failed";};};
   case 1:
   { _ok = createDialog "CP_SQUADPANEL";
	 if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create group Dialog failed";};};
   case 2:
   { _ok = createDialog "CP_GEARPANEL";
	 if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create gear Dialog failed";};};
   case 3:
   { _ok = createDialog "CP_ACCESPANEL";
	 if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create accessory Dialog failed";};};
   case 4:
   { _ok = createDialog "CP_WEAPONSPANEL";
	 if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create weapon Dialog failed";};};
   case 5:
   { _ok = createDialog "CP_UNIFORMSPANEL";
	 if !(_ok) exitWith { hint "create Dialog failed"; diag_log  "CP: create uniforms Dialog failed";};};
};