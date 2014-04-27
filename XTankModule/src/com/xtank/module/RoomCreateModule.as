package com.xtank.module
{
	import com.xtank.module.roomCreate.MapListItem;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import onlineproto.cs_create_room;
	import onlineproto.sc_create_room;
	
	import x.game.alert.AlertManager;
	import x.game.manager.StageManager;
	import x.game.module.IModuleInitData;
	import x.game.module.LifecycleType;
	import x.game.module.Module;
	import x.game.module.ModuleManager;
	import x.game.net.post.CallbackPost;
	import x.game.net.response.XMessageEvent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	import x.game.ui.digital.DigitalNumber;
	import x.game.ui.list.XList;
	import x.game.ui.scroller.ScrollerInitData;
	import x.game.ui.scroller.VScroller;
	import x.game.util.DisplayObjectUtil;
	import x.game.util.StringUtil;
	import x.tank.app.cfg.ModuleName;
	import x.tank.app.module.RoomModuleData;
	import x.tank.app.processor.alert.SimpleAlertProcessor;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.MapConfigInfo;
	import x.tank.net.CommandSet;
	
	/** 
	 * 房间创建 
	 * @author fraser
	 * @time 2014-4-7
	 */
	public class RoomCreateModule extends Module
	{
		private var _nameTxt:TextField ;// 
		private var _difficultMC:MovieClip ; // 1星 ~ 5星 
		private var _teamLimitMC:DigitalNumber ; // 队伍上限
		private var _playerLimitMC:DigitalNumber ; // 人数上限
		
		/////////////////////////////////////////////////////////
		private var _roomNameTxt:TextField ;// 
		private var _pwdTxt:TextField ;// 
		private var _okBtn:XSimpleButton ;
		private var _cancelBtn:XSimpleButton ;
		
		/////////////////////////////////////////////////////////
		private var _vScroller:VScroller ;
		private var _list:XList ;
		private var _currentSelectedMapConfig:MapConfigInfo ;
		
		public function RoomCreateModule()
		{
			super();
			_lifecycleType = LifecycleType.NONCE;
		}
		
		override public function dispose():void
		{
			_teamLimitMC.dispose() ;
			_teamLimitMC = null ;
			//
			_playerLimitMC.dispose() ;
			_playerLimitMC = null ;
			//
			_okBtn.dispose() ;
			_okBtn = null ;
			//
			_cancelBtn.dispose() ;
			_cancelBtn = null ;
			//
			_vScroller.dispose() ;
			_vScroller = null ;
			//
			_list.dispose() ;
			_list = null ;
			//
			super.dispose() ;
		}
		
		/**
		 * 设置模块皮肤
		 */
		override public function setup():void
		{
			setMainUI(new RoomCreateModuleUI());
			//
			_nameTxt = _mainUI["nameTxt"] ;
			DisplayObjectUtil.disableTarget(_nameTxt) ;
			_difficultMC = _mainUI["difficultMC"] ;
			_difficultMC.gotoAndStop(1) ;
			DisplayObjectUtil.disableTarget(_difficultMC) ;
			//
			_teamLimitMC = new DigitalNumber(_mainUI,Vector.<MovieClip>([_mainUI["teamLimitMC"]])) ;
			_playerLimitMC = new DigitalNumber(_mainUI,Vector.<MovieClip>([_mainUI["shiwei"],_mainUI["gewei"]])) ;
			//
			_roomNameTxt = _mainUI["roomNameTxt"] ;
			_pwdTxt = _mainUI["pwdTxt"] ;
			_pwdTxt.displayAsPassword = true ;
			_pwdTxt.restrict = "0-9" ;
			_okBtn = new XSimpleButton(_mainUI["okBtn"]) ;
			_okBtn.addClick(onOkClick) ;
			_cancelBtn = new XSimpleButton(_mainUI["cancelBtn"]) ;
			_cancelBtn.addClick(onCancelClick) ;
			//
			var scrollerInitData:ScrollerInitData = new ScrollerInitData(StageManager.stage) ;
			scrollerInitData.autoVisible = true ;
			scrollerInitData.isMouseWheel = true ;
			_vScroller = new VScroller(_mainUI["vScroller"],onScroller,scrollerInitData) ;
			//
			_list = new XList(_mainUI["listView"]["listBox"]);
		}
		
		override public function init(data:IModuleInitData):void
		{
			super.init(data);
			//
			_list.clear() ;
			_okBtn.enable = true ;
			//
			var maps:Array = DataProxyManager.mapData.getAllMapInfos() ;
			var len:uint = maps.length ;
			for(var i:uint = 0;i<len;i++)
			{
				_list.addItem(new MapListItem(maps[i],updateSelectedMap)) ;
			}
			//
			updateSelectedMap((maps[0] as MapConfigInfo).id) ; 
		}
		
		private function updateSelectedMap(mapId:uint):void
		{
			var listItem:MapListItem  ;
			if(_currentSelectedMapConfig != null)
			{				
				listItem = _list.getSelectedItem(_currentSelectedMapConfig) as MapListItem;
				listItem.selected = false ;
			}
			//
			_currentSelectedMapConfig = DataProxyManager.mapData.getMapInfo(mapId) ;
			listItem = _list.getSelectedItem(_currentSelectedMapConfig) as MapListItem;
			listItem.selected = true ;
			//
			_nameTxt.text = _currentSelectedMapConfig.name ;
			_difficultMC.gotoAndStop(_currentSelectedMapConfig.difficult) ;
			_teamLimitMC.updateValue(_currentSelectedMapConfig.teamLimitCount) ;
			_playerLimitMC.updateValue(_currentSelectedMapConfig.playerLimitCount) ;
		}
		
		private function onScroller(percent:Number):void
		{
			trace("percent:" + percent);
			// 0 - 1
			_list.listSkin.height
			_list.y = - _list.height * percent ;
		}
		
		private function onOkClick(btn:IButton):void
		{
			btn.enable = false ;
			var roomName:String = _roomNameTxt.text ;
			if(StringUtil.isBlank(roomName)) 
			{
				// 提示房间名称不可为空
				
				//
				btn.enable = true ;
				return ;
			}
			// 通知服务器创建房间
			var msg:cs_create_room = new cs_create_room() ;
			msg.mapId = _currentSelectedMapConfig.id ;
			msg.name = roomName ;
			msg.passwd = uint(_pwdTxt.text) ;
			new CallbackPost(CommandSet.$157.id,msg,
				function(event:XMessageEvent):void
				{
					var msg:sc_create_room = event.msg as sc_create_room ;
					//
					ModuleManager.toggleModule(ModuleName.RoomModule,new RoomModuleData(msg.roomid)) ;	
					ModuleManager.closeModule(ModuleName.RoomCreateModule) ;
				},
				function(event:XMessageEvent):void
				{
					btn.enable = true ;
				}
			).send() ;
		}
		
		private function onCancelClick(btn:IButton):void
		{
			AlertManager.showAlert(1,new SimpleAlertProcessor("确定取消创建房间吗?",
				function():void
				{
					ModuleManager.closeModule(ModuleName.RoomCreateModule) ;
				}
			)) ;
		}
	}
}