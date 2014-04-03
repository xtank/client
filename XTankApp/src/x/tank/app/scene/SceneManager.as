package x.tank.app.scene
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import x.game.layer.LayerManager;
	import x.game.layer.scene.IAbstractScene;
	import x.tank.app.scene.lobby.LobbyScene;

	/**
	 * 场景管理器
	 * @author fraser
	 * @modfiy lynx
	 */
	public class SceneManager
	{
		private static var _currentScene:IAbstractScene ;
		
		public static function showLobby():void
		{
			// 显示大厅
			LayerManager.sceneLayer.addScene(LobbyScene.instance) ;
			_currentScene = LobbyScene.instance ;
			//
			dispatchEvent(new SceneEvent(SceneEvent.SCENE_CHANG_END)) ;
		}
		
		//############################################################
		//			            Event Dispatcher		
		//############################################################
		private static var _eventDispatcher:EventDispatcher = new EventDispatcher();

		static public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		static public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		static public function dispatchEvent(event:Event):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}

		static public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}

		static public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}

	}
}
