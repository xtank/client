package x.game.net.processor
{
	import x.game.core.IDisposeable;
	import x.game.net.response.XMessageEvent;
	


	/**
	 * 服务器消息处理类必须实现的接口
	 * @author fraser
	 *
	 */
	public interface IMessageProcessor extends IDisposeable
	{
		/**
		 * 安装要处理的消息
		 */
		function setup():void;
		
		/**
		 * 消息处理函数 
		 * @param event
		 * 
		 */
		function onMessage(event:XMessageEvent):void;
		
	}
}
