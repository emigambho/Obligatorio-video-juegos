package helpers.path;
import openfl.geom.Point;

interface IPath
{
	function getPos(aScalar:Float):Point;
	function getLength():Float;
}