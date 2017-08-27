
//******************************************************************************************
//==========================================================================================
//=		 						 Shay-Gman
//=					                            13.01.2012
//==========================================================================================
//******************************************************************************************
private ["_logic","_null","_synced"];

_logic = _this select 0;
_logic setpos [1000,10,0];
_synced = synchronizedobjects _logic;		//Who synced with the module

if (player in _synced)then {
	//Action key
	 hcam_Key = (_logic getvariable ["hcam_actionKey",1]);

	hcam_units = synchronizedobjects _logic;			//Units watching the live feed

	while { !alive player || isnil "MCC_path"} do {sleep 1};
	_null = [] execVM MCC_path + "hcam\hcam_init.sqf";
	player setVariable ["mcc_sf",true,true];
	sleep 1;
	waituntil {!(IsNull (findDisplay 46))};

	private ["_answer"];
	if (profileNamespace getVariable ["MCC_tutorialSF",true]) then
	{
		_answer = ["<t font='TahomaB'>You have just been assigned as Special Forces member</t>"
					+"<br/><img size='9' img image='"+MCC_path+"data\sf.paa' />"
					+format ["<br/>You can access your group helmet camera using <t font='TahomaB'><t underline='true'>User key %1</t></t> key.",hcam_Key]
					+format ["<br/>Press <t font='TahomaB'><t underline='true'>Shift + User key %1</t></t> to change video size.",hcam_Key]
					+format ["<br/>Press <t font='TahomaB'><t underline='true'>Ctrl + User key %1</t></t> to change to thermal or night vision.",hcam_Key]
					+format ["<br/>Press <t font='TahomaB'><t underline='true'>Alt + User key %1</t></t> to turn camera off.",hcam_Key]
					+"<br/><br/>Do you want to show this message in the future?","MCC Special Forces","No","Yes"] call BIS_fnc_guiMessage;

		waituntil {!isnil "_answer"};

		if (_answer) exitWith
		{
			profileNamespace setVariable ["MCC_tutorialSF",false];
		};
	};
};