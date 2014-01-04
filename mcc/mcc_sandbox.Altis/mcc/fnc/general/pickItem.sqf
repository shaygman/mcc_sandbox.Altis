//==================================================================MCC_fnc_time2string===============================================================================================
//  _objet = object (the picable object)
//==================================================================================================================================================================================
private["_object", "_caller", "_index","_displayName"];
_object = _this select 0;
_caller = _this select 1;
_index 	= _this select 2;

_displayName = getText(configFile >> "CfgVehicles" >> typeof _object >> "displayname"); 

_object removeaction _index;
_caller playMove "AinvPknlMstpSrasWrflDnon_Putdown_AmovPknlMstpSrasWrflDnon"; 
 [[format ["%1 has acquired %2",name _caller,_displayName]],'MCC_fnc_globalHint',true,true] spawn BIS_fnc_MP;
 call compile "MCC_pickItem= true";
publicvariable "MCC_pickItem"; 

sleep 1; 
deleteVehicle _object;