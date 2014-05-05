#define MCC3D_IDD 8000
#define MCC3DOpenCompIDC 8010
#define MCC_3DCompssaveListIDC 8011
#define MCC_3DCompssaveDescriptionIDC 8012
#define MCC_3DCsaveNameIDC 8013
#define MCC_3DCompsaveNameTittleIDC 8014
#define MCC_3DCompsaveUIButtonIDC 8015
#define MCC_3DComploadUIButtonIDC 8016
#define MCC_3DComploadBcgIDC 8017
#define MCC_INITBOX 8004 

private ["_mccdialog","_pos","_comboBox","_index","_type","_saveIndex","_string","_tempText"];
disableSerialization;
_mccdialog = findDisplay MCC3D_IDD;
_type = _this select 0;
_saveIndex = (lbCurSel MCC_3DCompssaveListIDC);
if (isnil "_saveIndex" || _saveIndex == -1) then {_saveIndex = 0}; 
switch (_type) do
{
	case 0: //Change save slot
	{
		_comboBox = _mccdialog displayCtrl MCC_3DCompssaveListIDC; 
		lbClear _comboBox;
		{
			_index = _comboBox lbAdd _x;
		} foreach (profileNamespace getVariable "MCC_3DCompSaveNames");
		_comboBox lbSetCurSel _saveIndex;
		
		ctrlSetText [MCC_3DCompssaveDescriptionIDC,(profileNamespace getVariable "MCC_3DCompSaveFiles") select _saveIndex];
	}; 
	
	case 1: //Save MCC Composition to uinamespace
		{
			_string = ctrlText MCC_3DCsaveNameIDC;
			if (_string == "" ) exitWith {hint "Composition save failed! Please type a name for your saved composition"};
			MCC_3DCompSaveNames set [_saveIndex,_string];
			_string = [position MCC_dummyObject] call MCC_fnc_saveToComp;
			MCC_3DCompSaveFiles set [_saveIndex,_string];
			profileNamespace setVariable ["MCC_3DCompSaveNames", MCC_3DCompSaveNames];
			profileNamespace setVariable ["MCC_3DCompSaveFiles", MCC_3DCompSaveFiles];
			saveProfileNamespace;
			hint "Saved MCC Composition.";
			
			_comboBox = _mccdialog displayCtrl MCC_3DCompssaveListIDC; 
			lbClear _comboBox;
			{
				_index = _comboBox lbAdd _x;
			} foreach (profileNamespace getVariable "MCC_3DCompSaveNames");
			_comboBox lbSetCurSel _saveIndex;
			
			ctrlSetText [MCC_3DCompssaveDescriptionIDC,(profileNamespace getVariable "MCC_3DCompSaveFiles") select _saveIndex];
		};
		
	case 2: //Load MCC Composition from uinamespace
		{
			_string = (profileNamespace getVariable "MCC_3DCompSaveFiles") select _saveIndex;
			if (_string == "" ) exitWith {hint "Composition load failed! : No MCC Composition pasted from namespace"};
			_tempText = ctrlText MCC_INITBOX;
			_string = "[position _this, getdir _this," + _string +"] call MCC_fnc_objectMapper; deleteVehicle _this;" + _tempText; 			
			ctrlSetText [MCC_INITBOX,_string];
		};
};
