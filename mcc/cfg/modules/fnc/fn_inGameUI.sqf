/*==================================================================MCC_fnc_inGameUI=====================================================================================
	manage inGameUI
	[0,true,true,trur,true,false,true] call MCC_fnc_inGameUI
	<IN>
	_this select 0 		INTEGER - 3D view
							-1 Disabled
							0 force always
							1 allow 3d all vehicles
							2 allow 3d air only

	_this select 1		BOOLEAN Compass
							true - enable HUD compass
							false - disable HUD compass

	_this select 2		BOOLEAN Show teamate on compass
							true - enable HUD compass show teammates
							false - disable HUD compass show teammates

	_this select 3		BOOLEAN Show group markers on map
							true - enable Group Markers on map
							false - disable Group Markers on map

	_this select 4		BOOLEAN	Show indevidual markers on map
							true - enable Indivdual Markers on map
							false - disable Indivdual Markers on map

	_this select 5		BOOLEAN
							false - disable Name Tags
							true - enable Name Tags only when pointing on unit
							2 - enable Name Tags around the player


	_this select 6		BOOLEAN
							true - enable suppression
							false - disable suppression

	<<<<<<<<<<<         LOCAL Function     >>>>>>>>>>>>>>>>>>>>>>>>>>>

==============================================================================================================================================================*/
private ["_mode","_compass","_compassTeamMates","_module"];
_mode = param [0,3,[0,objNull]];

//If it's a mod not a call
if (typeName _mode == typeName objNull) then {
	_module = _mode;
	_mode = _module getVariable ["mode",3];
	_compass = _module getVariable ["compass",false];
	_compassTeamMates = _module getVariable ["compassTeamMates",false];

	//Group Markers
	missionNamespace setVariable ["MCC_groupMarkers",_module getvariable ["groupMarkers",true]];

	//Indevidual Markers
	missionNamespace setVariable ["MCC_indevidualMarkers",_module getvariable ["indevidualMarkers",false]];

	//NameTags
	missionNamespace setVariable ["MCC_nameTags",(_module getvariable ["nameTags",0])>1];
	missionNamespace setVariable ["MCC_NameTags_direct",!((_module getvariable ["nameTags",0])==2)];

	//Supression
	missionNamespace setVariable ["MCC_suppressionOn",_module getvariable ["suppression",false]];

	//Hit Radar
	missionNamespace setVariable ["MCC_hitRadar",_module getvariable ["hitRadar",false]];

	//Tickets
	missionNamespace setVariable ["MCC_UIModuleTickets",_module getvariable ["tickets",false]];

	//Tutorials
	if (_module getvariable ["tutorials",false]) then {
		0 spawn MCC_fnc_helpersInit;
	};

} else {
	_compass = param [1,true,[false]];
	_compassTeamMates = param [2,true,[false]];

	//Group Markers
	missionNamespace setVariable ["MCC_groupMarkers",param [3,true,[false]]];

	//Indevidual Markers
	missionNamespace setVariable ["MCC_indevidualMarkers",param [4,true,[false]]];

	//NameTags
	missionNamespace setVariable ["MCC_nameTags",param [5,true,[false]]];

	//NameTags Direct
	missionNamespace setVariable ["MCC_NameTags_direct",param [6,true,[false]]];

	//Supression
	missionNamespace setVariable ["MCC_suppressionOn",param [7,true,[false]]];

	//Hit Radar
	missionNamespace setVariable ["MCC_hitRadar",param [8,true,[false]]];

	//Tickets
	missionNamespace setVariable ["MCC_UIModuleTickets",param [9,true,[false]]];

	//Tutorials
	if (param [10,false,[false]]) then {
		0 spawn MCC_fnc_helpersInit;
	};
};

//Compass HUD
if (_compass) then {_compassTeamMates spawn MCC_fnc_initCompassHUD};

//Supression
if (missionNamespace getVariable ["MCC_suppressionOn",false]) then {[] spawn MCC_fnc_supressionInit};

