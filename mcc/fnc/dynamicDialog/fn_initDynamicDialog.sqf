/*=================================================================MCC_fnc_initDynamicDialog==================================================================================
  init the dynamic dialog
  Parameter(s):
     0: STRING - Dialog Tittle
     1: ARRAY  - Dialog option can by either
                   1. ARRAY of ARRAYS (combo boxs) containing the question text and the option's text in an array examp [["question1",["Option1","option2"]],["question2",["Option1","option2"]]]
                   2. ARRAY of ARRAYS (combo boxs) like above but can have the options var as an array containing the option text + picture path [["question1",[["Option1","option1pic.paa"],"option2"]],["question2",["Option1","option2"]]]
                   3. BOOLEAN will create a checkbox example: ["question1",flase]
                   4. INTEGER will create a slider with max number as given example ["question1",10] wiil create a slider with up to 10
                   5. STRING will create an open text box

     Example ["My dialog",[["question1",["Option1","option2"]],["question2",["Option1","option2"]],["question3",["Option1","option2"]]],"MCC_fnc_artillery"] call MCC_fnc_initDynamicDialog
*/

private ["_title","_array","_ok","_display","_ctrlBackground","_ctrlTitle","_ctrlButtonOK","_ctrlButtonCancel","_ctrlButtonCustom","_ctrlBackgroundPos","_ctrlTitlePos","_ctrlButtonOKPos","_ctrlButtonCancelPos","_ctrlButtonCustomPos","_ctrlTitleOffsetY","_ctrlContent","_ctrlContentPos","_ctrlContentOffsetY","_posY"];
disableSerialization;

#define IDC_OK  10007
#define IDC_CANCEL 2
#define IDC_BASE 100
#define DEFAULT_WIDTH (11*(((safezoneW / safezoneH) min 1.2)/40))
#define DEFAULT_HEIGHT (1*((((safezoneW / safezoneH) min 1.2)/1.2)/25))

_title = [_this, 0, "", [""]] call BIS_fnc_param;
_array = [_this, 1, [], [[]]] call BIS_fnc_param;
_function = [_this, 2, "", [""]] call BIS_fnc_param;

//avoid double
if (tolower str (findDisplay 1031982) != "no display") exitWith {[]};

_ok = createDialog "MCC_DynamicDialog";
waitUntil {dialog};

_display = findDisplay 1031982;
_ctrlBackground = _display displayctrl 10001;
_ctrlTitle = _display displayctrl 10002;
_ctrlContent = _display displayctrl 10003;
_ctrlButtonOK = _display displayctrl IDC_OK;
_ctrlButtonCancel = _display displayctrl IDC_CANCEL;
_ctrlButtonCustom = _display displayctrl 10006;

missionNamespace setVariable ["MCC_DynamicDialogOK",false];
_ctrlButtonOK ctrlSetEventHandler ["ButtonClick", "missionNamespace setVariable ['MCC_DynamicDialogOK', true];"];

_ctrlBackgroundPos = ctrlposition _ctrlBackground;
_ctrlTitlePos = ctrlposition _ctrlTitle;
_ctrlContentPos = ctrlposition _ctrlContent;
_ctrlButtonOKPos = ctrlposition _ctrlButtonOK;
_ctrlButtonCancelPos = ctrlposition _ctrlButtonCancel;
_ctrlButtonCustomPos = ctrlposition _ctrlButtonCustom;

_ctrlTitleOffsetY = (_ctrlBackgroundPos select 1) - (_ctrlTitlePos select 1) - (_ctrlTitlePos select 3);
_ctrlContentOffsetY = (_ctrlContentPos select 1) - (_ctrlBackgroundPos select 1);

_posY = (_ctrlContentPos select 1) - (_ctrlBackgroundPos select 1);

//Set tittle
_ctrlTitle ctrlSetText _title;
_ctrlTitle ctrlCommit 0;

