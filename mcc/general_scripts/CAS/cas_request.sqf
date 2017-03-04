#define MCC_AIRDROPTYPECONTROL 1031
#define MCC_AIRDROPCLASSCONTROL 1032
#define MCC_AIRDROPARRAYCONTROL 1033

disableSerialization;
private ["_type","_indecator","_array","_arrayName","_side","_index","_groupArray","_dummy","_isParachute"];
_type = _this select 0;

_side = switch (toLower mcc_sidename) do
		{
			case "west": {west};
			case "east": {east};
			case "guer": {resistance};
			case "civ": {civilian};
		};

//If slingload ignore array and call what we have or we didn't fill the array
_isParachute = (missionNamespace getVariable ["MCC_airdropIsParachute",0])==0;
if ((_type in [0,1] && !_isParachute) || (count MCC_airDropArray == 0)) then {
	_index = lbCurSel MCC_AIRDROPCLASSCONTROL;
	if (_index == -1) exitWith {};

	_dummy = lbData [MCC_AIRDROPCLASSCONTROL,_index];
	MCC_airDropArray = [_dummy];
};

switch (_type) do
	{
	   case 0:		//AirDrop Car
		{
			MCC_spawnkind = [MCC_airDropArray];
			MCC_planeType = [mcc_sidename];
		};

	    case 1:		//CAS
		{
			MCC_spawnkind	= [MCC_CASBombs select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 26))];
			_indecator 		= (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 25));
			MCC_planeType 	= if (_indecator <= (count (U_GEN_AIRPLANE)-1)) then
								{
									[(U_GEN_AIRPLANE select _indecator) select 1];
								}
								else
								{
									_indecator = _indecator - (count U_GEN_AIRPLANE);
									[(U_GEN_HELICOPTER select _indecator) select 1];
								};
		};

		 case 2:	//CAS Add
		{
			MCC_spawnkind	= [MCC_CASBombs select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 26))];

			_indecator 		= (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 25));
			MCC_planeType 	= if (_indecator <= (count (U_GEN_AIRPLANE)-1)) then
								{
									[(U_GEN_AIRPLANE select _indecator) select 1];
								}
								else
								{
									_indecator = _indecator - (count U_GEN_AIRPLANE);
									[(U_GEN_HELICOPTER select _indecator) select 1];
								};
			_arrayName		= format ["MCC_CASConsoleArray%1",mcc_sidename];

			if (MCC_capture_state) then
			{
				MCC_capture_var = MCC_capture_var + FORMAT ['%5 set [count %5,[%1, %2]];
					publicVariable "%5";
					[[2,{["MCCNotifications",["%4 CAS available","%3data\ammo_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
					'
					,MCC_spawnkind
					,MCC_planeType
					,MCC_path
					,MCC_spawnkind select 0
					,_arrayName
					];
			}
			else
			{
					mcc_safe = mcc_safe + FORMAT ['%3 set [count %3,[%1, %2]];
					publicVariable "%3";'
					,MCC_spawnkind
					,MCC_planeType
					,_arrayName
					];

					_array = missionNameSpace getVariable [_arrayName,[]];
					_array set [count _array,[MCC_spawnkind, MCC_planeType]];
					missionNameSpace setVariable [_arrayName,_array];
					publicvariable _arrayName;

					[[2,compile format ['["MCCNotifications",["%1 CAS available","%2data\ammo_icon.paa",""]] call bis_fnc_showNotification;',MCC_spawnkind select 0,MCC_path]], "MCC_fnc_globalExecute", _side, false] spawn BIS_fnc_MP;
			};
		};

		 case 3:	//Airdrop Add
		{
			MCC_spawnkind		= [MCC_airDropArray];
			MCC_planeType		= ["I_Heli_Transport_02_F"];

			_arrayName		= format ["MCC_ConsoleAirdropArray%1",mcc_sidename];

			if (MCC_capture_state) then
			{
				MCC_capture_var = MCC_capture_var + FORMAT ['%3 set [count %3,[%1, %2, %4]];
					publicVariable "%3";'
					,MCC_spawnkind
					,MCC_planeType
					,_arrayName
					,(missionNamespace getVariable ["MCC_airdropIsParachute",0])
					];
			}
			else
			{
				mcc_safe = mcc_safe + FORMAT ['%3 set [count %3,[%1, %2, %4]];
				publicVariable "%3";'
				,MCC_spawnkind
				,MCC_planeType
				,_arrayName
				,(missionNamespace getVariable ["MCC_airdropIsParachute",0])
				];

				_array = missionNameSpace getVariable [_arrayName,[]];
				_array set [count _array,[MCC_spawnkind, MCC_planeType,(missionNamespace getVariable ["MCC_airdropIsParachute",0])]];
				missionNameSpace setVariable [_arrayName,_array];
				publicvariable _arrayName;
			};
		};
	};

if (_type == 0 || _type == 1) then {
	hint "Left click on the map,hold and drag the cursor to mark the area and direction of the Air Support";
	MCC_CASrequestMarker = true;
	};

if (_type == 2) then {
	hint format ["CAS: %1, Plane: %2 Added to player's console",MCC_spawnkind,MCC_planeType];
	//server globalchat format ["%1",MCC_CASConsoleArray];	//debug
	};

if (_type == 3) then {
	hint format ["Airdrop: %1, Added to player's console",MCC_spawnkind];
	//server globalchat format ["%1",MCC_ConsoleAirdropArray];	//debug
	};