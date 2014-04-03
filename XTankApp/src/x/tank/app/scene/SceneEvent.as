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
		/** 开始加载地图资源 */
		public static const SCENE_LOADING_START:String = "SCENE_LOADING_START" ;
		/** 结束加载地图资源 */
		public static const SCENE_LOADING_END:String = "SCENE_LOADING_END" ;
		
		/** 场景切换开始   */
		public static const SCENE_CHANG_START:String = "SCENE_CHANG_START";
		/** 场景切换完成   */
		public static const SCENE_CHANG_END:String = "SCENE_CHANG_END";
		
		/** 切换场景时，传递额外的场景信息*/
		public var params:Object;

		public function SceneEvent(type:String, paramsArg:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			params = paramsArg;
		}
	}
}
