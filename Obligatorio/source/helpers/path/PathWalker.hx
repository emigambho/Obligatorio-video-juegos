package helpers.path;
import openfl.geom.Point;

enum PlayMode
{
	Loop;
	Pong;
	None;
}

class PathWalker
{
	private var mPath:IPath;
	private var mTotalTime:Float;
	private var mTime:Float=0;
	private var mPlayMode:PlayMode;

	public var x(get, null):Float;
	public var y(get, null):Float;

	private var mDirection:Int;

	private var mPosition:Point;

	public static function fromSpeed(aPath:IPath, aSpeed:Float, aPlayMode:PlayMode):PathWalker
	{
		return new PathWalker(aPath, aPath.getLength() / aSpeed, aPlayMode);
	}

	public function new(aPath:IPath,aTotalTime:Float,aPlayMode:PlayMode)
	{
		mPlayMode = aPlayMode;
		mPath = aPath;
		mTotalTime = aTotalTime;
		mPosition = new Point();
		mDirection = 1;
	}

	public function update(aDt:Float):Void
	{
		var s = nextPosition(aDt);
		var pos= mPath.getPos(s);
		mPosition.setTo(pos.x, pos.y);
	}

	private function nextPosition(aDt:Float):Float
	{
		mTime+= aDt*mDirection;
		var s:Float = mTime / mTotalTime;

		if (mPlayMode==PlayMode.Pong)
		{
			if (s > 1)
			{
				s = 1;
				mDirection = -1;
			}
			else if (s<0)
			{
				s = 0;
				mDirection = 1;
			}
		}
		else if (mPlayMode==PlayMode.None)
		{
			if (s > 1)
			{
				s = 1;
				mTime = mTotalTime;
				mDirection = 0;
			}
		}
		else if (mPlayMode==PlayMode.Loop)
		{
			if (s > 1)
			{
				s = 0;
				mTime = 0;
				mDirection = 1;
			}
		}
		return s;
	}

	private function get_x():Float
	{
		return mPosition.x;
	}

	private function get_y():Float
	{
		return mPosition.y;
	}

	public function finish():Bool
	{
		return mTime == mTotalTime && mPlayMode == PlayMode.None;
	}

	public function reset():Void
	{
		mTime = 0;
		mDirection = 1;
	}
}