package x.game.net.post
{
	import com.netease.protobuf.Message;
	
	import x.game.core.IDisposeable;
	import x.game.log.core.Logger;
	import x.game.net.Connection;
	import x.game.net.core.RequestMessage;
	import x.game.net.response.XMessageEvent;

	/**
	 * 支持回调类发送消息
	 * @author fraser
	 */
	public class SimpleCallbackPost implements ICallbackPost, IDisposeable
	{
		// 不做标签序号检查的协议号
		public static const FILTER_CMDS:Array = [];
		//
		protected var _msg:Message;
		//
		protected var _message:RequestMessage;
		protected var _onComplete:Function;
		protected var _onError:Function;
		protected var _cmdId:uint;
		protected var _useCallback:Boolean;
		protected var _disposed:Boolean ;

		public function SimpleCallbackPost(cmdId:uint, msg:Message = null, onComplete:Function = null, onError:Function =
			null)
		{
			this._cmdId = cmdId;
			this._msg = msg;
			this._onComplete = onComplete;
			this._onError = onError;
			this._message = new RequestMessage(_cmdId, msg);
			//
			_useCallback = onComplete != null || onError != null;
		}

		public function send():void
		{
				if (_useCallback)
				{
					Connection.addCommandListener(_cmdId, _onMessageHandler);
					Connection.addErrorHandler(_cmdId, _onErrorHandler);
				}
				Connection.sendMessage(_message);
		}

		public function dispose():void
		{
			if (_useCallback && _disposed == false)
			{
					Connection.removeCommandListener(_cmdId, _onMessageHandler);
					Connection.removeErrorHandler(_cmdId, _onErrorHandler);
				_onComplete = null;
				_onError = null;
			}
		}

		private function _onMessageHandler(event:XMessageEvent):void
		{
			if(_disposed || _message == null)
				return ;
			// 比对消息序号
			if ((FILTER_CMDS.indexOf(_message.cmdId) == -1) && _message.stamp != 0 && _message.stamp != event.response.stamp)
			{
				Logger.error("比对消息序号值失败！" + _message.stamp + "-" + event.response.stamp);
				return;
			}

			if (_onComplete != null)
			{
				_onComplete(event);
			}
			dispose();
		}

		protected function _onErrorHandler(event:XMessageEvent):void
		{
			if(_disposed)
				return ;
			if ((FILTER_CMDS.indexOf(_message.cmdId) == -1) && _message.stamp != 0 && _message.stamp != event.response.stamp)
			{
				return;
			}
			if (_onError != null)
			{
				_onError(event);
			}
			else
			{
				// 默认处理为弹出提示
				Logger.error("服务器返回错误码:"　+　event.response.statusCode);
			}
			dispose();
		}
	}
}
