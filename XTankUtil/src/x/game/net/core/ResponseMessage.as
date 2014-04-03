package x.game.net.core
{
	import com.netease.protobuf.Message;
	
	import flash.utils.ByteArray;
	
	import x.game.core.IDisposeable;
	import x.game.log.core.Logger;
	import x.game.net.Connection;

	/**
	 * xseer服务器端消息的基础类
	 * @author fraser
	 *
	 */
	public class ResponseMessage implements IDisposeable
	{
		//message head
		private var _length:uint;
		//uint16
		public var commandId:uint;
		public var stamp:uint;
		public var statusCode:uint;
		public var checksum:uint ;

		private var _data:ByteArray;
		private var _msg:Message;

		public function ResponseMessage(data:ByteArray = null)
		{
			_data = data;
			if (_data != null)
			{
				parseHead(_data);
			}
		}

		public function dispose():void
		{
			_data = null;
			_msg = null;
		}

		private function parseHead(data:ByteArray):void
		{
			_length = data.readUnsignedInt();
			stamp = data.readUnsignedInt();
			commandId = data.readUnsignedInt();
			statusCode = data.readUnsignedInt();
			checksum = data.readUnsignedInt();
		}

		public function get dataLength():uint
		{
			return _length - Connection.HEAD_LENGTH;
		}

		public function get msg():Message
		{
			if(_data == null)
			{
				return null ;
			}
			if(_msg == null)
			{
				var cmd:Command = Command.getCommand(commandId) ;
				if(cmd != null)
				{
					var decoder:Message = new cmd.decodeCls() ;
					_msg = decoder.mergeFrom(_data) as Message;
				}
				else
				{
					Logger.info("No Command about [" + commandId + "]") ;
				}
			}
			return _msg;
		}
	}
}
