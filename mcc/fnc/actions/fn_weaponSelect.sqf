//==================================================================MCC_fnc_weaponSelect===================================================================================
//Change weapons and throw utility
// Example: [] call MCC_fnc_weaponSelect;
//===========================================================================================================================================================================
private ["_key","_exit"];
disableSerialization;

_key = _this select 0;
_exit = false;
if (vehicle player != player && _key != 5) exitWith {};
showCommandingMenu "";

//Clear utility stuff
player setVariable ["MCC_dontAllowFire",false];
if ((player getVariable ["MCC_actionHoldFireSecond",-1]) != -1) then {player removeAction (player getVariable ["MCC_actionHoldFireSecond",nil])};
if ((player getVariable ["MCC_actionHoldFire",-1]) != -1) then	{player removeAction (player getVariable ["MCC_actionHoldFire",nil])};

if (count (player getVariable ["MCC_utilityItem",[]]) > 0) then {
	(["mcc_3dObject"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
	player setVariable ["MCC_utilityItem",[]];
	enableSentences true;
	_exit = true;
};

switch (true) do {
	//Primary/handgun
	case (_key == 2): {
		if (_exit) exitWith {};
		if (currentweapon player != primaryweapon player && primaryweapon player != "") exitWith {player selectWeapon (primaryweapon player)};
		if (currentweapon player == primaryweapon player && handgunWeapon player != "") exitWith {player selectWeapon (handgunWeapon player)};
	};

	//Launcher
	case (_key == 3): {
		if (secondaryWeapon player != "") then {player selectWeapon (secondaryWeapon  player)};
	};

	//Grenade
	case (_key == 4): {
		private ["_mags","_allowedMags","_magsItems","_mag","_item","_speed","_index","_utility","_cameraInternal","_model","_ctrl"];
		//_cameraInternal = if (cameraView == "INTERNAL") then {true} else {false};
		showHUD false;

		_mags = [];
		{
			if ((_x select 3)==0 && _x select 2) then {_mags pushback _x};
		} foreach magazinesAmmoFull player;

		if ((player getVariable ["MCC_utilityItemIndex",0]) > count _mags -1) then {
			player setVariable ["MCC_utilityItemIndex",1];
			_index = 0;
		} else {
			_index = player getVariable ["MCC_utilityItemIndex",0];
			player setVariable ["MCC_utilityItemIndex",_index+1];
		};

		if (count _mags == 0) exitWith {};

		_mag 	= _mags select _index;
		_model = gettext (configfile >> "CfgMagazines" >> (_mag select 0) >> "model");

		(["mcc_3dObject"] call BIS_fnc_rscLayer) cutRsc ["mcc_3dObject", "PLAIN"];
		_ctrl = ((uiNamespace getVariable "mcc_3dObject") displayCtrl 0);
		_ctrl ctrlSetmodel _model;
		_ctrl ctrlSetModelDirAndUp [[0,1,0.4],[0,0,1]];
		_ctrl ctrlSetModelScale 2.5;
		{ ((uiNamespace getVariable "mcc_3dObject") displayCtrl _X) ctrlShow false} foreach [1,2];

		((uiNamespace getVariable "mcc_3dObject") displayCtrl 3) ctrlSetText format ["Press %1 to cycle between grenade throws", ["action"] call MCC_fnc_getKeyFromAction];
		player setVariable ["MCC_utilityItem",_mag];
		player setVariable ["MCC_falseGrenadePrecise",2];

		//Disable fire
		player setVariable ["MCC_dontAllowFire",true];

		// Add secondary hold fire to the action menu
		_null =  player addAction ["", {[false] call MCC_fnc_grenadeThrow}, "", 0, false, true, "action", "_this getVariable ['MCC_dontAllowFire',false]"];
		player setVariable ["MCC_actionHoldFireSecond",_null];

		// Add hold fire to the action menu
		_null =  player addAction ["", {[true] call MCC_fnc_grenadeThrow},"",0,false,true, "DefaultAction","_this getVariable ['MCC_dontAllowFire',false]"];
		player setVariable ["MCC_actionHoldFire",_null];

		0 = [] spawn
		{
			while {(count (player getVariable ["MCC_utilityItem",[]]) > 0) && alive player} do
			{
				//if (cameraView != "INTERNAL") then {player switchCamera "INTERNAL"};
				sleep 0.01;
			};
			//if !_this then {player switchCamera "EXTERNAL"};
			(["mcc_3dObject"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
			showHUD true;
		};
	};

	//Explosive - utility
	case (_key == 5): {
		private ["_mags","_allowedMags","_magsItems","_mag","_model","_speed","_index","_magVehicle","_cameraInternal","_ctrl"];
		//_cameraInternal = if (cameraView == "INTERNAL") then {true} else {false};
		showHUD false;

		_mags = [];
		_allowedMags = ["MCC_ammoBoxMag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","IEDUrbanBig_Remote_Mag","IEDLandBig_Remote_Mag","ATMine_Range_Mag","APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag","ClaymoreDirectionalMine_Remote_Mag","IEDUrbanSmall_Remote_Mag","IEDLandSmall_Remote_Mag"];

		_magsItems = ["MCC_ammoBox","DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo","ATMine_Range_Ammo","APERSMine_Range_Ammo","APERSBoundingMine_Range_Ammo","SLAMDirectionalMine_Wire_Ammo","APERSTripMine_Wire_Ammo","ClaymoreDirectionalMine_Remote_Ammo_Scripted","IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo"];

		enableSentences false;

		{
			if (_x in _allowedMags && !(_x in _mags)) then {_mags pushback _x};
		} foreach (magazines player)+(items player);


		if ((player getVariable ["MCC_utilityItemIndex",0]) > count _mags -1) then {
			player setVariable ["MCC_utilityItemIndex",1];
			_index = 0;
		} else {
			_index = player getVariable ["MCC_utilityItemIndex",0];
			player setVariable ["MCC_utilityItemIndex",_index+1];
		};

		//Open rsc
		(["mcc_3dObject"] call BIS_fnc_rscLayer) cutRsc ["mcc_3dObject", "PLAIN"];
		((uiNamespace getVariable "mcc_3dObject") displayCtrl 0) ctrlShow false;

		if (count _mags > 0) then {
			_mag 	= _mags select _index;
			_magVehicle = _magsItems select (_allowedMags find _mag);
			_model = if (isclass(configfile >> "CfgMagazines" >> _mag)) then {
							gettext (configfile >> "CfgMagazines" >> _mag >> "model")
						} else {
							gettext (configfile >> "CfgWeapons" >> _mag >> "model")
					};

			//Spawn Demo
			_ctrl = ((uiNamespace getVariable "mcc_3dObject") displayCtrl 1);
			_ctrl ctrlSetmodel _model;
			_ctrl ctrlSetModelDirAndUp [[0,1,1],[0,0,1]];


			player setVariable ["MCC_utilityItem",[_mag,_magVehicle]];
		} else {
			player setVariable ["MCC_utilityItem",["",""]];
			((uiNamespace getVariable "mcc_3dObject") displayCtrl 1) ctrlShow false;
		};

		//Spawn clacker
		_model = gettext (configfile >> "CfgVehicles" >> "Land_PortableLongRangeRadio_F" >> "model");
		_ctrl = ((uiNamespace getVariable "mcc_3dObject") displayCtrl 2);
		_ctrl ctrlSetmodel _model;
		_ctrl ctrlSetModelDirAndUp [[0,1,1],[0,0,1]];
		_ctrl ctrlSetModelScale 2;

		((uiNamespace getVariable "mcc_3dObject") displayCtrl 3) ctrlSetText format ["Press %1 to detonate", ["action"] call MCC_fnc_getKeyFromAction];

		//Disable fire
		player setVariable ["MCC_dontAllowFire",true];


		// Add secondary hold fire to the action menu
		_null =  player addAction ["", {[false] spawn MCC_fnc_utilityUse}, "", 0, false, true, "action", "_this getVariable ['MCC_dontAllowFire',false]"];
		player setVariable ["MCC_actionHoldFireSecond",_null];

		// Add hold fire to the action menu
		_null =  player addAction ["", {[true]  spawn MCC_fnc_utilityUse},"",0,false,true, "DefaultAction","_this getVariable ['MCC_dontAllowFire',false]"];
		player setVariable ["MCC_actionHoldFire",_null];

		0 = [] spawn {
			while {(count (player getVariable ["MCC_utilityItem",[]]) > 0) && alive player} do
			{
				//if (cameraView != "INTERNAL") then {player switchCamera "INTERNAL"};
				sleep 0.01;
			};
			//if !_this then {player switchCamera "EXTERNAL"};
			(["mcc_3dObject"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
			showHUD true;
		};

	};
};