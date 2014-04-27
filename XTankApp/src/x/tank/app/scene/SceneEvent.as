package x.tank.app.scene
{
	import flash.events.Event;

	/**
	 * 场景派发事件
	 * @author fraser
	 *
	 */
	public class SceneEvent extends Event
	{	
		public static const SHOW_LOBBY:String = "SHOW_LOBBY";
		public static const HIDE_LOBBY:String = "HIDE_LOBBY";
		
		/** 切换场景时，传递额外的场景信息*/
		public var params:Object;

		public function SceneEvent(type:String, paramsArg:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			params = paramsArg;
		}
	}
}
