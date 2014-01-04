private ["_ok"];
disableSerialization;
MCC_mcc_screen= _this select 0;


closeDialog 0;
waituntil {!dialog};

MCC_GUIInitDone = false; 
switch (MCC_mcc_screen) do
{
    case 0:
   {_ok = createDialog "MCC_Sandbox";
 	if !(_ok) exitWith { hint "createDialog failed" };};
   case 1:
   { _ok = createDialog "MCC_Sandbox2";
	 if !(_ok) exitWith { hint "createDialog failed" };};
   case 2:
   { _ok = createDialog "MCC_Sandbox3";
	 if !(_ok) exitWith { hint "createDialog failed" };};
   case 3:
   { _ok = createDialog "MCC_Sandbox4";
	 if !(_ok) exitWith { hint "createDialog failed" };};
   case 4:
   { _ok = createDialog "MCC3D_Dialog";
	 if !(_ok) exitWith { hint "createDialog failed" };};
   case 5:
   { _ok = createDialog "mcc_groupGen";
	 if !(_ok) exitWith { hint "createDialog failed" };};
   case 6:
   { _ok = createDialog "MCC_Sandbox5";
	 if !(_ok) exitWith { hint "createDialog failed" };};
};
