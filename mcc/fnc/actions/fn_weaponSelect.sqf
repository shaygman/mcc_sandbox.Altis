//==================================================================MCC_fnc_weaponSelect===============================================================================================
//Change weapons and throw utility
// Example: [] call MCC_fnc_weaponSelect;
//===========================================================================================================================================================================	
private ["_key","_exit"];
	
_key = _this select 0;
_exit = false; 
if (vehicle player != player) exitWith {};

//Clear utility stuff
player setVariable ["MCC_dontAllowFire",false];
if ((player getVariable ["MCC_actionHoldFireSecond",-1]) != -1) then {player removeAction (player getVariable ["MCC_actionHoldFireSecond",nil])};
if ((player getVariable ["MCC_actionHoldFire",-1]) != -1) then	{player removeAction (player getVariable ["MCC_actionHoldFire",nil])};
if !(isnull (player getVariable ["MCC_utilityRadio",objnull])) then 
{
	deleteVehicle (player getVariable ["MCC_utilityRadio",objnull]);
	player setVariable ["MCC_utilityRadio",objnull];
	_exit = true; 
};
if !(isnull ((player getVariable ["MCC_utilityItem",[objnull,objnull]]) select 0)) then 
{
	deleteVehicle ((player getVariable ["MCC_utilityItem",[objnull,objnull]]) select 0);
	player setVariable ["MCC_utilityItem",[objnull,objnull]];
	enableSentences true;
	_exit = true; 
};
			
