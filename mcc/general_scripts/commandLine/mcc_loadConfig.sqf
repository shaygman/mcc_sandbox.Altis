#define MCC_SaveLoadScreen_IDD 7000
#define MCC_LOAD_INPUT 7001
#define MCC_SaveLoadScreen_IDD 7000
#define MCC_SAVE_LIST 7010
#define MCC_SAVE_DIS 7011
#define MCC_SAVE_NAME 7012

disableSerialization;
private ["_type", "_string", "_command", "_mccdialog"];

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
			copyToClipboard mcc_safe;
			
			player globalchat "Saved MCC Mission configuration to Clipboard. Save config code for later re-use!";
			player globalchat "To rebuild mission copy to clipboard (ctrl-c), paste in load frame (crtl-v), and press load";
			
			ctrlSetText [MCC_LOAD_INPUT, _string];
		};
		
		case 2: //Save MCC Mission config code to uinamespace
		{
			_string = ctrlText MCC_SAVE_NAME;
			if (_string == "" ) exitWith {hint "Mission save failed! Please type a name for your saved mission"};
			MCC_saveNames set [MCC_saveIndex,_string];
			_string = ctrlText MCC_SAVE_DIS;
			MCC_saveFiles set [MCC_saveIndex,[_string,mcc_safe]];
			profileNamespace setVariable ["MCC_save", MCC_saveNames];
			profileNamespace setVariable ["MCC_saveFiles", MCC_saveFiles];
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
			if (mcc_safe == "") then {
				ctrlSetText [MCC_LOAD_INPUT,(((profileNamespace getVariable "MCC_saveFiles") select MCC_saveIndex) select 1)];
				};
		};
		
		case 4: //Load MCC Mission config code to uinamespace
		{
			_string = (((profileNamespace getVariable "MCC_saveFiles") select MCC_saveIndex) select 1);
			if (_string == "" ) exitWith {hint "Mission load failed! : No MCC Mission configuration pasted from namespace"};
			sleep 0.5;
			closeDialog 0;
			sleep 0.3;
			_command = 'mcc_isloading=true;closedialog 0;titleText ["Loading Mission","BLACK FADED",5];' + _string + 'mcc_isloading=false;titleText ["Mission Loaded","BLACK IN",5];'; 
			//_command = "mcc_isloading=true;" + _string + "mcc_isloading=false;"; 
			[] spawn compile _command;
		};
		
		case 5: //Save to SQM
		{
			//_null = [] execVm "mcc\fnc\general\fn_saveToSQM.sqf";
			[] call MCC_fnc_saveToSQM;
		};
		
		case 6: //Save to COMP
		{
			[position player] call MCC_fnc_saveToComp;
		};
	};

} else {player globalchat "Access Denied";}