#define MCC_SaveLoadScreen_IDD 7000
#define MCC_LOAD_INPUT 7001
#define MCC_SaveLoadScreen_IDD 7000
#define MCC_SAVE_LIST 7010
#define MCC_SAVE_DIS 7011
#define MCC_SAVE_NAME 7012

disableSerialization;
private ["_type", "_string", "_command", "_mccdialog","_br","_array"];
_br = toString [0x0D, 0x0A];

MCC_fn_loadZones =
{
	private ["_zonesArray","_zonesNumber","_zonesPos","_zonesSize","_zonesDir","_zonesLocation","_size"];
	_zonesArray 	= _this select 0;
	_zonesNumber	= _zonesArray select 0;
	_zonesPos		= _zonesArray select 1;
	_zonesSize		= _zonesArray select 2;
	_zonesDir		= _zonesArray select 3;
	_zonesLocation	= _zonesArray select 4;

	//Create the Zones
	{
		mcc_zone_markposition 	= _zonesPos select _x;
		mcc_zone_number			= _x;
		mcc_zone_marker_X		= (_zonesSize select _x) select 0;
		mcc_zone_marker_Y		= (_zonesSize select _x) select 1;
		mcc_zone_markername		= str _x;
		mcc_hc					= _zonesLocation select _x;
		MCC_Marker_dir 			= _zonesDir select _x;

		diag_log format["Zone Created: %1 - %2",_x, mcc_zone_markposition];
		script_handler = [0] execVM MCC_path +"mcc\general_scripts\mcc_make_the_marker.sqf";
		waitUntil {str(getMarkerPos mcc_zone_markername) != "[0,0,0]"};

		sleep 1;
		mcc_zone_markername setMarkerColorLocal "colorBlack";
		mcc_zone_markername setMarkerAlphalocal 0.2;

	} foreach _zonesNumber;
};


_type = _this select 0;
_mccdialog = findDisplay MCC_SaveLoadScreen_IDD;
_string = "";
MCC_saveIndex = (lbCurSel MCC_SAVE_LIST);

