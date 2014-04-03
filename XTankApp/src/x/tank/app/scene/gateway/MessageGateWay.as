package x.tank.app.scene.gateway
{
	import x.game.core.IDisposeable;
	import x.game.layer.scene.IAbstractScene;
	import x.game.net.processor.IMessageProcessor;
	import x.tank.app.scene.SceneEvent;
	import x.tank.app.scene.SceneManager;


	/**
	 * 场景的网关处理
	 * @author fraser
	 *
	 */
	public class MessageGateWay implements IDisposeable
	{
		protected var _scene:IAbstractScene;
		protected var _msgHandlerVec:Vector.<IMessageProcessor>;

		public function MessageGateWay(scene:IAbstractScene)
		{
			_scene = scene;
			//
			_msgHandlerVec = new Vector.<IMessageProcessor>();
			initMessageHandler();
			//
			blockCommands();
			SceneManager.addEventListener(SceneEvent.SCENE_CHANG_END, onSwitchComplete);
		}

		/**
		 * 场景成功交替后被触发
		 * @param evt
		 *
		 */
		protected function onSwitchComplete(evt:SceneEvent):void
		{
			SceneManager.removeEventListener(SceneEvent.SCENE_CHANG_END, onSwitchComplete);
			realseCommands();
		}
		
		protected function addMessageHandler(handler:IMessageProcessor):void
		{
			handler.setup();
			_msgHandlerVec.push(handler);
		}

		protected function initMessageHandler():void
		{
			// override by child
		}

		/**  需要阻塞的消息 */
		protected function blockCommands():void
		{
			// override by child
		}

		/**
		 * 释放阻塞的消息
		 */
		protected function realseCommands():void
		{
			// override by child
		}

		public function dispose():void
		{
			for each (var handler:IMessageProcessor in _msgHandlerVec)
			{
				handler.dispose();
				handler = null;
			}
			_msgHandlerVec = null;
		}
	}
}
