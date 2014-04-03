package x.game.net.post
{
	import com.netease.protobuf.Message;
	
	import x.game.net.Connection;

	/**
	 * 发送消息类，无回调
	 * @author fraser
	 */
	public class SimplePost implements IPost
	{
		/** 消息体 */
		protected var _msg:Message;
		/** 命令 */
		protected var _cmdId:uint;

		public function SimplePost(cmdId:uint,msg:Message = null)
		{
			this._cmdId = cmdId;
			this._msg = msg;
		}

		public function send():void
		{	
			if (_msg != null)
				Connection.send(_cmdId, _msg);
			else
				Connection.send(_cmdId);
		}
	}
}
