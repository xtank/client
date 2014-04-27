package x.tank.app.scene.lobby
{
	import x.tank.app.scene.gateway.MessageGateWay;
	import x.tank.app.scene.lobby.net.GetRoomListProcessor;
	import x.tank.app.scene.lobby.net.PlayerStatusUpdateProcessor;
	import x.tank.app.scene.lobby.net.RoomUpdateProcessor;
	
	public class LobbyGateWay extends MessageGateWay
	{
		public function LobbyGateWay(scene:LobbyScene)
		{
			super(scene);
		}
		
		override protected function initMessageHandler():void
		{
			// override by child
			addMessageHandler(new RoomUpdateProcessor(_scene as LobbyScene));
			addMessageHandler(new GetRoomListProcessor(_scene as LobbyScene));
			addMessageHandler(new PlayerStatusUpdateProcessor(_scene as LobbyScene));
		}
		
		/**  需要阻塞的消息 */
		override public function blockCommands():void
		{
			// override by child
		}
		
		override public function realseCommands():void
		{
			// override by child
		}
	}
}