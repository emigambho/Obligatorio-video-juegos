package helpers;

typedef FSM = FiniteStateMachine;

class FiniteStateMachine
{

	public var activeState:Float->Void;

	public function new():Void
	{
		activeState = null;
	}

	public function update(elapsed:Float):Void
	{
		if (activeState != null)
			activeState(elapsed);
	}
}