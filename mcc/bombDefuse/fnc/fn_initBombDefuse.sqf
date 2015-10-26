/*=================================================================MCC_fnc_initBombDefuse==================================================================================
  init the bomb defuser dialog
  Parameter(s):
     0: STRING - difficulty: easy, medium or hard
     1: ARRAY  - Array of strings - containing the riddles we want:
                1. wires - the player will have to cut the correct wire.
                2. buttons - the player will have to turn on and off each button to match the correct sequence.
                3. numpad - the player will have to punch the symbols on the numpad in the correct order.

     Example ["easy",["wires","wires","buttons","numpad","buttons"]] call MCC_fnc_initBombDefuse"

     Return <>
        BOOLEAN - true - if the player succeed in the minigame
*/

private ["_difficulty","_array","_ok","_display","_ctrlBackground","_ctrlTitle","_ctrlBackgroundPos","_ctrlTitlePos","_ctrlTitleOffsetY","_ctrlContent","_ctrlContentPos","_ctrlContentOffsetY","_posY","_posX","_serialNumbers","_serialNumber","_object"];
disableSerialization;

#define IDC_BASE 100
#define DEFAULT_WIDTH (10*(((safezoneW / safezoneH) min 1.2)/40))
#define DEFAULT_HEIGHT (10*((((safezoneW / safezoneH) min 1.2)/1.2)/25))

_difficulty = param [0, "", [""]];
_array = param [1, [], [[]]];
_time = param [2, -1, [0]];

_serialNumbers = [73080,262290,451500,640710,829920,136150,199220,262290,325360,892990,703780,181200,208230,370410,613680,802890,478530,145160,163180,217240,244270,352390,442490,487540,631700,712790,838930];
_serialNumber = _serialNumbers call bis_fnc_selectRandom;

//avoid double
if (tolower str (findDisplay 1031983) != "no display") exitWith {[]};

_ok = createDialog "MCC_bombDefuse";
waitUntil {dialog};

_display = findDisplay 1031983;
_ctrlBackground = _display displayctrl 10001;
_ctrlTitle = _display displayctrl 10002;
_ctrlContent = _display displayctrl 10003;

_ctrlBackgroundPos = ctrlposition _ctrlBackground;
_ctrlTitlePos = ctrlposition _ctrlTitle;
_ctrlContentPos = ctrlposition _ctrlContent;

_ctrlTitleOffsetY = (_ctrlBackgroundPos select 1) - (_ctrlTitlePos select 1) - (_ctrlTitlePos select 3);
_ctrlContentOffsetY = (_ctrlContentPos select 1) - (_ctrlBackgroundPos select 1);

_posY = (_ctrlContentPos select 1) - (_ctrlBackgroundPos select 1);
_posX = (_ctrlContentPos select 0) - (_ctrlBackgroundPos select 0);

//Set serial number
_ctrlTitle ctrlSetStructuredText parseText ("<t color='#add118' size='1' shadow='0' align='center' underline='false'>"+ "Serial#: " + str _serialNumber + "</t>");
_ctrlTitle ctrlCommit 0;

//Set player var
player setVariable ["MCC_bombDefuseSuccess",false];
player setVariable ["MCC_bombDefuseStrikes",0];
player setVariable ["MCC_bombDefuseReady",false];

private ["_moduleType","_ctrlGroup","_controlTittle","_control","_index","_ctrls"];

//Set the control groups
_ctrls = [];

//Create the watch
_ctrlGroup = _display ctrlCreate ["RscControlsGroup", 900,_ctrlContent];
_ctrlGroup ctrlSetPosition [_posX, _posY, DEFAULT_WIDTH, DEFAULT_HEIGHT];
_ctrlGroup ctrlCommit 0;

_control = _display ctrlCreate ["RscPicture", 901,_ctrlGroup];
_control ctrlsetText format ["%1mcc\bombDefuse\data\metalModule.paa",MCC_path];
_control ctrlSetPosition [0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT];
_control ctrlCommit 0;

[_difficulty,_ctrlGroup, count _array, _time] spawn MCC_fnc_bdWatch;

_ctrls pushBack _ctrlGroup;

_posX = _posX + DEFAULT_WIDTH*1.1;

{
    _moduleType = _x;

    //Create module ctrlgroup
    _ctrlGroup = _display ctrlCreate ["RscControlsGroup", IDC_BASE + _forEachIndex,_ctrlContent];
    _ctrlGroup ctrlSetPosition [_posX, _posY, DEFAULT_WIDTH, DEFAULT_HEIGHT];
    _ctrlGroup ctrlCommit 0;

    _control = _display ctrlCreate ["RscPicture", -1,_ctrlGroup];
    _control ctrlsetText format ["%1mcc\bombDefuse\data\metalModule.paa",MCC_path];
    _control ctrlSetPosition [0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT];
    _control ctrlCommit 0;

    switch (tolower _moduleType) do {
        case "wires": {[_difficulty,_ctrlGroup,_serialNumber] spawn MCC_fnc_bdWireModule};
        case "buttons": {[_difficulty,_ctrlGroup,_serialNumber] spawn MCC_fnc_bdButtonsModule};
        case "numpad": {[_difficulty,_ctrlGroup,_serialNumber] spawn MCC_fnc_bdNumpadModule};
    };

    _ctrls pushBack _ctrlGroup;

    //move left a box max 4 box in a row
    if (count _ctrls mod 4 != 0) then {
        _posX = _posX + DEFAULT_WIDTH*1.1;
    } else {
        //if not last variable in the array move down a line
        if (_forEachIndex+1 < count _array) then {
            _posY = _posY + DEFAULT_HEIGHT*1.1;
            _posX = (_ctrlContentPos select 0) - (_ctrlBackgroundPos select 0);
        };
    };
} forEach _array;

//Add another hight
_posY = _posY + DEFAULT_HEIGHT*1.1;

//Set the frame
_posH = ((_posY + _ctrlContentOffsetY) min 1.6) * 0.5;

_ctrlTitlePos set [1,(0.5 - _posH) - (_ctrlTitlePos select 3) - _ctrlTitleOffsetY];
_ctrlTitle ctrlSetBackgroundColor [0,0,0,1];
_ctrlTitle ctrlsetposition _ctrlTitlePos;
_ctrlTitle ctrlcommit 0;

_ctrlContentPos set [1,0.5 - _posH];
_ctrlContentPos set [3,_posH * 2];
_ctrlContent ctrlsetposition _ctrlContentPos;
_ctrlContent ctrlcommit 0;

_ctrlBackgroundPos set [1,0.5 - _posH];
_ctrlBackgroundPos set [3,_posH * 2];
_ctrlBackground ctrlsetposition _ctrlBackgroundPos;
_ctrlBackground ctrlsetText format ["%1mcc\bombDefuse\data\metalBackground.paa",MCC_path];
_ctrlBackground ctrlcommit 0;

//We are ready
player setVariable ["MCC_bombDefuseReady",true];

//wait till the dialog is canceled or confirmed
waitUntil {(player getVariable ["MCC_bombDefuseSuccess",false]) || (tolower str (findDisplay 1031983) == "no display")};

//return
player getVariable ["MCC_bombDefuseSuccess",false];

