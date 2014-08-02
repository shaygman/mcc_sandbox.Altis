disableSerialization;
private ["_type","_indecator","_array","_arrayName","_side"];
_type = _this select 0;

_side = switch (toLower mcc_sidename) do
		{
			case "west": {west};
			case "east": {east};
			case "guer": {resistance};
			case "civ": {civilian};
		};
							
switch (_type) do
	{
	   case 0:		//AirDrop Car
		{
			MCC_spawnkind = [MCC_airDropArray];
			MCC_planeType = [str (side player)];
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
				MCC_capture_var = MCC_capture_var + FORMAT ['%3 set [count %3,[%1, %2]];
					publicVariable "%3";'
					,MCC_spawnkind
					,MCC_planeType
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
