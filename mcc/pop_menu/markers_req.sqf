
#define MCC_MARKER_TEXT 3050
#define MCC_MARKER_COLOR 3051
#define MCC_MARKER_TYPE 3052
#define MCC_MARKER_SHAPE 3053
#define MCC_MARKER_BRUSH 3054
#define MCC_MARKER_AVAILABE 3049

disableSerialization;

private ["_case","_dlg","_pos","_comboBox","_displayname","_index","_time","_count"];
_case = _this select 0;
_dlg = (uiNamespace getVariable "MCC_groupGen_Dialog");
_count = count (missionNamespace getVariable ["MCC_activeMarkers",[]]);
MCC_Marker_dir = 0;

switch (_case) do
{
	case 0:		//create marker
	{
		Mcase = _case;
		Mcolor = (MCC_colorsarray select (lbCurSel MCC_MARKER_COLOR)) select 1;
		Mshape = (MCC_shapeMarker select (lbCurSel MCC_MARKER_SHAPE));
		Msize = [1,1];
		Mbrush = (MCC_brushesarray select (lbCurSel MCC_MARKER_BRUSH)) select 2;
		Mtype = (MCC_markerarray select (lbCurSel MCC_MARKER_TYPE)) select 2;
		Mtext = ctrlText (_dlg displayCtrl MCC_MARKER_TEXT);
		hint "Left click on the map to set a marker";
		onMapSingleClick " 	hint 'marker added.';
							[Mcase, Mcolor, Msize, Mshape, Mbrush, Mtype, Mtext, _pos, MCC_Marker_dir] call MCC_fnc_makeMarker;
							onMapSingleClick """";";
	};

   case 1:	//create Brush
	{
		Mcase = _case;
		Mcolor = (MCC_colorsarray select (lbCurSel MCC_MARKER_COLOR)) select 1;
		Mshape = (MCC_shapeMarker select (lbCurSel MCC_MARKER_SHAPE));
		Mbrush = (MCC_brushesarray select (lbCurSel MCC_MARKER_BRUSH)) select 2;
		Mtype = (MCC_markerarray select (lbCurSel MCC_MARKER_TYPE)) select 2;
		Mtext = ctrlText (_dlg displayCtrl MCC_MARKER_TEXT);
		MCC_brush_drawing = true;
		hint "Left click and drag on the mini-map to create a brush";
	};

  case 2:	//Delete Markers
	{
		if ((lbCurSel MCC_MARKER_AVAILABE)== -1) exitWith {};
		Mcase = _case;
		Mcolor = (MCC_colorsarray select (lbCurSel MCC_MARKER_COLOR)) select 1;
		Msize = [1,1];
		Mshape = (MCC_shapeMarker select (lbCurSel MCC_MARKER_SHAPE));
		Mbrush = (MCC_brushesarray select (lbCurSel MCC_MARKER_BRUSH)) select 2;
		Mtype = (MCC_markerarray select (lbCurSel MCC_MARKER_TYPE)) select 2;
		Mtext = MCC_activeMarkers select (lbCurSel MCC_MARKER_AVAILABE);
		_pos = [];
		[Mcase, Mcolor, Msize, Mshape, Mbrush, Mtype, Mtext, _pos, 0] call MCC_fnc_makeMarker;
	};
};

//Refresh
_time = time + 10;

waituntil {count (missionNamespace getVariable ["MCC_activeMarkers",[]]) != _count || time > _time};

_comboBox = (_dlg displayCtrl 3049);		//fill Available Markers
lbClear _comboBox;
{
	_displayname = _x;
	_index = _comboBox lbAdd _displayname;
} foreach MCC_activeMarkers;
_comboBox lbSetCurSel 0;