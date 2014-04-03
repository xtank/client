package x.tank.app.scene.lobby
{
	import x.tank.app.scene.gateway.MessageGateWay;
	import x.tank.app.scene.lobby.net.RoomUpdateProcessor;
	
	public class LobbyGateWay extends MessageGateWay
	{
		public function LobbyGateWay(scene:LobbyScene)
		{
			super(scene);
		}
		
		/**  需要阻塞的消息 */
		override protected function blockCommands():void
		{
			// override by child
		}
		
		override protected function initMessageHandler():void
		{
			// override by child
			addMessageHandler(new RoomUpdateProcessor(_scene as LobbyScene));
		}
		
		override protected function realseCommands():void
		{
			// override by child
		}
	}
}