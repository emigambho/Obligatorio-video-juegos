package helpers.path;
import openfl.geom.Point;

class Linear implements IPath
{
	private var mPosition:Point;
	private var mStart:Point;
	private var mFinish:Point;
	private var mLength:Float;

	public function new(aStart:Point,aFinish:Point)
	{
		mPosition = new Point();
		mStart = aStart;
		mFinish = aFinish;

		mLength = Math.sqrt((mFinish.x - mStart.x) * (mFinish.x - mStart.x) + (mFinish.y - mStart.y) * (mFinish.y - mStart.y));
	}

	public function getPos(aScalar:Float):Point
	{
		mPosition.x = Interpolation.LERP(mStart.x, mFinish.x, aScalar);
		mPosition.y = Interpolation.LERP(mStart.y, mFinish.y, aScalar);
		return mPosition;
	}

	public function getLength():Float
	{
		return mLength;
	}

}