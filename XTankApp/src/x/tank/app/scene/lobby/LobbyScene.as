package x.tank.app.scene.lobby
{
	import flash.display.Sprite;
	
	import x.game.layer.scene.IAbstractScene;
	import x.game.manager.UIManager;
	import x.game.ui.XComponent;
	
	public class LobbyScene extends XComponent implements IAbstractScene
	{
		private static var _instance:LobbyScene ;
		
		public static function get instance():LobbyScene
		{
			if(_instance == null)
			{
				_instance = new LobbyScene() ;
			}
			return _instance ;
		}
		
		private var _gateway:LobbyGateWay ;
		
		public function LobbyScene()
		{
			super(UIManager.getSprite("LobbyScene_UI")) ;
			initLobbySkin() ;
			_gateway = new LobbyGateWay(this) ;
		}
		
		override public function dispose():void
		{
			super.dispose() ;
		}
		
		public function set activeScene(value:Boolean):void
		{
			
		}
		
		public function get skin():Sprite
		{
			return _skin as Sprite;
		}
		
		private function initLobbySkin():void
		{
			
		}
	}
}