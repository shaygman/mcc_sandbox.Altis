//by Bon_Inf*
#define BON_ARTY_DIALOG 999900
#define BON_ARTY_SHELLSLEFT 999901
#define BON_ARTY_XRAY 999902
#define BON_ARTY_YANKEE 999903
#define BON_ARTY_CANNONLIST 999904
#define BON_ARTY_XRAYEDIT 999905
#define BON_ARTY_YANKEEEDIT 999906
#define BON_ARTY_DIRECTION 999907
#define BON_ARTY_DISTANCE 999908
#define BON_ARTY_HEIGHT 999909
#define BON_ARTY_HEIGHTINDEX 999910
#define BON_ARTY_DELAYEDIT 999911
#define BON_ARTY_SUMMARY 999913
#define BON_ARTY_REQUESTBUTTON 999914
#define BON_ARTY_TYPE 999915
#define BON_ARTY_NRSHELLS 999916
#define BON_ARTY_SPREAD 999917
#define BON_ARTY_XCORRECTION 999918
#define BON_ARTY_YCORRECTION 999919
#define BON_ARTY_ADJUSTBUTTON 999920
#define BON_ARTY_MISSIONTYPE 999921
disableSerialization;

private ["_arti_settings","_index","_shellsleft","_cannon","_comboBox","_artidialog","_displayname","_comboBox","_allAmmo","_ammoTypes","_ctrl","_selectedCannon","_ammo","_isCommander"];

_ctrl	= _this select 0;
_index 	= _this select 1;
_artidialog = findDisplay BON_ARTY_DIALOG;

//is the player the commander or just using the artillery computer
_isCommander = ((MCC_server getVariable [format ["CP_commander%1",side player],""]) == getPlayerUID player) or ("MCC_itemConsole" in (assignedItems player));

switch (ctrlIDC _ctrl) do
{
	//Selecting another cannon
	case (BON_ARTY_CANNONLIST):
	{
		_arti_settings = player getVariable format["Arti_%2_Cannon%1Summary",_index + 1,playerSide];

		if (not isNil "_arti_settings") then
		{
			ctrlSetText [BON_ARTY_SUMMARY,_arti_settings];
		}
		else
		{
			ctrlSetText [BON_ARTY_SUMMARY,""];
		};

		//Real cannon
		if (_index > (HW_Arti_CannonNumber-1) || !_isCommander) then
		{
			_cannon = MCC_bonCannons select _index;
			_allAmmo = magazinesAmmo vehicle _cannon;

			_ammoTypes = [];
			//Make it uniqe array
			{
				if !((_x select 0) in _ammoTypes) then {_ammoTypes set [count _ammoTypes, (_x select 0)]};
			} foreach _allAmmo;

			_comboBox = _artidialog displayCtrl BON_ARTY_TYPE;
			lbClear _comboBox;
			{
				_displayname = getText(configFile >> "cfgMagazines" >> _x >> "displayname");
				_index = _comboBox lbAdd _displayname;
				_comboBox lbsetData [_index, _x];
			} foreach _ammoTypes;
			_comboBox lbSetCurSel 0;
		}
		//Virtual cannon
		else
		{
			_shellsleft = MCC_server getVariable format["Arti_%1_shellsleft",side player];
			if (isNil "_shellsleft") then {_shellsleft = 0};
			ctrlSetText [BON_ARTY_SHELLSLEFT,format["Shells left: %1",_shellsleft]];

			_comboBox = _artidialog displayCtrl BON_ARTY_TYPE;
			lbClear _comboBox;
			{
				_displayname = _x select 0;
				_index = _comboBox lbAdd _displayname;
				_comboBox lbsetData [_index, ""];
			} foreach HW_arti_types;
			_comboBox lbSetCurSel 0;
		};
	};
	//Changing the ordnance type
	case (BON_ARTY_TYPE):
	{
		_selectedCannon = lbcursel (_artidialog displayCtrl BON_ARTY_CANNONLIST);

		//Real cannon
		if (_selectedCannon > (HW_Arti_CannonNumber-1) || !_isCommander) then
		{
			_cannon = MCC_bonCannons select _selectedCannon;
			_ammo = _ctrl lbData _index;

			//Real ammo
			if (_ammo != "") then
			{
				_allAmmo = magazinesAmmo vehicle _cannon;

				//count ammo
				_shellsleft = 0;
				//Make it uniqe array
				{
					if ((_x select 0) == _ammo) then {_shellsleft = _shellsleft +(_x select 1)};
				} foreach _allAmmo;

				ctrlSetText [BON_ARTY_SHELLSLEFT,format["Shells left: %1",_shellsleft]];
			};
		};
	};
};

true