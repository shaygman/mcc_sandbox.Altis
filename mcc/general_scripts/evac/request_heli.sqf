#define MCC_SANDBOX2_IDD (uiNamespace getVariable "MCC_groupGen_Dialog")
#define MCC_EVAC_TYPE 40
#define MCC_EVAC_CLASS 41
#define MCC_EVAC_SELECTED 42
#define MCC_EVAC_INSERTION 43
#define MCC_EVAC_FLIGHTHIGHT 44

disableSerialization;
private ["_evacArray","_insetionArray","_mccdialog","_option","_type","_class","_comboBox",
		 "_vehicleDisplayName","_displayname","_index","_countVehicles"];
_mccdialog = MCC_SANDBOX2_IDD;


if !mcc_isloading then
{
	if (mcc_missionmaker == (name player)) then
	{
		_option = _this select 0;
		_type 	= lbCurSel MCC_EVAC_TYPE;
		switch (_type) do		//Which evac do we want
		{
			case 0:			//Choppers
			{
				_evacArray = U_GEN_HELICOPTER;
			};
			case 1:			//Vehicles
			{
				_evacArray = U_GEN_CAR;
			};
			case 2:			//Tracked
			{
				_evacArray = U_GEN_TANK;
			};
			case 3:			//Ships
			{
				_evacArray = U_GEN_SHIP;
			};
		};

		if ((lbCurSel MCC_EVAC_CLASS) == -1) exitWith {};
		MCCEvacHeliType = (_evacArray select (lbCurSel MCC_EVAC_CLASS)) select 1;

		//Spawn on LHD
		if (_option == 0) then
		{
			if (MCCLHDSpawned) then
			{
				hint "Evac Vehicle spawned on LHD";
				_pos = getmarkerpos "pos4";
				[[MCCEvacHeliType, _pos],"MCC_fnc_evacSpawn",false,false] spawn BIS_fnc_MP;
				mcc_safe = mcc_safe + FORMAT ["
											[['%1',%2],'MCC_fnc_evacSpawn',false,false] spawn BIS_fnc_MP;
											"
											, MCCEvacHeliType
											, _pos
											];
			}
			else
			{
				hint "LHD is not available, evac chopper can't be spawned"
			};
		};

		//Spawn on land
		if (_option == 1) then
		{
			hint "click on map to spawn evac vechicle";
			onMapSingleClick " 	hint ""Evac Vehicle spawned."";
								[[MCCEvacHeliType, _pos],""MCC_fnc_evacSpawn"",false,false] spawn BIS_fnc_MP;
								mcc_safe=mcc_safe + FORMAT ['
									[[""%1"",%2],""MCC_fnc_evacSpawn"",false,false] spawn BIS_fnc_MP;
									sleep 1;'
									, MCCEvacHeliType
									, _pos
									];
								onMapSingleClick """";
								";
		};

	private ["_evacVehicles"];
	_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",playerSide],[]];
	_countVehicles = count _evacVehicles; 					//Wait until the vehicle is spawned

	waituntil {_countVehicles != count _evacVehicles};
	_comboBox = _mccdialog displayCtrl MCC_EVAC_SELECTED;		//fill combobox Fly in Hight

	lbClear _comboBox;
	{
		if (alive _x) then
		{
			_vehicleDisplayName 	= getText(configFile >> "CfgVehicles" >> typeof _x >> "displayname");
			_displayname 			= format ["%1, %2",_x,_vehicleDisplayName];
			_index 					= _comboBox lbAdd _displayname;
		}
		else
		{
			_displayname 			= "N/A";
			_index 					= _comboBox lbAdd _displayname;
		};
	} foreach _evacVehicles;

	_comboBox lbSetCurSel (missionNameSpace getvariable ["MCC_evacVehicles_index",0]);
	}
	else
	{
		player globalchat "Access Denied"
	};
};

