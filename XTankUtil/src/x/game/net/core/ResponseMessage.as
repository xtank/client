package x.game.net.core
{
	import com.netease.protobuf.Message;
	
	import flash.utils.ByteArray;
	
	import x.game.core.IDisposeable;
	import x.game.log.core.Logger;
	import x.game.net.Connection;
	import x.game.net.util.LittleEndianByteArray;

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
		public var checksum:uint;

		private var _data:ByteArray;
		private var _msg:Message;

		public function ResponseMessage(data:ByteArray)
		{
			_data = data;
			if (_data != null)
			{
				parseHead(_data);
				//
				var cmd:Command = Command.getCommand(commandId);
				if (cmd != null)
				{
					var dataLength:uint = _length - 20 ;
					var bodyData:LittleEndianByteArray = new LittleEndianByteArray();
					_data.readBytes(bodyData,0,dataLength) ;
					bodyData.position = 0;
					//
					_msg = new cmd.decodeCls();
					_msg.mergeFrom(bodyData);
					//
				}
				else
				{
					throw new Error("No Command about [" + commandId + "]");
				}
			}
			else
			{
				Logger.error("No ResponseMessage Data about [" + commandId + "]");
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
			//
//			trace("commandId：[" + commandId + "]#" + "stamp[" + stamp + "]# length[" + _length + "]");
		}

		public function get dataLength():uint
		{
			return _length - Connection.HEAD_LENGTH;
		}

		public function get msg():Message
		{
			return _msg;
		}
	}
}
