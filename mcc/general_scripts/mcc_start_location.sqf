#define MCCENABLECP 1027
private ["_side","_null"];
disableSerialization;

_side = _this select 0;
if (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 21)==1) then {_side = _side + 7};
MCC_teleportAtStart = lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 201212);

if !mcc_isloading then {
	switch (_side) do
	{
		case 0:	//West
		{
			hint "click on map where you want your start location";
			onMapSingleClick "
					MCC_START_WEST  = _pos;
					publicVariable ""MCC_START_WEST"";

					[[_pos, 0, 'west','HQ',false,false,true,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;

					onMapSingleClick """";

					mcc_safe=mcc_safe + FORMAT [""
												MCC_START_WEST  = %1;
												publicVariable 'MCC_START_WEST';

												MCC_teleportAtStart = %2;

												[[MCC_START_WEST, 0, 'west','HQ',false,false,true,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
												""
												,MCC_START_WEST
												,MCC_teleportAtStart
												];
					hint ""Start WEST location updated.""
				";
		};

		case 1:	//East
		{
			hint "click on map where you want your start location";
			onMapSingleClick "
					MCC_START_EAST  = _pos;
					publicVariable ""MCC_START_EAST"";

					[[_pos, 0, 'east','HQ',false,false,true,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;

					onMapSingleClick """";

					mcc_safe=mcc_safe + FORMAT [""
												MCC_START_EAST  = %1;
												publicVariable 'MCC_START_EAST';

												MCC_teleportAtStart = %2;

												[[MCC_START_EAST, 0, 'east','HQ',false,false,true,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
												""
												,MCC_START_EAST
												,MCC_teleportAtStart
												];
					hint ""Start East location updated.""
				";
		};

		case 2:	//Guer
		{
			hint "click on map where you want your start location";
			onMapSingleClick "
					MCC_START_GUER  = _pos;
					publicVariable ""MCC_START_GUER"";

					[[_pos, 0, 'GUER','HQ',false,false,true,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;

					onMapSingleClick """";

					mcc_safe=mcc_safe + FORMAT [""
												MCC_START_GUER  = %1;
												publicVariable 'MCC_START_GUER';

												MCC_teleportAtStart = %2;

												[[MCC_START_GUER, 0, 'GUER','HQ',false,false,true,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
												""
												,MCC_START_GUER
												,MCC_teleportAtStart
												];
					hint ""Start Guer location updated.""
				";
		};

		case 3:	//Civ
		{
			hint "click on map where you want your start location";
			onMapSingleClick "
					MCC_START_CIV  = _pos;
					publicVariable ""MCC_START_CIV"";

					onMapSingleClick """";

					mcc_safe=mcc_safe + FORMAT [""
												MCC_START_CIV  = %1;
												publicVariable 'MCC_START_CIV';

												MCC_teleportAtStart = %2;
												""
												,MCC_START_CIV
												,MCC_teleportAtStart
												];
					hint ""Start Guer location updated.""
				";
		};

		case 4:	//Disable respawn
		{
			MCC_TRAINING = FALSE;
			publicVariable "MCC_TRAINING";
			[["Mission started, respawn is off"],'MCC_fnc_globalHint',true,true] spawn BIS_fnc_MP;
			MCC_enable_respawn=false;
		};

		case 5:	//Start on LHD
		{
		};

		case 6:	//Enable CP
		{
			private "_answer";

			_answer = ["<t font='TahomaB'>Are you sure you want to enable/disable role selection?</t>","Role Selection",nil,true] call BIS_fnc_guiMessage;
			waituntil {!isnil "_answer"};
			if (_answer) then {
				CP_activated = missionnamespace getVariable ["CP_activated", false];
				missionnamespace setVariable ["CP_activated", !CP_activated];
				publicVariable "CP_activated";
				if (CP_activated) then
				{
					ctrlsettext [520,"Disable Roles"];
				}
				else
				{
					ctrlsettext [520,"Enable Roles"];
				};

				mcc_safe=mcc_safe + format ['
												missionnamespace setVariable ["CP_activated", %1];
												publicVariable "CP_activated";
												_null=[] execVM "%2mcc\roleSelection\scripts\player_init.sqf";
											'
											,CP_activated
											,MCC_path
											];

				if (CP_activated) then {_null=[] execVM MCC_path + "mcc\roleSelection\scripts\player_init.sqf"};

				//Set tickets on server otherwise EH will be broadcast to the server
				if (isServer) then
				{
					{
						_sideTickets = format ["MCC_tickets%1", _x];
						_tickets = missionNameSpace getVariable [_sideTickets,200];
						[_x, _tickets] call BIS_fnc_respawnTickets;
					} foreach [west, east, resistance];
				};
			};
		};

		case 7:	//FOB West
		{
			hint "click on map inorder to place the FOB";
			onMapSingleClick "
					[[_pos, 0, 'west' ,'FOB',true,false,false,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
					onMapSingleClick """";
					mcc_safe=mcc_safe + FORMAT [""
												[[%1, 0, 'west' ,'FOB',true], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
												""
												,_pos
												];
					hint ""FOB placed.""
				";
		};

		case 8:	//FOB East
		{
			hint "click on map inorder to place the FOB";
			onMapSingleClick "
					[[_pos, 0, 'east' ,'FOB',true,false,false,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
					onMapSingleClick """";
					mcc_safe=mcc_safe + FORMAT [""
												[[%1, 0, 'east' ,'FOB',true], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
												""
												,_pos
												];
					hint ""FOB placed.""
				";
		};

		case 9:	//FOB RESISTANCE
		{
			hint "click on map inorder to place the FOB";
			onMapSingleClick "
					[[_pos, 0, 'GUER' ,'FOB',true,false,false,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
					onMapSingleClick """";
					mcc_safe=mcc_safe + FORMAT [""
												[[%1, 0, 'RESISTANCE' ,'FOB',true], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
												""
												,_pos
												];
					hint ""FOB placed.""
				";
		};

		case 10:	//FOB Civilian
		{
			hint "click on map inorder to place the FOB";
			onMapSingleClick "
					[[_pos, 0, 'CIV' ,'FOB',true,false,false,MCC_teleportAtStart], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
					onMapSingleClick """";
					mcc_safe=mcc_safe + FORMAT [""
												[[%1, 0, 'CIV' ,'FOB',true], 'MCC_fnc_buildSpawnPoint', false, false] spawn BIS_fnc_MP;
												""
												,_pos
												];
					hint ""FOB placed.""
				";
		};
	};
};




