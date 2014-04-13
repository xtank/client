package com.xtank.module
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import x.game.module.Module;
	import x.game.module.ModuleManager;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	import x.game.ui.digital.DigitalNumber;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.cfg.ModuleName;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.MapConfigInfo;
	
	/** 房间创建 */
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
		
		
		
		
		public function RoomCreateModule()
		{
			super();
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
			_okBtn = new XSimpleButton(_mainUI["okBtn"]) ;
			_okBtn.addClick(onOKClick) ;
			_cancelBtn = new XSimpleButton(_mainUI["cancelBtn"]) ;
			_cancelBtn.addClick(onCancelClick) ;
		}
		
		private function updateSelectedMap(mapId:uint):void
		{
			var mapData:MapConfigInfo = DataProxyManager.mapData.getMapInfo(mapId) ;
			_nameTxt.text = mapData.name ;
			_difficultMC.gotoAndStop(mapData.difficult) ;
			_teamLimitMC.updateValue(mapData.teamLimitCount) ;
			_playerLimitMC.updateValue(mapData.playerLimitCount) ;
		}
		
		private function onOKClick(btn:IButton):void
		{
			//
		}
		
		private function onCancelClick(btn:IButton):void
		{
			ModuleManager.toggleModule(ModuleName.RoomCreateModule) ;
		}
	}
}