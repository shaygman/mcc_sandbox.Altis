//==================================================================MCC_fnc_roleClicked =================================================================================
// Handle clicking on a role
//=====================================================================================================================================================================
private ["_role","_level","_array","_ctrl"];
disableSerialization;
_role = param [1,"",[""]];
_parentIdc = param [2,0,[0]];

_null = [_role,0] call MCC_fnc_setGear;
_disp = ctrlParent (_this select 0);
[_disp] call MCC_fnc_playerStats;

player switchmove "AidlPercMstpSlowWrflDnon_G03";

//Create buttons
_array = [
			["primary","Primary Weapon",format ["%1mcc\roleSelection\data\ui\primaryweapon_ca.paa",MCC_path]],
			["secondary","Secondary Weapon",format ["%1mcc\roleSelection\data\ui\secondaryweapon_ca.paa",MCC_path]],
			["handgun","Handgun",format ["%1mcc\roleSelection\data\ui\handgun_ca.paa",MCC_path]],
			["items1","Binoculars",format ["%1mcc\roleSelection\data\ui\binoculars_ca.paa",MCC_path]],
			["items2","Items",format ["%1mcc\roleSelection\data\ui\cargoput_ca.paa",MCC_path]],
			["items3","Items",format ["%1mcc\roleSelection\data\ui\cargothrow_ca.paa",MCC_path]],
			["nightVision","Night Vision",format ["%1mcc\roleSelection\data\ui\nvgs_ca.paa",MCC_path]],
			["headgear","Head Gear",format ["%1mcc\roleSelection\data\ui\headgear_ca.paa",MCC_path]],
			["googles","Googles",format ["%1mcc\roleSelection\data\ui\goggles_ca.paa",MCC_path]],
			["vests","Vest",format ["%1mcc\roleSelection\data\ui\vest_ca.paa",MCC_path]],
			["uniforms","Uniforms",format ["%1mcc\roleSelection\data\ui\uniform_ca.paa",MCC_path]],
			["backpacks","Backpack",format ["%1mcc\roleSelection\data\ui\backpack_ca.paa",MCC_path]],
			["insigna","Insigna",format ["%1mcc\roleSelection\data\ui\insignia_ca.paa",MCC_path]]
		 ];

for "_i" from 10000 to 20000 step +1000 do {
	(_disp displayCtrl _i) ctrlShow false;
};

MCC_fnc_RSbuildGearButtons = {
	/* ==================================   MCC_fnc_RSbuildGearButtons ===============================
	//	Builds buttons for setting gear
	============================================================================================================================*/
	private ["_buttonCtrlGroup","_idc","_space","_xPos","_yPos","_hight","_ctrlPos","_array","_data","_toolTip","_pic","_ctrl","_parentIdc"];
	disableSerialization;
	_disp = ctrlParent (_this select 0);
	_idc = param [1,10000,[0]];
	_parentIdc = param [2,0,[0]];
	_array = param [3,[],[[]]];
	_ctrlPos = ctrlPosition (_disp displayCtrl _parentIdc);


	_space = 0.005* safezoneH;
	_xPos = 0;
	_yPos = _space + 0;
	_hight = 0.03* safezoneH;

	_ctrlPos set [0,(_ctrlPos select 0)+(_ctrlPos select 2)];
	_ctrlPos set [3,(_hight*(count _array + 3))];

	//Ctrl Group
	if !(isNull (_disp displayCtrl _idc)) then {
		ctrlDelete (_disp displayCtrl _idc)
	};

	_buttonCtrlGroup = _disp ctrlCreate ["RscControlsGroupNoScrollbars",_idc];
	_buttonCtrlGroup ctrlSetPosition _ctrlPos;
	_buttonCtrlGroup ctrlCommit 0;

	//Create Gear background
	if (isNull (_disp displayCtrl 9874444)) then {
		_ctrlPos set [0,(_ctrlPos select 0) + 0.005 * safezoneW];
		_ctrlPos set [1,0.42 * safezoneH];
		_ctrlPos set [2,0.3 * safezoneW];
		_ctrlPos set [3,0.2 * safezoneH];
		_ctrl = _disp ctrlCreate ["RscListbox",9874444];
		_ctrl ctrlSetPosition _ctrlPos;
		_ctrl ctrlCommit 0;
	};

	{
		_data = _x select 0;
		_toolTip = _x select 1;
		_pic = _x select 2;

		//Bckg
		_ctrl = _disp ctrlCreate ["RscPicture",-1,_buttonCtrlGroup];
		_ctrl ctrlSetPosition [0.005*safezoneW, _yPos, 0.03 * safezoneW, _hight];
		_ctrl ctrlSetText format ["%1mcc\roleSelection\data\ui\icon_ca.paa",MCC_path];
		//_ctrl ctrlSetBackgroundColor [1,1,1,0.9];
		_ctrl ctrlCommit 0;

		//Button
		_ctrl = _disp ctrlCreate ["RscActivePicture",-1,_buttonCtrlGroup];
		_ctrl ctrlSetPosition [0.005*safezoneW, _yPos, 0.03 * safezoneW, _hight];
		_ctrl ctrlSetText _pic;
		_ctrl ctrlSetTooltip _toolTip;
		_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[%1,_this select 0] spawn MCC_fnc_RSgearButtonClicked",if (typeName _data == typeName "") then {str _data} else {_data}]];
		_ctrl ctrlCommit 0;

		_yPos = _yPos + _hight + _space;
	} forEach _array;
};

[(_this select 0), 10000, _parentIdc, _array] call MCC_fnc_RSbuildGearButtons;