disableSerialization;
private ["_case","_color","_size","_shape","_brush","_type","_text","_pos"];

_case = _this select 0;
_color = _this select 1;
_size = _this select 2;
_shape = _this select 3;
_brush = _this select 4;
_type = _this select 5;
_text = _this select 6; 
_pos = _this select 7; 

mcc_safe=mcc_safe + FORMAT ['	_case=%1;
								_color="%2";
								_size=%3;
								_shape = "%4";
								_brush="%5";
								_type="%6";
								_text="%7";
								_pos = %8;
								[[_case, _color, _size, _shape, _brush, _type, _text, _pos],"MCC_fnc_makeMarker",true,false] spawn BIS_fnc_MP;
								'								 
								,_case
								,_color
								,_size
								,_shape
								,_brush
								,_type
								,_text
								,_pos
							   ];
switch (_case) do
{
   case 0:		//Create Marker
	{
		deleteMarker _text;
		createMarker [_text, _pos];
		_text setMarkerColor _color;
		_text setMarkerType  _type;
		_text setmarkertext _text;
	};
	
   case 1:	//Create Brush
   { 
		deleteMarker _text;
		createMarker [_text, _pos];
		_text setMarkerColorLocal _color;
		_text setMarkerSizeLocal _size;
		_text setMarkerShapeLocal  _shape;
		_text setMarkerBrushLocal  _brush;
	};
   
    case 2: //Delete
   {deleteMarker _text;};
 };
 