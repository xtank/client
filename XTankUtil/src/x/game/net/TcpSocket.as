package x.game.net
{
	import flash.events.DataEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import x.game.log.core.Logger;
	import x.game.net.core.ResponseMessage;

	[Event(name = "connect", type = "flash.events.Event")]
	[Event(name = "close", type = "flash.events.Event")]
	[Event(name = "ioError", type = "flash.events.IOErrorEvent")]
	[Event(name = "securityError", type = "flash.events.SecurityErrorEvent")]
	[Event(name = "data", type = "flash.events.DataEvent")]


	/**
	 * 前后端通讯的Socket基础类，以Message为单元给出信息
	 * @author fraser
	 *
	 */
	public class TcpSocket extends Socket
	{
		//msgFirstToken: to describe how long this msg is
		private const MSG_FIRST_TOKEN_LEN:int = 4 ;
		//
		private var _tempBuffer:ByteArray;
		private var _chunkBuffer:ByteArray;
		private var _messageQueue:Vector.<ResponseMessage>
		private var _host:String = "";
		private var _port:int;

		public function TcpSocket()
		{
			_tempBuffer = new ByteArray();
			_chunkBuffer = new ByteArray();
			_messageQueue = new Vector.<ResponseMessage>();
			addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
		}

		public function get host():String
		{
			return _host;
		}

		public function get port():int
		{
			return _port;
		}

		override public function set endian(value:String):void
		{
			super.endian = value;
			_tempBuffer.endian = value;
			_chunkBuffer.endian = value;
		}

		override public function connect(host:String, port:int):void
		{
			_host = host;
			_port = port;
			super.connect(host, port);
		}

		private function onSocketData(event:ProgressEvent):void
		{
			_chunkBuffer.clear();
			// 
			if (_tempBuffer.length > 0)
			{
				_tempBuffer.position = 0;
				_tempBuffer.readBytes(_chunkBuffer, 0, _tempBuffer.length);
				_tempBuffer.clear();
			}
			readBytes(_chunkBuffer, _chunkBuffer.length, bytesAvailable);
			_chunkBuffer.position = 0;
			while (_chunkBuffer.bytesAvailable > 0)
			{
				if (_chunkBuffer.bytesAvailable > MSG_FIRST_TOKEN_LEN)
				{
					var msgLen:int = _chunkBuffer.readUnsignedInt() - MSG_FIRST_TOKEN_LEN;
					if (msgLen > _chunkBuffer.bytesAvailable)
					{
						_chunkBuffer.position = _chunkBuffer.position - MSG_FIRST_TOKEN_LEN;
						_chunkBuffer.readBytes(_tempBuffer, 0, _chunkBuffer.bytesAvailable);
					}
					else
					{
						_chunkBuffer.position = _chunkBuffer.position - MSG_FIRST_TOKEN_LEN;
						//
						var msg:ResponseMessage = new ResponseMessage(_chunkBuffer);
						_messageQueue.push(msg);
						dispatchEvent(new DataEvent(DataEvent.DATA));
					}
				}
				else
				{
					_chunkBuffer.readBytes(_tempBuffer, 0, _chunkBuffer.bytesAvailable);
				}
			}
		}

		public function getMessageQueue():Vector.<ResponseMessage>
		{
			var result:Vector.<ResponseMessage> = new Vector.<ResponseMessage>();
			while (_messageQueue.length > 0)
			{
				result.push(_messageQueue.shift());
			}
			return result;
		}

		public function send(data:ByteArray):void
		{
			if (connected == true)
			{
				writeBytes(data);
				flush();
			}
			else
			{
				if(closeAlertFlag == false)
				{
					closeAlertFlag = true ;
					//
					Logger.info("[连接已断开]");
				}
			}
		}
		
		private var closeAlertFlag:Boolean = false ;

		override public function close():void
		{
			if (connected == true)
			{
				super.close();
			}
		}
	}
}
