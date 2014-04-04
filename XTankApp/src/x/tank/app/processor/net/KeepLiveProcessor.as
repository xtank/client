package x.tank.app.processor.net
{
	import flash.utils.getTimer;
	
	import onlineproto.cs_keep_live;
	import onlineproto.sc_keep_live;
	
	import x.game.log.core.Logger;
	import x.game.manager.TimeManager;
	import x.game.net.Connection;
	import x.game.net.post.SimplePost;
	import x.game.net.processor.BaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.game.tick.TimeTicker;
	import x.tank.net.CommandSet;
	
	/** 心跳包处理器 */
	public class KeepLiveProcessor extends BaseMessageProgressor
	{
		private var _keepLiveIndex:int ;
		
		public function KeepLiveProcessor()
		{
			super() ;
			// 
			Logger.info("start [keep live processor]") ;
		}
		
		override public function setup():void
		{
			Connection.addCommandListener(CommandSet.$102.id,onMessage) ;
			//
			startKeepLive() ;
		}
		
		override public function onMessage(event:XMessageEvent):void
		{
			var msg:sc_keep_live = event.msg as sc_keep_live ; 
			TimeManager.updateDelayTime(msg.time,msg.serverTime) ;
			//
			Logger.info(TimeManager.serverDate.time + "#" + TimeManager.serverDate.toDateString()) ;
		}
		
		override public function dispose():void
		{
			TimeTicker.clear(_keepLiveIndex) ;
			_keepLiveIndex = 0 ;
			Connection.removeCommandListener(CommandSet.$102.id,onMessage) ;
			super.dispose() ;
		}
		
		public function startKeepLive():void
		{
			sendKeepLiveRequest() ;
			_keepLiveIndex = TimeTicker.setInterval(2000,function():void
			{
				if(Connection.isConnecting())
				{
					sendKeepLiveRequest() ;
				}
				else
				{
					TimeTicker.clear(_keepLiveIndex) ;
					_keepLiveIndex = 0 ;
				}
			}) ;
		}
		
		private function sendKeepLiveRequest():void
		{
			var msg:cs_keep_live = new cs_keep_live() ;
			msg.time = getTimer() ; 
			new SimplePost(CommandSet.$102.id,msg).send() ;
		}
		
	}
}