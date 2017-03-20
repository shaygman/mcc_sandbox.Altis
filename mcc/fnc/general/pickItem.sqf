//===========================================================MCC_fnc_pickItem=============================================================================================
//  _objet = object (the picable object)
//======================================================================================================================================================================
private["_object", "_caller", "_index","_displayName","_text","_shared","_delete","_markers","_tittle"];
_object = param [0,objNull,[objNull]];
_caller =  param [1,objNull,[objNull]];
_index 	=  param [2,0,[0]];

if (isNull _object) exitWith {};

//Intel Text
_tittle = (_object getVariable ["MCC_intelObjectText",["",""]]) select 0;
_text = (_object getVariable ["MCC_intelObjectText",["",""]]) select 1;

//Intel Shared with
_shared = switch (_object getVariable ["MCC_intelObjectShared",0]) do
			{
				//Group
				case 0:	{0};
				case 1:	{group _caller};
				default	{side _caller};
			};

//Delete after
_delete = _object getVariable ["MCC_intelObjectDelete",true];

//Marker
_markers = _object getVariable ["MCC_intelObjectMarkerName",[]];

_displayName = getText(configFile >> "CfgVehicles" >> typeof _object >> "displayname");
_object removeaction _index;

//If it is a man then make subtitle
if (_object isKindOf "man") then {
	_delete = false;

	if !(_text isEqualTo "") then {
		[name _object,_text] remoteExec ["BIS_fnc_showSubtitle", _caller];
	};
} else {
	_caller playMoveNow "AinvPknlMstpSrasWrflDnon_Putdown_AmovPknlMstpSrasWrflDnon";
};

["intelAdded",[format ["%1 has acquired %2",name _caller,_displayName],"\A3\ui_f\data\map\markers\military\warning_ca.paa"]] remoteExec ["bis_fnc_showNotification", _shared];

//Add intel
if !(_text isEqualTo "") then {
	[[_tittle,_text,_markers], {
				params ["_tittle","_text","_markers"];

				//Add markers
				private _oldText = _text;
				{
					_text = _text + (format ["<marker name='%1'> Location</marker>", _x, _x]);
				} forEach _markers;

				_text = "<t size='1.0' font='PuristaBold'>" + _text +"</t>";

				if !(player diarysubjectexists "MCC_intel") then {
					player creatediarysubject ["MCC_intel","Mission's Intel"];
				};
				player creatediaryrecord ["MCC_intel",[_tittle,_text]];

				private _output =
				[
					[_tittle,"<t size='1.0' font='PuristaBold'>%1</t><br/>",2],
					[_oldText,"<t size='1.0' font='PuristaMedium'>%1</t><br/>",5]
				];

				[_output,safezoneX,0,"<t color='#FFFFFFFF' align='left'>%1</t>"] spawn BIS_fnc_typeText;
			}] remoteExec ["call", _shared];
};

//Hint we are done
missionNamespace setVariable ["MCC_pickItem",playerSide];
publicvariable "MCC_pickItem";

sleep 1;

//Delete after
if (_delete) then {
	deleteVehicle _object;
};

/*
_this  setVariable ["MCC_intelObjectText",["Baron Info","We have found out that the baron is hidding stash in his house to the north"]];
_this  setVariable ["MCC_intelObjectMarkerName",["marker1"]];
_this call MCC_fnc_pickItem;
*/