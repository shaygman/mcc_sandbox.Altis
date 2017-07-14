private ["_mccdialog","_comboBox","_displayname","_it","_x","_index"];
disableSerialization;
MCC_GUI1initDone = false;

#define MCCVIEWDISTANCE 1006
#define MCCGRASSDENSITY 1007
#define MCCMISSIONMAKERNAME 1020
#define MCCCLIENTFPS 1021
#define MCCSERVERFPS 1022

#define MCC_keyBindsOpenMCCButtonIDC 8415
#define MCC_keyBindsOpenConsoleButtonIDC 8416
#define MCC_keyBindsT2TButtonIDC 8417
#define MCC_keyBindsGroupsButtonIDC 8418
#define MCC_keyBindsMCCinteractionIDC 8419

//Mission Maker
private ["_text","_key","_textKey","_mmName"];
_mmName = if (mcc_missionmaker != "") then {mcc_missionmaker} else {"Not Assigned"};
ctrlSetText [MCCMISSIONMAKERNAME, format["%1",_mmName]];


_mccdialog = finddisplay 2990;

//set text
_text = format["<img size='2' align='center' shadow='0' image='%1data\iconWikia.paa' />",MCC_path] +
		"<a underline='true' color='#0000FF' align='center' shadow='1' href='http://mccsandbox.wikia.com/wiki/Getting_started'>Visit MCC Wiki</a> <br />" +
		format["<img size='2' align='center' shadow='0' image='%1data\iconDiscord.paa' />",MCC_path] +
		"<a underline='true' color='#0000FF' align='center' shadow='1' href='https://discord.gg/3DzkzAn'>Join our Discord</a> <br />";

(_mccdialog displayCtrl 1000) ctrlSetStructuredText parseText _text;

//----------------------------------------------------------Client Side settings----------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCCGRASSDENSITY;		//fill combobox Grass
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_grass_array;
_comboBox lbSetCurSel (MCC_terrainPref select 0);

_comboBox = _mccdialog displayCtrl MCCVIEWDISTANCE;		//fill combobox View distance
lbClear _comboBox;
{
	_displayname = format ["%1",_x];
	_comboBox lbAdd _displayname;
} foreach MCC_view_array;
_comboBox lbSetCurSel (MCC_terrainPref select 1); // set viewdistance index to current vd


//Show key Binds
for [{_x=8415},{_x<=8421},{_x=_x+1}]  do
{
	if (MCC_isCBA) then {
		_text = "Use CBA Controls";
		ctrlEnable [_x, false];
		(_mccdialog displayCtrl _x) ctrlSetTooltip "";
	} else {
		_key = MCC_keyBinds select (_x-8415);

		_text = "";
		if (_key select 0) then {_text = "Shift + "};
		if (_key select 1) then {_text = _text + "Ctrl + "};
		if (_key select 2) then {_text = _text + "Alt + "};

		_text = format ["%1%2",_text,keyName (_key select 3)];
	};

	ctrlsettext [_x, _text];
};


//Disable cover system client side
ctrlEnable [8499,missionNamespace getVariable ["MCC_cover",false]];

sleep 1;
MCC_GUI1initDone = true;

//-------------------------------------------------FPS Loop  -----------------------------
while {(str (finddisplay 2990) != "no display")} do
{
	MCC_clientFPS  = round(diag_fps);
	ctrlSetText [MCCCLIENTFPS, format["%1",MCC_clientFPS]];

	if (isnil "mcc_fps_running") then {mcc_fps_running = false};
	if !(mcc_fps_running) then
	{
		[[1],"MCC_fnc_FPS",true,false] spawn BIS_fnc_MP;
		sleep 0.5;
	};

	if !( MCC_isHC ) then
	{
		ctrlSetText [MCCSERVERFPS, format["%1",MCC_serverFPS]];
	}
	else
	{
		ctrlSetText [MCCSERVERFPS, format[" %1 - HC FPS: %2", MCC_serverFPS, MCC_hcFPS]];
	};
	sleep 1;
};