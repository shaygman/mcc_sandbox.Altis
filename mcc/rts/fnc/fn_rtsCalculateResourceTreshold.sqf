/*================================================================MCC_fnc_rtsCalculateResourceTreshold============================================================
    calculate resources tresholds
    Parameter(s):
        0: STRING/ARRAY of STRINGS   _resourceType     - string or array of strings of the resources to return can be ["resources","units","electricity"]
        1: SIDE                      _playerSide       - Side of buildings
        2: BOOLEAN                   _returnBuildings  - If true will return an array of all buildings that provide the resources in arrays at the same order as asked

    Example:
    [["resources","units"],west,true] call MCC_fnc_rtsCalculateResourceTreshold
    will return
    [1000,200,[[storage1,storage2],[barracks1]]]
//==============================================================================================================================================================*/
#define    MCC_RTS_BUILDING_DUMMY_ANCHOR    "UserTexture10m_F"

private ["_buildings","_playerSide","_resourceType","_returnValue","_subTotal","_type","_returnBuildings","_buildingsReturned","_subBuildings"];
_resourceType = param [0,"",["",[]]];
_playerSide = param [1,sideLogic,[sideLogic]];
_returnBuildings = param [2,false,[false]];

//If sent only one resource put it in array
if (typeName _resourceType isEqualTo typeName "") then {
    _resourceType = [_resourceType];
};

//Get all the RTS buildings
_buildings = [];
{
    if (!(isNull attachedTo _x) && _x getVariable ["mcc_side",sideLogic] isEqualTo _playerSide) then {
        _buildings pushBack _x;
    };
} forEach (allMissionObjects MCC_RTS_BUILDING_DUMMY_ANCHOR);

_buildingsReturned = [];
_returnValue = [];
{
    _type = tolower _x;
    _subTotal = 0;
    _subBuildings =[];
    {
        switch (_type) do
        {
            case "resources":
            {
                if (toLower(_x getVariable ["mcc_constructionItemType",""]) isEqualTo "storage") then {
                    _subTotal = _subTotal + ((_x getVariable ["mcc_constructionItemTypeLevel",1])*500);

                    if (_returnBuildings) then {_subBuildings pushBack _x};
                };

                if (toLower(_x getVariable ["mcc_constructionItemType",""]) isEqualTo "hq") then {
                    _subTotal = _subTotal + 1000;
                };
            };

            case "units":
            {
                if (toLower(_x getVariable ["mcc_constructionItemType",""]) isEqualTo "house") then {
                    _subTotal = _subTotal + ((_x getVariable ["mcc_constructionItemTypeLevel",1])*4);

                     if (_returnBuildings) then {_subBuildings pushBack _x};
                };

                if (toLower(_x getVariable ["mcc_constructionItemType",""]) isEqualTo "hq") then {
                    _subTotal = _subTotal + 8;
                };
            };

            case "helipads":
            {
            };

            case "hangers":
            {
            };

             case "electricity":
            {
                if (toLower(_x getVariable ["mcc_constructionItemType",""]) isEqualTo "elecPower") then {

                    //3rd level generator is solar powered and does not concern fuel
                    if ((_x getVariable ["mcc_constructionItemTypeLevel",1])<3) then {
                        _subTotal = _subTotal + ((_x getVariable ["mcc_constructionItemTypeLevel",1])*2);
                    };

                    if (_returnBuildings) then {_subBuildings pushBack _x};
                };
            };

            default
            {
                0
            };
        };
    } forEach _buildings;

    _returnValue pushBack _subTotal;
    _buildingsReturned pushBack _subBuildings;
} forEach _resourceType;

//If only one resault return it as parmeter not an array
if (count _returnValue == 1 && !_returnBuildings) exitWith {
   _returnValue select 0
};

if (_returnBuildings) exitWith {
   _index = _returnValue pushBack _buildingsReturned;
   _returnValue
};

_returnValue