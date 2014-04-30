if (MCC_teleportToTeam) then 
	{
		hint "Teleporting";
		if (player == (leader player)) then 
		   { 
			 player setPos (getPos (((units player) - [player]) select 0));
		   }
		else
			{
			player setPos (getPos (leader player)); 
			};
		
		if ( MCC_t2tIndex < 3 ) then // 3 = always allow teleport
		{ 
			MCC_teleportToTeam = false;
		};
	} else {hint "Telpeport is N/A"};