//Force Camera
player setVariable ["MCC_forceCameraMode",_mode];

[] spawn {

	if (missionNamespace getVariable ["MCC_forceCamera",false]) exitWith {};

	missionNamespace setVariable ["MCC_forceCamera",true];

	while {true} do {

		waitUntil {cameraView == "External"};

		switch (player getVariable ["MCC_forceCameraMode",3]) do {

			//Always
		    case 0: {
		    	player switchCamera "Internal";
		    };

		    //vehicles
		    case 1: {
		    	if (vehicle player == player) then {player switchCamera "Internal"};
		    };

		    case 2: {
		     	if (!(vehicle player isKindOf "air") ) then {player switchCamera "Internal"};
		    };
		};

		sleep 0.1;
	};

	missionNamespace setVariable ["MCC_forceCamera",false];
};

//Tickets	- Move to function
[] spawn {
	disableSerialization;
	private ["_tickets","_ctrlPos","_flagTexture","_unit","_side","_faction","_factioName","_time","_ctrl"];
	while {true} do {

		waitUntil {missionNamespace getVariable ["MCC_UIModuleTickets",false]};

		//Create progress bar
		if (isnull (uiNamespace getVariable ["MCC_hud",objNull])) then {
			(["MCC_hud"] call BIS_fnc_rscLayer) cutRsc ["MCC_hud", "PLAIN"];
		};

		{
			_side = _x;
			_tickets = [_side] call BIS_fnc_respawnTickets;
			if (_tickets >= 0) then {
				_ctrl = ((uiNameSpace getVariable "MCC_hud") displayCtrl ((_foreachindex*10)+30));
				_ctrlPos = ctrlPosition _ctrl;

				//Show control
				if ((_ctrlPos select 2) == 0) then {
					_ctrlPos set [2,(0.04125 * safezoneW)];
					_ctrlPos set [3,(0.11 * safezoneH)];
					_ctrl ctrlSetPosition _ctrlPos;
					_ctrl ctrlCommit 0;

					//Flag
					_unit = objNull;
					{
						if (side _x == _side && (_x isKindOf "man")) exitWith {_unit = _X}
					} forEach allUnits;

					if !(isNull _unit) then {
						_faction = gettext (configfile >> "cfgvehicles" >> typeof _unit >> "faction");
						_flagTexture =  gettext (configfile >> "cfgfactionclasses" >> _faction >> "flag");
						_factioName = gettext (configfile >> "cfgfactionclasses" >> _faction >> "displayName");
					} else {
						_flagTexture =  ([_side] call bis_fnc_sidecolor) call bis_fnc_colorRGBAtoTexture;
						_factioName = [_side] call BIS_fnc_sideName;
					};

					//Flag
					_ctrl = ((uiNameSpace getVariable "MCC_hud") displayCtrl ((_foreachindex*10)+32));
					_ctrl ctrlSetText _flagTexture;
					_ctrl ctrlCommit 0;

					//Name
					_ctrl = ((uiNameSpace getVariable "MCC_hud") displayCtrl ((_foreachindex*10)+33));
					_ctrl ctrlSetText _factioName;
					_ctrl ctrlCommit 0;
				};

				//Tickets
				_ctrl = ((uiNameSpace getVariable "MCC_hud") displayCtrl ((_foreachindex*10)+34));
				_ctrl ctrlSetText (str _tickets);
				_ctrl ctrlCommit 0;
			};
		} forEach [west, east, resistance];

		//Time
		_time = if ((estimatedEndServerTime - serverTime)>0) then {[estimatedEndServerTime - serverTime] call MCC_fnc_time} else {""};
		_ctrl = (uiNameSpace getVariable "MCC_hud") displayCtrl 60;
		_ctrl ctrlSetText _time;
		_ctrl ctrlCommit 0;

		sleep 1;
	};

	missionNamespace setVariable ["MCC_forceCamera",false];
};
