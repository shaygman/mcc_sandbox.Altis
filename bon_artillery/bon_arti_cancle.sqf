//by Bon_Inf*

_requestor = _this;

[playerSide,"HQ"] sidechat "Fire Mission canceled";
CloseDialog 0;

// clean up
MCC_server setVariable [format["Arti_%1_requestor",playerSide],ObjNull,true];
_requestor setVariable ["requesting_cannons",nil,true];

for "_i" from 1 to HW_Arti_CannonNumber do {
	_requestor setVariable [format["Arti_%2_Cannon%1",_i,playerSide],nil,true];
	_requestor setVariable [format["Arti_%2_Cannon%1summary",_i,playerSide],nil,false];
};

arty_LastData = nil;
_requestor setVariable ["Arti_adj_splashpos",nil,false];


if(true) exitWith{};