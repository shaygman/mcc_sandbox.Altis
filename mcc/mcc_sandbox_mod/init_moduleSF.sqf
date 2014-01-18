
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
	if (isnil {_logic getvariable "hcam_goggles"}) then {	 //goggles to watch the live feed
		hcam_goggles = ["G_Tactical_Clear"];
			} else { 
				hcam_goggles = _logic getvariable "hcam_goggles"
				};
	if (isnil {_logic getvariable "hcam_headgear"}) then {	 //Headgear needed to watch the live feed
		hcam_headgear = ["H_Cap_red","H_HelmetB","H_HelmetB_paint"," H_HelmetB_light","H_HelmetO_ocamo","H_PilotHelmetHeli_B","H_PilotHelmetHeli_O"];
			} else { 
				hcam_headgear = _logic getvariable "hcam_headgear"
				};
				
	hcam_units = synchronizedobjects _logic;			//Units watching the live feed
	while { !alive player || isnil "MCC_path"} do {sleep 1}; 
	_null = [] execVM MCC_path + "hcam\hcam_init.sqf";
	player setVariable ["mcc_sf",true,true];
	sleep 1; 
	waituntil {!(IsNull (findDisplay 46))};
	["<t font='TahomaB'>You have just been assigned as Special Forces member</t>
	<br/><img size='9' img image='"+MCC_path+"data\sf.paa' />
	<br/>You can access your group helmet camera using <t font='TahomaB'><t underline='true'>User key 1</t></t> key.
	<br/>Press <t font='TahomaB'><t underline='true'>Shift + User key 1</t></t> to change video size.
	<br/>Press <t font='TahomaB'><t underline='true'>Ctrl + User key 1</t></t> to change to thermal or night vision.
	<br/>Press <t font='TahomaB'><t underline='true'>Alt + User key 1</t></t> to turn camera off.","MCC Special Forces",nil,false] spawn BIS_fnc_guiMessage;
	};