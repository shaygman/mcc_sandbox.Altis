/*==================================== MCC_fnc_interactionMarkerCreate ==========================
	Attach items to players uniforms such as chemlights
	<IN>
		_text (_this select 0): 	STRING marker Name
		_pos (_this select 1):		ARRAY position of the marker
		_tittle (_this select 2):	STRING marker text

	<OUT>
		Nothing
===========================================================================================*/
private ["_markerName","_path","_radioSelf","_radioGlobal","_support"];
params ["_text","_pos","_tittle"];
_support = param [3,false,[false]];

//Create marker
_markerName = (getplayerUID player) + _text + str floor time;

if (_support) then {

	_path = "";

	switch (_tittle) do {
	    case "Need CAS": {
	    	_radioSelf = "SentSupportRequestRGCASHelicopter";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_casrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_casrequested_IHQ_%1",floor random 3]};
	    };

	    case "Need Transport": {
	    	_radioSelf = "SentSupportRequestRGTransport";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_transportrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_transportrequested_IHQ_%1",floor random 3]};
	    };

	    case "Need Artillery": {
	    	_radioSelf = "SentSupportRequestRGArty";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_casrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_casrequested_IHQ_%1",floor random 3]};
	    };

	    case "Need Medic": {
	    	_radioSelf = "SentSupportAskHeal";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_medevacrequested_BHQ_0%1",floor random 3]} else {format["mp_groundsupport_01_medevacrequested_IHQ_0%1",floor random 3]};
	    };

	    case "Need Ammo": {
	    	_radioSelf = "SentSupportAskRearm";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]};
	    };

	    case "Need Repairs": {
	    	_radioSelf = "SentSupportAskRepair";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]};
	    };

	    case "Need Fuel": {
	     	_radioSelf = "SentSupportAskRefuel";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]};
	    };

	    case "Defend": {
	    	_radioSelf = "SentGenCmdDefend";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_playerbriefing_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_playerbriefing_IHQ_%1",floor random 3]};
	    };

	     case "Attack": {
	     	_radioSelf = "SentGenCmdSeize";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_playerbriefing_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_playerbriefing_IHQ_%1",floor random 3]};
	    };

	    default {
	     	_radioSelf = "SentARTYFireAtWithAmmo";
	    	_radioGlobal = if (side player == west) then {format["mp_groundsupport_01_playerbriefing_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_playerbriefing_IHQ_%1",floor random 3]};
	    };
	};

	player globalRadio _radioSelf;

	//broadcast
	[[player,_radioGlobal] ,"MCC_fnc_radioSupport", playerside,false] call BIS_fnc_MP;
} else {

	if (_text == "MinefieldAP") then {
		_path = "";
		_text = "";
	} else {
		if (playerside == east) then {_path = "b_"} else {_path = "o_"};
	};
};


if (_pos distance player < 2500) then {
	player globalRadio "SentEnemyDetectedClose";
	[[_markerName, _path, _pos, _text,_tittle, time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;
} else {
	player globalRadio "SentNoTarget";
};