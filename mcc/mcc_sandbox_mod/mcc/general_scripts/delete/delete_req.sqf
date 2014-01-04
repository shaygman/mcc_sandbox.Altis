#define DELETE_ZONE 7040
#define DELETE_CLASS 7041

if !mcc_isloading then 
	{
		deleteRadius = (MCC_zones_x select (lbCurSel DELETE_ZONE)) select 1;
		deleteType = lbCurSel DELETE_CLASS;
		deleteFinished = false; 
		hint "Click on the map";
		onMapSingleClick " 	mcc_safe=mcc_safe + FORMAT ['
									[""delete"", [%1 , %2, %3]] call CBA_fnc_globalEvent;
									sleep 1;'								 
									, _pos
									, deleteRadius
									, deleteType
									];
							createmarkerlocal ['deletemarker12', _pos];
							'deletemarker12' setMarkerColorLocal 'ColorBlue';
							'deletemarker12' setMarkerSizeLocal [deleteRadius,deleteRadius];
							'deletemarker12' setMarkerShapeLocal  'ELLIPSE';
							'deletemarker12' setMarkerBrushLocal  'SOLID';
							['delete', [_pos, deleteRadius, deleteType]] call CBA_fnc_globalEvent;
							deleteFinished = true;
							onMapSingleClick """";";
		while {!deleteFinished} do {sleep 1;};
		sleep 0.5;
		deletemarkerlocal "deletemarker12";
		hint format ["All %1 removed from target area.",MCC_deleteTypes select deleteType];
	};
 
 

