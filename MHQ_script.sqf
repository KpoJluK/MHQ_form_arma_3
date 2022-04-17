/*
вставлять в инит передмета на базе для телепортации на кшм!(с 4 сточки по 20 включительно! )

[ 
 this,            
 "<t color='#ff2e2e'>Переместиться к КШМ</t>",           
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
 "_this distance _target < 3",       
 "_caller distance _target < 3",       
 {},              
 {},              
 { []spawn fnc_teleport },     
 {},              
 [],              
 1,              
 0,              
 false,             
 false             
] call BIS_fnc_holdActionAdd;
 
*/ 


params[["_mhq_1", "B_MRAP_01_F"],["_arry_pos", getPos Player]];

teleport1 = true;
publicVariable "teleport1";

// deploy_mhq

fnc_add_action_to_mhq = {

	[[], {	removeAllActions MHQ_1	}] remoteExec ["call"];

	[
		MHQ_1,											// object the action is attached to
		"<t color='#2eff5b'>Разложить КШМ</t>",										// Title of the action
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",	// Idle icon shown on screen
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",	// Progress icon shown on screen
		"_this distance _target < 5",						// Condition for the action to be shown
		"_caller distance _target < 5",						// Condition for the action to progress
		{},													// Code executed when action starts
		{},													// Code executed on every progress tick
		{		
			[]call fnc_romove_action_to_mhq;				
			teleport1 = true;
			publicVariable "teleport1";
			MHQ_1 setFuel 0;
			MHQ_1 setVehicleLock "LOCKED";
			player action ["Eject", MHQ_1];
		},				// Code executed on completion
		{},													// Code executed on interrupted
		[],													// Arguments passed to the scripts as _this select 3
		5,													// action duration in seconds
		0,													// priority
		true,												// Remove on completion
		false												// Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, MHQ_1];	// MP compatible implementation

};

// Remove MHQ

fnc_romove_action_to_mhq = {

	[[], {	removeAllActions MHQ_1	}] remoteExec ["call"];

	[
		MHQ_1,											// object the action is attached to
		"<t color='#ff2e2e'>Сложить КШМ</t>",										// Title of the action
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Idle icon shown on screen
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Progress icon shown on screen
		"_this distance _target < 5",						// Condition for the action to be shown
		"_caller distance _target < 5",						// Condition for the action to progress
		{},													// Code executed when action starts
		{},													// Code executed on every progress tick
		{	
			[]call fnc_add_action_to_mhq;
			teleport1 = false;
			publicVariable "teleport1";
			MHQ_1 setFuel 1;
			MHQ_1 setVehicleLock "UNLOCKED";
		},				// Code executed on completion
		{},													// Code executed on interrupted
		[],													// Arguments passed to the scripts as _this select 3
		5,													// action duration in seconds
		0,													// priority
		true,												// Remove on completion
		false												// Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, MHQ_1];	// MP compatible implementation

};


// teleport to MHQ

fnc_teleport = {

	if (teleport1)then{
		player setPos(MHQ_1 getPos [selectRandom [6,8,10],random 360]);
	}else{
		hint"КШМ не развернута!";
		sleep 5;
		hint"";
	};

};

publicVariable "fnc_add_action_to_mhq";
publicVariable "fnc_romove_action_to_mhq";
publicVariable "fnc_teleport";

Teleport_mhq = True;

[_mhq_1,_arry_pos] spawn{
	params["_class_name_mhq_1","_arry_pos"];
	waitUntil{
		MHQ_1 = _class_name_mhq_1 createVehicle _arry_pos;
		[MHQ_1, 1] call ace_cargo_fnc_setSize;
		publicVariable "MHQ_1";

		[]call fnc_add_action_to_mhq;

		waitUntil{
			sleep 5;
			!alive MHQ_1 or isNil {MHQ_1}
		};

		deleteVehicle MHQ_1;

		teleport1 = false;
		publicVariable "teleport1";

		!Teleport_mhq
	};
};