switch (true) do
{
	//Primary/handgun
	case (_key == 2):	
	{ 
		if (_exit) exitWith {};
		if (currentweapon player != primaryweapon player && primaryweapon player != "") exitWith {player selectWeapon (primaryweapon player)};
		if (currentweapon player == primaryweapon player && handgunWeapon player != "") exitWith {player selectWeapon (handgunWeapon player)};
	};
	
	//Launcher
	case (_key == 3):
	{ 
		if (secondaryWeapon player != "") then {player selectWeapon (secondaryWeapon  player)};
	};	
	
	//Grenade
	case (_key == 4):
	{ 
		private ["_mags","_allowedMags","_magsItems","_mag","_item","_speed","_index","_utility","_cameraInternal"];
		_cameraInternal = if (cameraView == "INTERNAL") then {true} else {false};
		
		_mags = [];
		{
			if ((_x select 3)==0 && _x select 2) then {_mags pushback _x};
		} foreach magazinesAmmoFull player;
		
		if ((player getVariable ["MCC_utilityItemIndex",0]) > count _mags -1) then 
		{
			player setVariable ["MCC_utilityItemIndex",1];
			_index = 0;
		}
		else
		{
			_index = player getVariable ["MCC_utilityItemIndex",0];
			player setVariable ["MCC_utilityItemIndex",_index+1];
		};
		
		if (count _mags == 0) exitWith {}; 

		_mag 	= _mags select _index;
		
		enableSentences false;
		_utility = "GroundWeaponHolder" createVehiclelocal getpos player;
		_utility attachto [player,[-0.4,0.6,0.5],"head"];
		_utility addItemCargo [_mag select 0,1];
		player setVariable ["MCC_falseGrenadePrecise",true];
		player setVariable ["MCC_utilityItem",[_utility,_mag]];

		
		//Disable fire
		player setVariable ["MCC_dontAllowFire",true];
		
		// Add secondary hold fire to the action menu
		_null =  player addAction ["", {[false] call MCC_fnc_grenadeThrow}, "", 0, false, true, "opticsTemp", "_this getVariable ['MCC_dontAllowFire',false]"];
		player setVariable ["MCC_actionHoldFireSecond",_null];
		
		// Add hold fire to the action menu
		_null =  player addAction ["", {[true] call MCC_fnc_grenadeThrow},"",0,false,true, "DefaultAction","_this getVariable ['MCC_dontAllowFire',false]"];
		player setVariable ["MCC_actionHoldFire",_null];
		
		0 = _cameraInternal spawn
		{
			while {!(isnull ((player getVariable ["MCC_utilityItem",[objnull,objnull]]) select 0)) && alive player} do
			{
				if (cameraView != "INTERNAL") then {player switchCamera "INTERNAL"};
			};
			deletevehicle ((player getVariable ["MCC_utilityItem",[objnull,objnull]]) select 0);
			if !_this then {player switchCamera "EXTERNAL"};
		};
	};
	
	//Explosive - utility
	case (_key == 5):	
	{
		private ["_mags","_allowedMags","_magsItems","_mag","_item","_speed","_index","_utility","_cameraInternal"];
		_cameraInternal = if (cameraView == "INTERNAL") then {true} else {false};
		
		_mags = [];
		_allowedMags = ["MCC_ammoBoxMag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","IEDUrbanBig_Remote_Mag","IEDLandBig_Remote_Mag",
									                    "ATMine_Range_Mag","APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag",
									                    "ClaymoreDirectionalMine_Remote_Mag","IEDUrbanSmall_Remote_Mag","IEDLandSmall_Remote_Mag"];
		_magsItems = ["MCC_ammoBoxMag","DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo",
					  "ATMine_Range_Ammo","APERSMine_Range_Ammo","APERSBoundingMine_Range_Ammo","SLAMDirectionalMine_Wire_Ammo","APERSTripMine_Wire_Ammo",
					  "ClaymoreDirectionalMine_Remote_Ammo_Scripted","IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo"];
						
		{
			if (_x in _allowedMags && !(_x in _mags)) then {_mags pushback _x};
		} foreach magazines player;
		
		//Holster weapon
		if (animationState player in ["amovpercmstpsraswrfldnon","amovpknlmstpsraswrfldnon","amovpercmstpsraswpstdnon","amovpknlmstpsraswpstdnon","amovpercmstpsraswlnrdnon","amovpknlmstpsraswlnrdnon"]) then 
		{
			player action ["WEAPONONBACK", player];
		};
		
		if ((player getVariable ["MCC_utilityItemIndex",0]) > count _mags -1) then 
		{
			player setVariable ["MCC_utilityItemIndex",1];
			_index = 0;
		}
		else
		{
			_index = player getVariable ["MCC_utilityItemIndex",0];
			player setVariable ["MCC_utilityItemIndex",_index+1];
		};
		
		if (count _mags > 0) then 
		{
			_mag 	= _mags select _index;
			_item 	= _magsItems select (_allowedMags find _mag);
			
			enableSentences false;
			_utility = _item createvehiclelocal [0,0,0];
			_utility enablesimulation false; 
			_utility attachto [player,[-0.4,1,-0.3],"Neck"];
			player setVariable ["MCC_utilityItem",[_utility,_mag]];
		};
		
		//Disable fire
		player setVariable ["MCC_dontAllowFire",true];
		
		//Spawn clacker
		_radio = "Land_PortableLongRangeRadio_F" createvehiclelocal [0,0,0];
		_radio attachto [player,[0.4,1,-0.3],"Neck"];
		player setVariable ["MCC_utilityRadio",_radio];
		_radio setVectorDirAndUp [[0,0,1],[0,-1,0]];
		
		// Add secondary hold fire to the action menu
		_null =  player addAction ["", {[false] spawn MCC_fnc_utilityUse}, "", 0, false, true, "opticsTemp", "_this getVariable ['MCC_dontAllowFire',false]"];
		player setVariable ["MCC_actionHoldFireSecond",_null];
		
		// Add hold fire to the action menu
		_null =  player addAction ["", {[true]  spawn MCC_fnc_utilityUse},"",0,false,true, "DefaultAction","_this getVariable ['MCC_dontAllowFire',false]"];
		player setVariable ["MCC_actionHoldFire",_null];
		
		0 = _cameraInternal spawn
		{
			while {!(isnull (player getVariable ["MCC_utilityRadio",objnull])) && alive player} do
			{
				if (cameraView != "INTERNAL") then {player switchCamera "INTERNAL"};
			};
			deletevehicle ((player getVariable ["MCC_utilityItem",[objnull,objnull]]) select 0);
			if !_this then {player switchCamera "EXTERNAL"};
		};
	};
};