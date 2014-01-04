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
		deletemarkerlocal _text;
		createmarkerlocal [_text, _pos];
		_text setMarkerColorLocal _color;
		_text setMarkerTypeLocal  _type;
		_text setmarkertextlocal _text;
		MCC_sync=MCC_sync + FORMAT ['_text="%1";
									_pos=%2;
									_color="%3";
									_type = "%4";
									deletemarkerlocal _text;
									createmarkerlocal [_text, _pos];
									_text setMarkerColorLocal _color;
									_text setMarkerTypeLocal  _type;
									_text setmarkertextlocal _text;'								 
									,_text
									,_pos
									,_color
									,_type
								   ];
		publicVariable "MCC_sync"; 
		
	};
	
   case 1:	//Create Brush
   { 
		deletemarkerlocal _text;
		createmarkerlocal [_text, _pos];
		_text setMarkerColorLocal _color;
		_text setMarkerSizeLocal _size;
		_text setMarkerShapeLocal  _shape;
		_text setMarkerBrushLocal  _brush;
		MCC_sync=MCC_sync + FORMAT ['_text="%1";
									_pos=%2;
									_color ="%3";
									_size = %4;
									_shape ="%5";
									_brush ="%6";
									deletemarkerlocal _text;
									createmarkerlocal [_text, _pos];
									_text setMarkerColorLocal _color;
									_text setMarkerSizeLocal _size;
									_text setMarkerShapeLocal  _shape;
									_text setMarkerBrushLocal  _brush;'								 
									,_text
									,_pos
									,_color
									,_size
									,_shape
									,_brush
								   ];
		publicVariable "MCC_sync"; 
	};
   
    case 2: //Delete
   {deletemarkerlocal _text;};
 };