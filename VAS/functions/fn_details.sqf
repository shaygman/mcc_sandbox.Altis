#ifdef MCCMODE
 #include "\mcc_sandbox_mod\VAS\functions\macro.sqf"
#else
 #include "macro.sqf"
#endif
/*
	@version: 1.3
	@file_name: fn_details.sqf
	@file_author: TAW_Tonic
	@file_edit: 6/22/2013
	@file_description: Displays details about the weapon mainly magazines.
*/
disableSerialization;
if((uiNamespace getvariable "VAS_UI_FILTER") != "guns" && !(uiNamespace getVariable "VAS_UI_QuickMag")) exitWith {call VAS_fnc_closeDetails;}; //Filter not on guns? exit
private["_control","_data","_control","_magazines","_details","_items"];
_control = _this select 0;
if(isNil {_control}) exitWith {call VAS_fnc_closeDetails;};
if((_this select 1) == -1) exitWith {call VAS_fnc_closeDetails;};
_data = (_control lbData (_this select 1));

_details = [_data] call VAS_fnc_fetchCfgDetails;
if(count _details == 0) exitWith {call VAS_fnc_closeDetails;}; //No info? Exit
if(!((_details select 4) in [1,2,4,5,4096])) exitWith {call VAS_fnc_closeDetails;}; //Not a gun? Exit
if(count (_details select 7) == 0) exitwith {call VAS_fnc_closeDetails;}; //No mags? Exit
_magazines = (_details select 7);
(VAS_getControl(VAS_Main_Display,VAS_detail_mags)) ctrlSetStructuredText parseText format["<t align='center'>%1</t>",(_details select 1)];
_control = VAS_getControl(VAS_Main_Display,VAS_detail_mags_list);
lbClear _control;

{
	_tmp = [_x,"CfgMagazines"] call VAS_fnc_fetchCfgDetails;
	if(count _tmp > 0) then
	{
		_control lbAdd format["%1", (_tmp select 1)];
		_control lbSetData [(lbSize _control)-1,_x];
		_control lbSetPicture [(lbSize _control)-1,(_tmp select 2)];
	};
} foreach _magazines;

_items = [_data] call VAS_fnc_accList;

_control = ((findDisplay 2500) displayCtrl 2851);
lbClear _control;

if(count _items > 0) then {
	{
		_cfgInfo = [_x,"CfgWeapons"] call VAS_fnc_fetchCfgDetails;
		_control lbAdd format["%1", _cfgInfo select 1];
		_control lbSetData [(lbSize _control)-1,_x];
		_control lbSetPicture [(lbSize _control)-1,_cfgInfo select 2];
	} foreach _items;
	ctrlShow[VAS_AccBG,true];
	ctrlShow[VAS_AccList,true];
} else {
	ctrlShow[VAS_AccBG,false];
	ctrlShow[VAS_AccList,false];
};

call VAS_fnc_openDetails;