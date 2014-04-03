package x.game.core
{
	public interface ISubject extends IDisposeable
	{
        /**  */
		function addObserver(observer:IObserve,aspect:Function):Boolean ;
        /**  */
		function removeObserver(oberver:IObserve):Boolean ;
	}
}