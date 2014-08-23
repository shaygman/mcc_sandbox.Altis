//==================================================================MCC_fnc_initDispaly===============================================================================================
//Handle displayes from MCC's curator
//==================================================================================================================================================================================
private ["_mode","_params","_class","_display","_ctrlGroup","_ctrlTitle","_h","_ctrlTitlePos","_ctrlGroupPos","_ctrlBackground","_ctrlContent","_ctrlButtonOK",
         "_ctrlButtonCancel","_ctrlButtonCustom","_ctrlBackgroundPos","_ctrlTitlePos","_ctrlContentPos","_ctrlButtonCancelPos","_ctrlButtonOKPos","_ctrlButtonCustomPos",
		 "_ctrlTitleOffsetY","_ctrlContentOffsetY","_posY","_avtiveControls","_cfgControl","_idc","_control","_controlPos","_posH","_ctrlMap","_ctrlCuratorMap","_fncFile","_classNames"]; 

#define IDC_OK	1
#define IDC_CANCEL 2

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

MCC_curatorOkButtonPressed = false; 

switch _mode do 
{
	case "onLoad": 
	{
		_display = _params select 0;
		_ctrlBackground = _display displayctrl 10001;
		_ctrlTitle = _display displayctrl 10002;
		_ctrlContent = _display displayctrl 10003;
		_ctrlButtonOK = _display displayctrl IDC_OK;
		_ctrlButtonCancel = _display displayctrl IDC_CANCEL;
		_ctrlButtonCustom = _display displayctrl 10006;

		_ctrlBackgroundPos = ctrlposition _ctrlBackground;
		_ctrlTitlePos = ctrlposition _ctrlTitle;
		_ctrlContentPos = ctrlposition _ctrlContent;
		_ctrlButtonOKPos = ctrlposition _ctrlButtonOK;
		_ctrlButtonCancelPos = ctrlposition _ctrlButtonCancel;
		_ctrlButtonCustomPos = ctrlposition _ctrlButtonCustom;


		_ctrlTitleOffsetY = (_ctrlBackgroundPos select 1) - (_ctrlTitlePos select 1) - (_ctrlTitlePos select 3);
		_ctrlContentOffsetY = (_ctrlContentPos select 1) - (_ctrlBackgroundPos select 1);
		
		//--- Show fake map in the background
		_ctrlMap = _display displayctrl 50;
		_ctrlMap ctrlenable false;
		if (visiblemap) then 
		{
			_ctrlCuratorMap = (finddisplay IDD_RSCDISPLAYCURATOR) displayctrl IDC_RSCDISPLAYCURATOR_MAINMAP;
			_ctrlMap ctrlmapanimadd [0,ctrlmapscale _ctrlCuratorMap,_ctrlCuratorMap ctrlmapscreentoworld [0.5,0.5]];
			ctrlmapanimcommit _ctrlMap;
		} 
		else 
		{
			_ctrlMap ctrlshow false;
		};
		
		//Set the control groups
		_avtiveControls = configfile >> _class >> "Controls" >> "Content" >> "Controls";
		
		_posY = _ctrlContentOffsetY;
		for "_i" from 0 to (count _avtiveControls - 1) do 
		{
			_cfgControl = _avtiveControls select _i;
			
			if (isclass _cfgControl) then 
			{
				_idc = getnumber (_cfgControl >> "idc");
				_control = _display displayctrl _idc;
				_controlPos = ctrlposition _control;
				_controlPos set [0,0];
				_controlPos set [1,_posY];
				_control ctrlsetposition _controlPos;
				_control ctrlShow true;
				_control ctrlcommit 0;
				_posY = _posY + (_controlPos select 3) + 0.005;
				ctrlsetfocus _control;
			};
		};

		//Set the frame
		_posH = ((_posY + _ctrlContentOffsetY) min 0.9) * 0.5;

		_ctrlTitlePos set [1,(0.5 - _posH) - (_ctrlTitlePos select 3) - _ctrlTitleOffsetY];
		_ctrlTitle ctrlsetposition _ctrlTitlePos;
		_ctrlTitle ctrlcommit 0;

		_ctrlContentPos set [1,0.5 - _posH];
		_ctrlContentPos set [3,_posH * 2];
		_ctrlContent ctrlsetposition _ctrlContentPos;
		_ctrlContent ctrlcommit 0;

		_ctrlBackgroundPos set [1,0.5 - _posH];
		_ctrlBackgroundPos set [3,_posH * 2];
		_ctrlBackground ctrlsetposition _ctrlBackgroundPos;
		_ctrlBackground ctrlcommit 0;

		_ctrlButtonOKPos set [1,0.5 + _posH + _ctrlTitleOffsetY];
		_ctrlButtonOK ctrlsetposition _ctrlButtonOKPos;
		_ctrlButtonOK ctrlcommit 0;
		ctrlsetfocus _ctrlButtonOK;

		_ctrlButtonCancelPos set [1,0.5 + _posH + _ctrlTitleOffsetY];
		_ctrlButtonCancel ctrlsetposition _ctrlButtonCancelPos;
		_ctrlButtonCancel ctrlcommit 0;

		_ctrlButtonCustomPos set [1,0.5 + _posH + _ctrlTitleOffsetY];
		_ctrlButtonCustom ctrlsetposition _ctrlButtonCustomPos;
		_ctrlButtonCustom ctrlcommit 0;

				
		//Set the tittle
		_ctrlTitle ctrlsettext "MCC Sector";
		
		
		
		//---Hnadle the display Close the display when entity is altered
		[_display, _class] spawn 
		{
			private ["_display","_ctrlButtonOK","_comboBox","_index","_sides","_sectors","_class","_target","_defaultOwner"];
			disableserialization;
			_display 		= _this select 0;
			_class			= _this select 1; 
			_ctrlButtonOK = _display displayctrl 1;
			
			_target = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_target",objnull];
			
			switch _class do 
			{
				//Zone control
				case "MCC_RscDisplayAttributesModuleObjectiveSector": 	
				{
					//Load sectors
					_sectors = [true] call MCC_fnc_moduleSector; 
					_comboBox = _display displayctrl 115003;
					lbClear _comboBox;
					_index = _comboBox lbAdd "None";
					_comboBox lbSetData [_index,"none"];
					{
						_index = _comboBox lbAdd (_x getvariable ["name",""]);
						_comboBox lbSetData [_index,str _x];
					} foreach _sectors;
					_comboBox lbSetCurSel 0;
					
					//Add and load event handler for default owner
					_comboBox = _display displayctrl 115009;
					_comboBox ctrladdeventhandler [
							"LBSelChanged",
							"(missionnamespace getvariable ['BIS_fnc_initCuratorAttributes_target',objnull]) setVariable ['Owner',(if ((_this select 1)< 4) then {_this select 1} else {4}) call bis_fnc_sidetype,true]; false"];
					
					lbClear _comboBox;
					{
						_index = _comboBox lbAdd str (_x call bis_fnc_sidetype); 
						_comboBox lbSetData [_index,str _x];
					} foreach [0, 1, 2, 3, 4];
					_comboBox lbSetCurSel 4;
					
					waituntil {isnull _display};
					
					if (uinamespace getVariable ["MCC_curatorOkButtonPressed",false]) exitWith
					{
						_display closedisplay 2;
						
						//Vars: Name, DefaultOwner, areas, 
						_target = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_target",objnull];
						_sides = missionnamespace getvariable ["RscAttributeOwners_sides",[]];
						
						//Set default owner
						//_defaultOwner = (if ((_target getVariable "DefaultOwner")== "-1") then {4} else {call compile (_target getVariable "DefaultOwner")}) call bis_fnc_sidetype;
						//[_target] call MCC_fnc_moduleSector;
						
						//[_target, _defaultOwner] call MCC_fnc_moduleSector;
					};
				};
			};
			
			
			
			
			
			//Close
			switch (typename _target) do {
				case (typename objnull): {
					_isAlive = alive _target;
					waituntil {isnull _display || (_isAlive && !alive _target)};
				};
				case (typename grpnull): {
					waituntil {isnull _display || isnull _target};
				};
				case (typename []): {
					_grp = _target select 0;
					_wpCount = count waypoints _grp;
					waituntil {isnull _display || (count waypoints _grp != _wpCount)};
				};
				case (typename ""): {
					waituntil {isnull _display || markertype _target == ""};
				};
			};
			_display closedisplay 2;
		};
	}; 
	
	case "onLoad": 
	{
	};
};



