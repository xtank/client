package x.game.net.response
{
	import com.netease.protobuf.Message;
	
	import flash.events.Event;
	import x.game.net.core.ResponseMessage;

	/**
	 * socket数据事件
	 * @author fraser
	 *
	 */
	public class XMessageEvent extends Event
	{
		/** 错误码 */
		public static const ERROR_CODE:String = "MessageEvent_ErrorCode";
		/** 连接断开 */
		public static const CLOSE:String = "MessageEvent_Close";
		/** 消息对象   */
		public var response:ResponseMessage;

		public function XMessageEvent(type:String, response:ResponseMessage)
		{
			super(type);
			this.response = response;
		}

		public function get msg():Message
		{
			return response.msg;
		}

		public function dispose():void
		{
			response.dispose();
			response = null;
		}
	}
}
