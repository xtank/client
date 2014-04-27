package com.xtank.module
{
	import com.xtank.module.room.MapInfoView;
	
	import x.game.module.IModuleInitData;
	import x.game.module.LifecycleType;
	import x.game.module.Module;
	
	/** 
	 * 房间
	 * @author fraser
	 * @time 2014-4-7
	 */
	public class RoomModule extends Module
	{
		private var _mapInfo:MapInfoView ;
		
		public function RoomModule()
		{
			super();
			_lifecycleType = LifecycleType.NONCE;
		}
		
		override public function dispose():void
		{
			_mapInfo.dispose() ;
			_mapInfo = null ;
			super.dispose() ;
		}
		
		override public function setup():void
		{
			setMainUI(new RoomModuleUI());
			//
			_mapInfo = new MapInfoView(_mainUI) ;
		}
		
		override public function init(data:IModuleInitData):void
		{
			super.init(data);
			
		}
	}
}