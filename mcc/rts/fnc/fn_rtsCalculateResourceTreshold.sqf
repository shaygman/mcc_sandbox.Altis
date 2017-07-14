/*================================================================MCC_fnc_rtsCalculateResourceTreshold============================================================
//  calculate resources tresholds
//  Parameter(s):
//     0: OBJECT - objct to which items will be added
//     1: STRING or ARRAY of STRINGs - item class(es) to be added
//==============================================================================================================================================================*/
#define    MCC_RTS_BUILDING_DUMMY_ANCHOR    "UserTexture10m_F"

private ["_buildings","_playerSide","_resourceType","_returnValue"];
_resourceType = param [0,"",["",[]]];
_playerSide = param [1,sideLogic,[sideLogic]];

_buildings = allMissionObjects MCC_RTS_BUILDING_DUMMY_ANCHOR;

//If sent only one resource put it in array
if (typeName _resourceType isEqualTo typeName "") then {
    _resourceType = [_resourceType];
};

_returnValue = [];
{
    _returnValue pushBack (switch (tolower _x) do
                                {
                                    case "resources":
                                    {
                                        1000 + (({(_x getVariable ["mcc_constructionItemType",""]) == "storage" && !(isNull attachedTo _x) && _x getVariable ["mcc_side",sideLogic] isEqualTo _playerSide} count _buildings) * 500);
                                    };

                                     case "units":
                                    {
                                        4 + (({(_x getVariable ["mcc_constructionItemType",""]) == "barracks" && !(isNull attachedTo _x) && _x getVariable ["mcc_side",sideLogic] isEqualTo _playerSide} count _buildings) * 4);
                                    };

                                     case "helipads":
                                    {
                                        0 + ({(_x getVariable ["mcc_constructionItemType",""]) == "helipads" && !(isNull attachedTo _x) && _x getVariable ["mcc_side",sideLogic] isEqualTo _playerSide} count _buildings);
                                    };

                                     case "hangers":
                                    {
                                        0 + ({(_x getVariable ["mcc_constructionItemType",""]) == "hangers" && !(isNull attachedTo _x) && _x getVariable ["mcc_side",sideLogic] isEqualTo _playerSide} count _buildings);
                                    };

                                    default
                                    {
                                        0
                                    };
                                });
} forEach _resourceType;

//If only one resault return it as parmeter not an array
if (count _returnValue == 1) then {
   _returnValue = _returnValue select 0;
};

_returnValue