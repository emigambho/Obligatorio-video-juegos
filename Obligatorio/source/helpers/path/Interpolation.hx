package helpers.path;

class Interpolation
{
	public static inline function LERP(aA:Float, aB:Float, aS:Float):Float
	{
		return aB * aS - aA * (aS - 1);
	}
}