//Set the control groups
private ["_question","_options","_controlTittle","_control","_index","_ctrls"];
_ctrls = [];
{
    _question = _x select 0;
    _options = _x select 1;

    //tittle
    _controlTittle = _display ctrlCreate ["RscText", -1,_ctrlContent];
    _controlTittle ctrlSetPosition [0, _posY, DEFAULT_WIDTH, DEFAULT_HEIGHT];
    _controlTittle ctrlSetText _question;
    _controlTittle ctrlCommit 0;

    //If the option is an array then create a combobox
    if (typeName _options == typeName []) then {
        //combo
        _control = _display ctrlCreate ["RscCombo", IDC_BASE + _forEachIndex,_ctrlContent];
        _control ctrlSetPosition [DEFAULT_WIDTH*1.1, _posY, DEFAULT_WIDTH, DEFAULT_HEIGHT];
        _control ctrlCommit 0;

        {
            //do we have combo box with pic
            if (typeName _x == typeName []) then {
                _index = _control lbAdd (_x select 0);
                _control lbsetpicture [_index, (_x select 1)];
            } else {
                 _control lbAdd _x;
            };

        } forEach _options;

        _control lbSetCurSel 0;
    };

    //If the option is boolean
    if (typeName _options == typeName true) then {
        //combo
        _control = _display ctrlCreate ["RscCheckbox", IDC_BASE + _forEachIndex,_ctrlContent];
        _control ctrlSetPosition [DEFAULT_WIDTH*1.5, _posY, DEFAULT_WIDTH/4, DEFAULT_HEIGHT];
        _control cbSetChecked  _options;
        _control ctrlCommit 0;
    };

    //If the option is number create slider
    if (typeName _options == typeName 1) then {
        //combo
        _control = _display ctrlCreate ["RscXSliderH", IDC_BASE + _forEachIndex,_ctrlContent];
        _control ctrlSetPosition [DEFAULT_WIDTH*1.1, _posY, DEFAULT_WIDTH, DEFAULT_HEIGHT];
        _control sliderSetRange [0, _options];
        _control sliderSetPosition (_options/2);
        _control ctrlSetEventHandler ["SliderPosChanged", "(_this select 0) ctrlSetTooltip str floor (_this select 1)"];
        _control ctrlCommit 0;
    };

    //If the option is an empty string create a text box
    if (typeName _options == typeName "") then {
        _control = _display ctrlCreate ["RscEdit", IDC_BASE + _forEachIndex,_ctrlContent];
        _control ctrlSetPosition [DEFAULT_WIDTH*1.1, _posY, DEFAULT_WIDTH, DEFAULT_HEIGHT];
        _control ctrlCommit 0;
    };

    _ctrls pushBack _control;
    _posY = _posY + DEFAULT_HEIGHT*1.2;
} forEach _array;

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

_ctrlButtonCancelPos set [1,0.5 + _posH + _ctrlTitleOffsetY];
_ctrlButtonCancel ctrlsetposition _ctrlButtonCancelPos;
_ctrlButtonCancel ctrlcommit 0;

_ctrlButtonCustomPos set [1,0.5 + _posH + _ctrlTitleOffsetY];
_ctrlButtonCustom ctrlsetposition _ctrlButtonCustomPos;
_ctrlButtonCustom ctrlsetText "";
_ctrlButtonCustom ctrlcommit 0;
_ctrlButtonCustom ctrlShow false;

//wait till the dialog is canceled or confirmed
waitUntil {(missionNamespace getVariable ["MCC_DynamicDialogOK",false]) || (tolower str (findDisplay 1031982) == "no display")};

//get the resaults
private ["_resaults","_ctrl"];
_resaults = [];

//if cancel exit
if !(missionNamespace getVariable ["MCC_DynamicDialogOK",false]) exitWith {_resaults};

{
    _ctrl = _x;
    if (ctrlClassName _ctrl == "RscCombo") then {_resaults pushBack (lbCurSel _ctrl)};
    if (ctrlClassName _ctrl == "RscCheckbox") then {_resaults pushBack (cbChecked _ctrl)};
    if (ctrlClassName _ctrl == "RscXSliderH") then {_resaults pushBack (sliderPosition _ctrl)};
    if (ctrlClassName _ctrl == "RscEdit") then {_resaults pushBack (ctrlText _ctrl)};
} forEach _ctrls;

//if ok
closeDialog 0;

_resaults;