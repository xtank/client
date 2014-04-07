package x.tank.app.scene.lobby
{
	import flash.display.Sprite;
	
	import onlineproto.cs_get_room_list;
	
	import x.game.layer.LayerManager;
	import x.game.layer.scene.IAbstractScene;
	import x.game.manager.UIManager;
	import x.game.net.post.CallbackPost;
	import x.game.tick.FrameTicker;
	import x.game.ui.XComponent;
	import x.game.ui.flipbar.FlipBarInitData;
	import x.game.ui.flipbar.IFilpBarHost;
	import x.game.ui.flipbar.XMultiFlipBar;
	import x.game.util.DisplayUtil;
	import x.tank.app.scene.lobby.view.LobbyRoomView;
	import x.tank.core.event.RoomEvent;
	import x.tank.core.manager.RoomManager;
	import x.tank.net.CommandSet;

	public class LobbyScene extends XComponent implements IAbstractScene,IFilpBarHost
	{
		private static var _instance:LobbyScene;

		public static function get instance():LobbyScene
		{
			if (_instance == null)
			{
				_instance = new LobbyScene();
			}
			return _instance;
		}

		private var _gateway:LobbyGateWay;
		//
		private var _roomView:Vector.<LobbyRoomView> ;
		private var _flipBar:XMultiFlipBar ;
		//
		private var _needRender:Boolean;
		private var _roomEventStack:Vector.<RoomEvent> = new Vector.<RoomEvent>();

		public function LobbyScene()
		{
			super(UIManager.getSprite("LobbyScene_UI"));
			initLobby();
			_gateway = new LobbyGateWay(this);
		}

		private function initLobby():void
		{
			// 1. init skins
			_roomView = new Vector.<LobbyRoomView>() ;
			// 
			_flipBar = new XMultiFlipBar(new FlipBarInitData(6,this),_skin["flipbar"]) ;
			// 2. init event
			RoomManager.addEventListener(RoomEvent.ROOM_LIST_UPDATE,onRoomListUpdate) ;
			RoomManager.addEventListener(RoomEvent.ROOM_ADD, onRoomUpdateStack);
			RoomManager.addEventListener(RoomEvent.ROOM_UPDATE, onRoomUpdateStack);
			RoomManager.addEventListener(RoomEvent.ROOM_DEL, onRoomUpdateStack);
		}
		
		private function onRoomListUpdate(event:RoomEvent):void
		{
			_needRender = true ;
			//
			_roomEventStack.splice(0,_roomEventStack.length-1) ;
			_flipBar.dataProvide = RoomManager.getRooms() ;
		}

		private function onRoomUpdateStack(event:RoomEvent):void
		{
			_needRender = true ;
			_roomEventStack.push(event);
		}

		/** 场景渲染 */
		public function renderer(dtime:Number):void
		{
			if (_needRender)
			{
				_needRender = false;
				// update room view
				if (_roomEventStack.length > 0)
				{
					var roomEvent:RoomEvent ;
					while(_roomEventStack.length > 0)
					{
						roomEvent = _roomEventStack.shift() ;
						switch(roomEvent.type)
						{
							case RoomEvent.ROOM_ADD:
								break;
							case RoomEvent.ROOM_DEL:
								break;
							case RoomEvent.ROOM_UPDATE:
								break;
						}
					}
				}
				
				// extra view processor
			}
		}

		override public function dispose():void
		{
			_gateway.dispose();
			_gateway = null;
			super.dispose();
		}

		private var _activable:Boolean;
		private var _tickerIndex:int;

		public function set activeScene(value:Boolean):void
		{
			_activable = value;
			if (_activable)
			{
				if (_tickerIndex != 0)
				{
					FrameTicker.clearInterval(_tickerIndex);
					_tickerIndex = 0;
				}
				_needRender = true;
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

		//  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //

		private var _count:uint = 0;

		public function showLobby():void
		{
			activeScene = true;
			LayerManager.sceneLayer.addScene(this);
			//
			_count = 0;
			$getRoomList();
		}

		public function hideLobby():void
		{
			activeScene = false;
			_gateway.blockCommands();
			DisplayUtil.removeForParent(skin, false);
		}

		//  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //  ==  //
		private function $getRoomList():void
		{
			// 获取房间列表 [3次失败重试]
			if (_count < 3)
			{
				var msg:cs_get_room_list = new cs_get_room_list();
				new CallbackPost(CommandSet.$151.id, msg, function():void
				{
					_count = 0;
				}, function():void
				{
					_count++;
					$getRoomList();
				}).send();
			}
		}
		
		public function updatePageData(data:Array):void 
		{
			//更新当前页数据
		}
	}
}
