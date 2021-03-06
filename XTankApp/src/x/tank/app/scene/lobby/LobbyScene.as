package x.tank.app.scene.lobby
{
	import flash.display.Sprite;
	
	import onlineproto.cs_get_room_list;
	
	import x.game.layer.LayerManager;
	import x.game.layer.scene.IAbstractScene;
	import x.game.manager.UIManager;
	import x.game.net.post.CallbackPost;
	import x.game.net.response.XMessageEvent;
	import x.game.tick.FrameTicker;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.cfg.TankConfig;
	import x.tank.app.scene.SceneEvent;
	import x.tank.app.scene.SceneManager;
	import x.tank.app.scene.lobby.view.RoomListView;
	import x.tank.app.scene.lobby.view.UserInfoView;
	import x.tank.core.manager.PlayerManager;
	import x.tank.net.CommandSet;

	/** 大厅 */
	public class LobbyScene extends XComponent implements IAbstractScene
	{
		private var _activable:Boolean;
		private var _tickerIndex:int;
		private var _gateway:LobbyGateWay;
		private var _roomList:RoomListView ;
		private var _userInfo:UserInfoView ;

		public function LobbyScene()
		{
			super(UIManager.getSprite("LobbyScene_UI"));
			initLobby();
			_gateway = new LobbyGateWay(this);
		}

		private function initLobby():void
		{
			// 1. init skins
			_roomList = new RoomListView(_skin["roomListUI"]) ;
			_userInfo = new UserInfoView(_skin["userInfoUI"]) ;
		}

		/** 场景渲染 */
		public function renderer(dtime:Number):void
		{
			_roomList.renderer(dtime) ;
		}

		override public function dispose():void
		{
			_gateway.dispose();
			_gateway = null;
			//
			_userInfo.dispose() ;
			_userInfo = null ;
			//
			_roomList.dispose() ;
			_roomList = null ;
			super.dispose();
		}

		private function set activeScene(value:Boolean):void
		{
			_activable = value;
			if (_activable)
			{
				if (_tickerIndex != 0)
				{
					FrameTicker.clearInterval(_tickerIndex);
					_tickerIndex = 0;
				}
				needRender = true;
				_tickerIndex = FrameTicker.setInterval(renderer, 1);
			}
			else
			{
				if (_tickerIndex != 0)
				{
					FrameTicker.clearInterval(_tickerIndex);
					_tickerIndex = 0;
				}
			}
		}

		public function get skin():Sprite
		{
			return _skin as Sprite;
		}
		
		public function set needRender(value:Boolean):void
		{
			_roomList.needRender = value ;
		}

		//  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //
		//  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //

		private var _count:uint = 0;

		public function showLobby():void
		{
			activeScene = true;
			LayerManager.sceneLayer.addScene(this);
			//
			_count = 0;
			$getRoomList(); // 拉取当前大厅的房间列表
			_userInfo.updateInfo(PlayerManager.getPlayer(TankConfig.userId)) ;
			//
			SceneManager.dispatchEvent(new SceneEvent(SceneEvent.SHOW_LOBBY)) ;
		}

		public function hideLobby():void
		{
			activeScene = false;
			DisplayObjectUtil.removeFromParent(skin, false);
			//
			SceneManager.dispatchEvent(new SceneEvent(SceneEvent.HIDE_LOBBY)) ;
		}

		private function $getRoomList():void
		{
			// 获取房间列表 [3次失败重试]
			if (_count < 3)
			{
				var msg:cs_get_room_list = new cs_get_room_list();
				new CallbackPost(CommandSet.$151.id, msg, function(event:XMessageEvent):void
				{
					_count = 0;
				}, function(event:XMessageEvent):void
				{
					_count++;
					$getRoomList();
				}).send();
			}
		}
	}
}
