#define MCC_SANDBOX3_IDD 3000
#define MCC_MARKER_TEXT 3050
#define MCC_MARKER_COLOR 3051
#define MCC_MARKER_TYPE 3052
#define MCC_MARKER_SHAPE 3053
#define MCC_MARKER_BRUSH 3054

disableSerialization;

private ["_case","_dlg","_pos"];
_case = _this select 0;
_dlg = findDisplay MCC_SANDBOX3_IDD;

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
								[[Mcase, Mcolor, Msize, Mshape, Mbrush, Mtype, Mtext, _pos],'MCC_fnc_makeMarker',true,false] spawn BIS_fnc_MP;
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
	   {Mcase = _case; 
		Mcolor = (MCC_colorsarray select (lbCurSel MCC_MARKER_COLOR)) select 1;
		Msize = [1,1];
		Mshape = (MCC_shapeMarker select (lbCurSel MCC_MARKER_SHAPE));
		Mbrush = (MCC_brushesarray select (lbCurSel MCC_MARKER_BRUSH)) select 2;
		Mtype = (MCC_markerarray select (lbCurSel MCC_MARKER_TYPE)) select 2;
		Mtext = ctrlText (_dlg displayCtrl MCC_MARKER_TEXT);
		_pos = [];
		[[Mcase, Mcolor, Msize, Mshape, Mbrush, Mtype, Mtext, _pos],"MCC_fnc_makeMarker",true,false] spawn BIS_fnc_MP;
	   };
	};