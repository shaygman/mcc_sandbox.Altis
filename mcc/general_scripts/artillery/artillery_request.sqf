#define MCC_SANDBOX2_IDD 2000
#define MCC_ARTYTYPE 2004
#define MCC_ARTYSPREAD 2005
#define MCC_ARTYNUMBER 2006
#define MCC_artilleryDelayIDC 2037

private ["_type"];
_type = _this select 0;
if !mcc_isloading then 
	{
	if (mcc_missionmaker == (name player)) then
	{
		shelltype 		= (MCC_artilleryTypeArray select (lbCurSel MCC_ARTYTYPE)) select 1;
		MCCSimulate		= (MCC_artilleryTypeArray select (lbCurSel MCC_ARTYTYPE)) select 2;
		_shellName		= (MCC_artilleryTypeArray select (lbCurSel MCC_ARTYTYPE)) select 0;
		nshell 			= MCC_artilleryNumberArray select (lbCurSel MCC_ARTYNUMBER);
		MCC_artyDelay 	=(lbCurSel MCC_artilleryDelayIDC)*20;
		
		switch (_type) do
		{
		   case 0:		//Request
			{
				shellspread = (MCC_artillerySpreadArray select (lbCurSel MCC_ARTYSPREAD)) select 1;
				if (MCC_capture_state) then
				{
				hint "click on map where you want to send artillery"; 
				onMapSingleClick " 	hint ""Artillery captured."";
									MCC_capture_var = MCC_capture_var + FORMAT ['
									[[%1, ""%2"", %3, %4, %5, %6],""MCC_fnc_artillery"",true,false] spawn BIS_fnc_MP;
									'
									,_pos
									,shelltype
									,shellspread
									,nshell
									,MCCSimulate
									,MCC_artyDelay
									];
									onMapSingleClick """";";	
				}	else
					{
					hint "click on map where you want to send artillery"; 
					onMapSingleClick " 	hint ""Artillery inbound."";
									[[_pos, shelltype, shellspread, nshell,MCCSimulate,MCC_artyDelay],'MCC_fnc_artillery',true,false] spawn BIS_fnc_MP;
									onMapSingleClick """";";	
					};
			};
			case 1:	//Add		
			{
				if (MCC_capture_state) then	{
					MCC_capture_var = MCC_capture_var + FORMAT ['HW_arti_types set [count HW_arti_types,["%1", "%2"]];
						publicVariable "HW_arti_types";
						HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + %3;
						publicVariable "HW_arti_number_shells_per_hour";
						[[2,{["MCCNotifications",["%1 %3 shells added","%4data\ammo_icon.paa",""]] call bis_fnc_showNotification;}], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
						'
						,_shellName
						,shelltype
						,nshell
						,MCC_path
						];
					} else {
						mcc_safe = mcc_safe + FORMAT ['HW_arti_types set [count HW_arti_types,["%1", "%2"]];
						publicVariable "HW_arti_types";
						HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + %3;
						publicVariable "HW_arti_number_shells_per_hour";
						'
						,_shellName
						,shelltype
						,nshell
						];
						HW_arti_types set [count HW_arti_types,[_shellName, shelltype]]; 
						publicVariable "HW_arti_types"; 
						HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + nshell;
						publicVariable "HW_arti_number_shells_per_hour";
						Server setVariable ["Arti_WEST_shellsleft",HW_arti_number_shells_per_hour,true];
						Server setVariable ["Arti_EAST_shellsleft",HW_arti_number_shells_per_hour,true];
						Server setVariable ["Arti_GUER_shellsleft",HW_arti_number_shells_per_hour,true];
						Server setVariable ["Arti_CIV_shellsleft",HW_arti_number_shells_per_hour,true];
						[[2,compile format ['["MCCNotifications",["%2 %1 shells added","%3data\ammo_icon.paa",""]] call bis_fnc_showNotification;',nshell,_shellName,MCC_path]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
						//["MCCNotifications",[format ["%2 %1 shells added",nshell,_shellName],format ["%1data\ammo_icon.paa",MCC_path],""]] call bis_fnc_showNotification;
						};
				hint format ["%1 Artillery enabled. \nAdded %2 artillery rounds",_shellName,nshell];
			};
		};
	}	
		else { player globalchat "Access Denied"};
	};