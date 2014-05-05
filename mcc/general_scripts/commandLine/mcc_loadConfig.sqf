#define MCC_SaveLoadScreen_IDD 7000
#define MCC_LOAD_INPUT 7001
#define MCC_SaveLoadScreen_IDD 7000
#define MCC_SAVE_LIST 7010
#define MCC_SAVE_DIS 7011
#define MCC_SAVE_NAME 7012

disableSerialization;
private ["_type", "_string", "_command", "_mccdialog","_br","_array"];
_br = toString [0x0D, 0x0A];

if (mcc_missionmaker == (name player)) then {
	_type = _this select 0;
	_mccdialog = findDisplay MCC_SaveLoadScreen_IDD;
	_string = "";
	MCC_saveIndex = (lbCurSel MCC_SAVE_LIST);

	switch (_type) do
	{
		case 0:	//Load MCC Mission config code
		{ 		
			_string = ctrlText MCC_LOAD_INPUT;
			if !(_string == "" ) then 
			{
				sleep 0.5;
				closeDialog 0;
		
				sleep 0.3;
				_command = 'mcc_isloading=true;closedialog 0;titleText ["Loading Mission","BLACK FADED",5];' + _string + 'mcc_isloading=false;titleText ["Mission Loaded","BLACK IN",5];'; 
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

			MCC_output = 'MCC_savedObjectives = ' + (str((call compile _temp) select 0)) + ';' + _br
					 +   'MCC_savedGroups = ' + (str((call compile _temp) select 1)) + ';' + _br 
					 +   'MCC_savedVehicles = ' + (str((call compile _temp) select 2)) + ';' + _br
					 +   'MCC_savedWeather = ' + (str((call compile _temp) select 3)) + ';' + _br
					 +   'MCC_savedTime = ' + (str((call compile _temp) select 4)) + ';' + _br
					 +   '[[MCC_savedObjectives, MCC_savedGroups, MCC_savedVehicles, MCC_savedWeather, MCC_savedTime], "MCC_fnc_loadFromMCC", false, false] spawn BIS_fnc_MP;' + _br;
					 
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
			MCC_saveNames set [MCC_saveIndex,_string];
			_string = ctrlText MCC_SAVE_DIS;
			
			private ["_temp"];
			_temp = [] call MCC_fnc_saveToMCC;
			

			MCC_output = [((call compile _temp) select 0),((call compile _temp) select 1),((call compile _temp) select 2),((call compile _temp) select 3),((call compile _temp) select 4), mcc_safe];
			
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
			_string = _array select 5; 
			//Do we have saved objects?
			if ((count (_array select 0))>0 || (count (_array select 1))>0 || (count (_array select 2))>0 || (count (_array select 3))>0 || (count (_array select 4))>0 || _string != "") then
			{
				sleep 0.5;
				closeDialog 0;
				sleep 0.3;
				[[_array select 0, _array select 1, _array select 2, _array select 3, _array select 4], "MCC_fnc_loadFromMCC", false, false] spawn BIS_fnc_MP;
				_command = 'mcc_isloading=true;closedialog 0;titleText ["Loading Mission","BLACK FADED",5];' + _string + 'mcc_isloading=false;titleText ["Mission Loaded","BLACK IN",5];'; 

			[] spawn compile _command;
			}
			else
			{
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
	};

} else {player globalchat "Access Denied";}