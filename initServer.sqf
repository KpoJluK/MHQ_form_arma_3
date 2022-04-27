[
	"B_MRAP_01_F",	//- класс нейм КШМ
	[0,0,0]		//- кординаты где он будет появлятся в начале и после смерти, можно использовать поизцию предмета getPos player или позицию маркера getMarkerPos "Marker_1"
] execVM "MHQ_script.sqf";




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
