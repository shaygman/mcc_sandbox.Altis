#define mcc_playerConsole2_IDD 5000
#define mcc_playerConsole3_IDD 5010

#define MCC_MINIMAP 9120
#define MCC_CONSOLE_AC_MAP 5022
private ["_mccdialog","_control","_string","_uav"];
disableSerialization;

if (MCC_Console2Open) then {_mccdialog = findDisplay mcc_playerConsole2_IDD; _uav = MCC_ConolseUAV};
if (MCC_Console3Open) then {_mccdialog = findDisplay mcc_playerConsole3_IDD; _uav = MCC_fakeAC};

_string = ctrlText MCC_CONSOLE_AC_MAP;
if (_string == "Open Map") then {
	ctrlSetText [MCC_CONSOLE_AC_MAP, "Close Map"];
	ctrlShow [MCC_MINIMAP,true];
	(_mccdialog displayctrl MCC_MINIMAP) ctrlSetPosition [ 0.55 * safezoneW + safezoneX, 0.212936 * safezoneH + safezoneY,0.238749 * safezoneW,0.266059 * safezoneH];
	(_mccdialog displayctrl MCC_MINIMAP) ctrlCommit 1;
	waitUntil {ctrlCommitted (_mccdialog displayctrl MCC_MINIMAP)};
	
	[_uav,_mccdialog] spawn {
			private ["_control","_uav"];
			disableSerialization;
			_uav = _this select 0;
			_mccdialog = _this select 1;
			
			createMarkerLocal ["mccUAVMarker",getpos _uav];	//Create group's marker
			"mccUAVMarker" setMarkerTypeLocal "b_uav";
			"mccUAVMarker" setMarkerColorLocal "ColorBlue";
			"mccUAVMarker" setMarkerposLocal getpos _uav;
			_control = _mccdialog displayCtrl MCC_MINIMAP;
			_control ctrlMapAnimAdd [0.5, 0.1, getmarkerpos "mccUAVMarker"];
			ctrlMapAnimCommit _control;
			while {ctrlShown (_mccdialog displayctrl MCC_MINIMAP)} do	{
				"mccUAVMarker" setMarkerposLocal getpos _uav;
				sleep 0.05;
				};
			deletemarkerlocal "mccUAVMarker";
			};
	} else	{
		(_mccdialog displayctrl MCC_MINIMAP) ctrlSetPosition [0.788749 * safezoneW + safezoneX, 0.212936 * safezoneH + safezoneY,0.01 * safezoneW,0.01 * safezoneH];
		(_mccdialog displayctrl MCC_MINIMAP) ctrlCommit 1;
		sleep 1; 
		ctrlShow [MCC_MINIMAP,false];
		ctrlSetText [MCC_CONSOLE_AC_MAP, "Open Map"];
		};


	
	