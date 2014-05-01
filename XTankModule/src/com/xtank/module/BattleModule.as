package com.xtank.module
{
	import x.game.module.IModuleInitData;
	import x.game.module.LifecycleType;
	import x.game.module.Module;
	import x.game.net.processor.IMessageProcessor;
	
	/** 
	 *  战斗模块
	 */
	public class BattleModule extends Module
	{
		protected var _msgHandlerVec:Vector.<IMessageProcessor>;
		
		public function BattleModule()
		{
			super();
			_lifecycleType = LifecycleType.NONCE;
		}
		
		override public function dispose():void
		{
			for each (var handler:IMessageProcessor in _msgHandlerVec)
			{
				handler.dispose();
				handler = null;
			}
			_msgHandlerVec = null;
			//
			super.dispose() ;
		}
		
		override public function setup():void
		{
			setMainUI(null);
			
		}
		
		override public function init(data:IModuleInitData):void
		{
			super.init(data);
			// init net handlers
			_msgHandlerVec = new Vector.<IMessageProcessor>();
		}
		
		override public function show():void
		{
			super.show() ;
			
		}
		
		override public function hide():void
		{
			super.hide();
			
		}
	}
}