package interfaces;

interface Item 
{
	function deploy(aX:Float, aY:Float):Void;	
	function deployFromBlock(aX:Float, aY:Float):Void;
	function pickUp():Void;
}