switch (_type) do {
	case 0:	//Load MCC Mission config code
	{
		_string = ctrlText MCC_LOAD_INPUT;
		if !(_string == "" ) then
		{
			sleep 0.5;
			closeDialog 0;

			sleep 0.3;
			_command = 'mcc_isloading=true;closedialog 0;titleText ["Loading Mission","BLACK FADED",5];' + _string + 'titleText ["Mission Loaded","BLACK IN",5];mcc_isloading=false;';
			[] spawn compile _command;
		}
		else
		{
			player globalchat "ERROR: No MCC Mission configuration pasted from clipboard!";
		};
	};

	case 1: //Save MCC Mission config code to Clipboard
	{
		private ["_temp"];
		_temp = [] call MCC_fnc_saveToMCC;
		MCC_savedZones = str [(missionNamespace getVariable ["MCC_zones_numbers",[]]), mcc_zone_pos, mcc_zone_size, mcc_zone_dir, mcc_zone_locations];
		MCC_savedZones = [MCC_savedZones, "<null>", "nil"] call MCC_fnc_replaceString;

		MCC_output = 'MCC_savedObjectives = ' + (str((call compile _temp) select 0)) + ';' + _br
				 +   'MCC_savedGroups = ' + (str((call compile _temp) select 1)) + ';' + _br
				 +   'MCC_savedVehicles = ' + (str((call compile _temp) select 2)) + ';' + _br
				 +   'MCC_savedWeather = ' + (str((call compile _temp) select 3)) + ';' + _br
				 +   'MCC_savedTime = ' + (str((call compile _temp) select 4)) + ';' + _br
				 +   'MCC_settingsVars = ' + (str((call compile _temp) select 5)) + ';' + _br
				 +   'MCC_savedZones = ' + MCC_savedZones + ';' + _br
				 +   '[MCC_savedZones] spawn MCC_fn_loadZones;' + _br
				 +   '[[MCC_savedObjectives, MCC_savedGroups, MCC_savedVehicles, MCC_savedWeather, MCC_savedTime,MCC_settingsVars], "MCC_fnc_loadFromMCC", false, false] spawn BIS_fnc_MP;' + _br;


		MCC_output = MCC_output + mcc_safe;
		copyToClipboard MCC_output;

		player globalchat "Saved MCC Mission configuration to Clipboard. Save config code for later re-use!";
		player globalchat "To rebuild mission copy to clipboard (ctrl-c), paste in load frame (crtl-v), and press load";

		ctrlSetText [MCC_LOAD_INPUT, MCC_output];
	};

	case 2: //Save MCC Mission config code to uinamespace
	{
		_string = ctrlText MCC_SAVE_NAME;
		if (_string == "" ) exitWith {hint "Mission save failed! Please type a name for your saved mission"};

		//Give the mission a new name
		missionnamespace setvariable ["bis_fnc_moduleMissionName_name",_string];
		MCC_saveNames set [MCC_saveIndex,_string];
		_string = ctrlText MCC_SAVE_DIS;

		private ["_temp"];
		_temp = call compile ([] call MCC_fnc_saveToMCC);

		MCC_savedZones = str [(missionNamespace getVariable ["MCC_zones_numbers",[]]), mcc_zone_pos, mcc_zone_size, mcc_zone_dir, mcc_zone_locations];
		MCC_savedZones = [MCC_savedZones, "<null>", "nil"] call MCC_fnc_replaceString;

		MCC_output = [_temp select 0, _temp select 1, _temp select 2, _temp select 3, _temp select 4, _temp select 5, call compile MCC_savedZones, mcc_safe];

		MCC_saveFiles set [MCC_saveIndex,[_string,MCC_output]];
		profileNamespace setVariable ["MCC_save", MCC_saveNames];
		profileNamespace setVariable ["MCC_saveFiles", MCC_saveFiles];
		saveProfileNamespace;
		hint "Saved MCC Mission configuration.";

		_comboBox = _mccdialog displayCtrl MCC_SAVE_LIST;
		lbClear _comboBox;
		{
			_index = _comboBox lbAdd _x;
		} foreach (profileNamespace getVariable "MCC_save");

		ctrlSetText [MCC_SAVE_DIS,(((profileNamespace getVariable "MCC_saveFiles") select MCC_saveIndex) select 0)];
	};

	case 3: //Change save slot
	{
		_comboBox = _mccdialog displayCtrl MCC_SAVE_LIST;
		lbClear _comboBox;
		{
			_index = _comboBox lbAdd _x;
		} foreach (profileNamespace getVariable "MCC_save");

		ctrlSetText [MCC_SAVE_DIS,(((profileNamespace getVariable "MCC_saveFiles") select MCC_saveIndex) select 0)];
		if (mcc_safe == "") then
		{
			ctrlSetText [MCC_LOAD_INPUT,(((profileNamespace getVariable "MCC_saveFiles") select MCC_saveIndex) select 1)];
		};
	};

	case 4: //Load MCC Mission config code to uinamespace
	{
		_array = (((profileNamespace getVariable "MCC_saveFiles") select MCC_saveIndex) select 1);
		_string = _array select 7;
		MCC_safe = MCC_safe + _string;
		//Do we have saved objects?
		if ((count (_array select 0))>0 || (count (_array select 1))>0 || (count (_array select 2))>0 || (count (_array select 3))>0 || (count (_array select 4))>0 || (count (_array select 5))>0 || (count (_array select 6))>0 || _string != "") then
		{
			sleep 0.5;
			closeDialog 0;
			sleep 0.3;
			[[_array select 0, _array select 1, _array select 2, _array select 3, _array select 4, _array select 5], "MCC_fnc_loadFromMCC", false, false] spawn BIS_fnc_MP;
			[(_array select 6)] spawn MCC_fn_loadZones;
			_command = 'mcc_isloading=true;closedialog 0;titleText ["Loading Mission","BLACK FADED",5];' + _string + 'mcc_isloading=false;titleText ["Mission Loaded","BLACK IN",5];';

			[] spawn compile _command;

		} else {
			hint "Mission load failed! : No MCC Mission configuration pasted from namespace";
		};
	};

	case 5: //Save to all to SQM
	{
		//_null = [true] execVm "mcc\fnc\general\fn_saveToSQM.sqf";
		[true] call MCC_fnc_saveToSQM;
	};

	case 6: //Save to COMP
	{
		[position player] call MCC_fnc_saveToComp;
	};

	case 7: //Save to all to SQM
	{
		//_null = [false] execVm "mcc\fnc\general\fn_saveToSQM.sqf";
		[false] call MCC_fnc_saveToSQM;
	};

	//Activate persistent data
	case 8:
	{
		//load server
		["MCC_campaign",true,true,true,true,true,true,true,true,true] remoteExec ["MCC_fnc_loadServer", 2];

		//load players
		[true,true,true] remoteExec ["MCC_fnc_loadPlayer", 0];

		sleep 20;

		//Save server
		["MCC_campaign",600,false,true,true,true,true,true,true,true,true] remoteExec ["MCC_fnc_saveServer", 2];

		//save players
		[300,true,true,true] remoteExec ["MCC_fnc_savePlayer", 2];

		systemChat "DB Activated";
	};

	//Delete data
	case 9:
	{
		[] remoteExec ["MCC_fnc_clearPersistentData",2];
		systemChat "DB cleared";
	};
};

