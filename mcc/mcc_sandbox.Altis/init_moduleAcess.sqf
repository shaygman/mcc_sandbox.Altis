
//******************************************************************************************
//==========================================================================================
//=		 						 Shay-Gman 
//=					                             24.12.2011
//==========================================================================================
//******************************************************************************************
private ["_logic","_names","_namesList","_synced"];

_logic 		= _this select 0;
_namesList 	= []; 

_logic setpos [1000,10,0];

waituntil {alive player && MCC_initDone};

player removeAction mcc_actionInedx;			//remove previously added action

 if (isnil {_logic getvariable "names"}) then {_names = false} else {  //who autohrized to access the module
	_names = true;
	_namesList = _logic getvariable "names"
	};	
_logic setvariable ["names",_namesList,true];

_synced = synchronizedobjects _logic;									//Who synced with the module

if (_names || (count _synced > 0)) then 								//We have autorized personal only
	{							
		if (((getPlayerUID player) in _namesList) || (player in _synced) || (serverCommandAvailable "#logout"))then 
			{
				mcc_actionInedx = player addaction ["> Mission generator", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
				player setvariable ["MCC_allowed",true,true]; 
			} 
			else
			{
				player setvariable ["MCC_allowed",false,true];
			}
	};
	
while {true} do 												//Case Admin DC
	{														
		sleep 5;
		if (serverCommandAvailable "#logout") then 
			{
				if !(player getvariable "MCC_allowed") then
					{
						mcc_actionInedx = player addaction ["> Mission generator", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
						player setvariable ["MCC_allowed",true,true]; 
					};
			};
	};
