package x.tank.app.scene.lobby.view
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import x.game.alert.AlertManager;
	import x.game.module.ModuleManager;
	import x.game.ui.XComponent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XButton;
	import x.game.ui.button.XSimpleButton;
	import x.game.ui.buttonbar.XButtonBar;
	import x.game.ui.flipbar.FlipBarInitData;
	import x.game.ui.flipbar.IFilpBarHost;
	import x.game.ui.flipbar.XMultiFlipBar;
	import x.tank.app.cfg.ModuleName;
	import x.tank.app.processor.alert.SimpleAlertProcessor;
	import x.tank.core.event.RoomEvent;
	import x.tank.core.manager.RoomManager;
	
	public class RoomListView extends XComponent implements IFilpBarHost
	{
		private var _btnBar:XButtonBar ;
		private var _roomView:Vector.<LobbyRoomView> ;
		//
		private var _flipBar:XMultiFlipBar ;
		private var _fastAddBtn:XSimpleButton ;
		private var _findBtn:XSimpleButton ;
		private var _createBtn:XSimpleButton ;
		//
		private var _needRender:Boolean;
		
		public function RoomListView(skin:DisplayObject)
		{
			super(skin);
			_btnBar = new XButtonBar(skin["btnBar"]);
			_btnBar.addButton(new XButton(_btnBar.skin["allRadioBtn"],0),true) ;
			_btnBar.addButton(new XButton(_btnBar.skin["waitRadioBtn"],1)) ;
			_btnBar.addButton(new XButton(_btnBar.skin["pvpRadioBtn"],2)) ;
			_btnBar.addButton(new XButton(_btnBar.skin["pveRadioBtn"],3)) ;
			_btnBar.addButton(new XButton(_btnBar.skin["exercisesRadioBtn"],4)) ;
			//
			_fastAddBtn = new XSimpleButton(_skin["fastAddBtn"]) ;
			_fastAddBtn.addClick(onFastAddClick) ;
			//
			_findBtn = new XSimpleButton(_skin["findBtn"]) ;
			_findBtn.addClick(onFindClick) ;
			//
			_createBtn = new XSimpleButton(_skin["createBtn"]) ;
			_createBtn.addClick(onCreateClick) ;
			//
			_roomView = new Vector.<LobbyRoomView>() ;
			_roomView.push(new LobbyRoomView(_skin["roomView1"])) ;
			_roomView.push(new LobbyRoomView(_skin["roomView2"])) ;
			_roomView.push(new LobbyRoomView(_skin["roomView3"])) ;
			_roomView.push(new LobbyRoomView(_skin["roomView4"])) ;
			_roomView.push(new LobbyRoomView(_skin["roomView5"])) ;
			_roomView.push(new LobbyRoomView(_skin["roomView6"])) ;
			// 
			_flipBar = new XMultiFlipBar(new FlipBarInitData(6,this),_skin["flipbar"]) ;
			// 2. init event
			RoomManager.addEventListener(RoomEvent.ROOM_LIST_UPDATE,updateRenderer) ;
			RoomManager.addEventListener(RoomEvent.ROOM_ADD, updateRenderer);
			RoomManager.addEventListener(RoomEvent.ROOM_UPDATE, updateRenderer);
			RoomManager.addEventListener(RoomEvent.ROOM_DEL, updateRenderer);
		}
		
		override public function dispose():void
		{
			_btnBar.dispose() ;
			_btnBar = null ;
			//
			_flipBar.dispose() ;
			_flipBar = null ;
			//
			_fastAddBtn.dispose() ;
			_fastAddBtn = null ;
			//
			_findBtn.dispose() ;
			_findBtn = null ;
			//
			_createBtn.dispose() ;
			_createBtn = null ;
			//
			super.dispose() ;
		}
		
		public function set needRender(value:Boolean):void
		{
			_needRender = value ;
		}
		
		public function updatePageData(pageData:Array):void 
		{
			// 更新当前页数据
			var len:uint = _roomView.length ;
			for(var i:uint = 0;i<len;i++)
			{
				if(i < pageData.length)
				{
					_roomView[i].data = pageData[i] ;
				}
				else
				{
					_roomView[i].data = null ;
				}
			}
		}
		
		private function updateRenderer(event:Event):void
		{
			_needRender = true ;
		}
		
		/** 场景渲染 */
		public function renderer(dtime:Number):void
		{
			if (_needRender)
			{
				_needRender = false;
				// update room view
				_flipBar.dataProvide = RoomManager.getRooms() ;
			}
		}
		
		private function onFastAddClick(btn:IButton):void
		{
			AlertManager.showAlert(1,new SimpleAlertProcessor("还未实现功能!")) ;
		}
		
		private function onFindClick(btn:IButton):void
		{
			AlertManager.showAlert(1,new SimpleAlertProcessor("还未实现功能!")) ;
		}
		
		private function onCreateClick(btn:IButton):void
		{
//			AlertManager.showAlert(1,new SimpleAlertProcessor("还未实现功能!")) ;
			ModuleManager.showModule(ModuleName.RoomCreateModule) ;
		}
	}
}