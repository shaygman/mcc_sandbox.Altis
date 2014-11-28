private ["_type"];
disableSerialization;

_type = _this select 0;
if !mcc_isloading then 
	{
	if (mcc_missionmaker == (name player)) then
	{
		shelltype 		= (MCC_artilleryTypeArray select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 30))) select 1;
		MCCSimulate		= (MCC_artilleryTypeArray select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 30))) select 2;
		_shellName		= (MCC_artilleryTypeArray select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 30))) select 0;
		MCCshellRadius	= (MCC_artilleryTypeArray select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 30))) select 3;
		nshell 			= (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 32))+1;
		MCC_artyDelay 	=(lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 33))*20;
		
		if (isnil "MCC_artyDelay") then {MCC_artyDelay = 0};
		switch (_type) do
		{
		   case 0:		//Request
			{
				shellspread = (MCC_artillerySpreadArray select (lbCurSel ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 31))) select 1;
				missionNameSpace setVariable ["MCC_artilleryEnabled",true];
				hint "click on map where you want to send artillery -Hold Ctrl for multiple clicks"; 
				
			};
			case 1:	//Add		
			{
				if (MCC_capture_state) then	
				{
					MCC_capture_var = MCC_capture_var 
						+ FORMAT ["HW_arti_types set [count HW_arti_types,[""%1"", ""%2""]];",_shellName, shelltype]
						+ 		  "publicVariable ""HW_arti_types"";"
						+ FORMAT ["HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + %1;",nshell]
						+ 		  "publicVariable ""HW_arti_number_shells_per_hour"";"
						+ FORMAT ["[[2,{[""MCCNotifications"",[""%1 %2 shells added"",""%3data\ammo_icon.paa"",""""]] call bis_fnc_showNotification;}], ""MCC_fnc_globalExecute"", true, false] spawn BIS_fnc_MP;",_shellName,nshell,MCC_path];
				} 
				else 
				{
						mcc_safe = mcc_safe + FORMAT ['HW_arti_types set [count HW_arti_types,["%1", "%2"]];
						publicVariable "HW_arti_types";
						HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + %3;
						publicVariable "HW_arti_number_shells_per_hour";
						'
						,_shellName
						,shelltype
						,nshell
						];
						
						if !([_shellName, shelltype] in HW_arti_types) then
						{
							HW_arti_types set [count HW_arti_types,[_shellName, shelltype]]; 
							publicVariable "HW_arti_types"; 
						};
						
						HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + nshell;
						publicVariable "HW_arti_number_shells_per_hour";
						
						switch (tolower mcc_sideName) do
						{
							case "west" : {MCC_server setVariable ["Arti_WEST_shellsleft",HW_arti_number_shells_per_hour,true]};
							case "east" : {MCC_server setVariable ["Arti_EAST_shellsleft",HW_arti_number_shells_per_hour,true]};
							case "guer" : {MCC_server setVariable ["Arti_GUER_shellsleft",HW_arti_number_shells_per_hour,true]};
							case "civ" : {MCC_server setVariable ["Arti_CIV_shellsleft",HW_arti_number_shells_per_hour,true]};
						};	
							
						[[2,compile format ['["MCCNotifications",["%2 %1 shells added","%3data\ammo_icon.paa",""]] call bis_fnc_showNotification;',nshell,_shellName,MCC_path]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
						//["MCCNotifications",[format ["%2 %1 shells added",nshell,_shellName],format ["%1data\ammo_icon.paa",MCC_path],""]] call bis_fnc_showNotification;
				};
				hint format ["%1 Artillery enabled. \nAdded %2 artillery rounds",_shellName,nshell];
			};
		};
	}	
		else { player globalchat "Access Denied"};
	};