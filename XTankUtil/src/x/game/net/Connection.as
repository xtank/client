package x.game.net
{
	import com.netease.protobuf.Message;

	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	import de.polygonal.ds.HashMap;

	import x.game.log.core.Logger;
	import x.game.net.core.Command;
	import x.game.net.core.RequestMessage;
	import x.game.net.core.ResponseMessage;
	import x.game.net.response.XMessageEvent;

	/**
	 * @author fraser
	 * 创建时间：2012-6-6
	 * 类说明：online socket连接类
	 */
	public class Connection
	{
		public static const HEAD_LENGTH:int = 20;
		private static var _endian:String = Endian.LITTLE_ENDIAN;
		/** 当前登录玩家ID */
		private static var _userId:int;
		private static var _socket:TcpSocket;
		private static var _blockedMap:HashMap = new HashMap();
		//
		initialize();

		private static function initialize():void
		{
			_socket = new TcpSocket();
			//
			_socket.endian = _endian;
			_socket.addEventListener(DataEvent.DATA, onSocketData);
			_socket.addEventListener(Event.CLOSE, onSocketClose);
		}

		public static function setConnectInfo(userId:int):void
		{
			_userId = userId;
		}

		public static function get userId():int
		{
			return _userId;
		}

		public static function isConnecting():Boolean
		{
			return _socket.connected;
		}

		public static function connect(ip:String, port:int):void
		{
			_socket.connect(ip, port);
		}

		public static function send(cmdId:uint, msg:Message = null):void
		{
			sendMessage(new RequestMessage(cmdId, msg));
		}

		public static function sendMessage(msg:RequestMessage):void
		{
			if (_blockedMap.hasKey(msg.cmdId))
			{
				var blockedCommandStructure:BlockedCommandStructure = _blockedMap.get(msg.cmdId) as BlockedCommandStructure;
				var sMsgs:Vector.<RequestMessage> = blockedCommandStructure.sendMessageVec;
				sMsgs.push(msg);
			}
			else
			{
				var requestData:ByteArray = msg.getSendData();
				// 
				_socket.send(requestData);
				//
				netLog("[C2S - Stamp:" + msg.stamp + "]" + Command.findDescriptionById(msg.cmdId) + " dataLength: " + (requestData.length - HEAD_LENGTH), msg.cmdId);
			}
		}

		private static function onSocketData(event:DataEvent):void
		{
			var messageQueue:Vector.<ResponseMessage> = _socket.getMessageQueue();
			var message:ResponseMessage;
			while (messageQueue.length > 0)
			{
				message = messageQueue.shift();
				if (_blockedMap.hasKey(message.commandId) == true)
				{
					var blockedCommandStructure:BlockedCommandStructure = _blockedMap.get(message.commandId) as BlockedCommandStructure;
					var messageVec:Vector.<ResponseMessage> = blockedCommandStructure.messageVec;
					messageVec.push(message);
				}
				else
				{
					handleMessage(message);
				}
			}
		}

		internal static function handleMessage(message:ResponseMessage):void
		{
			var commandId:String = message.commandId.toString();
			//
			if (message.statusCode != 0)
			{
				netLog("[S2C]: " + Command.findDescriptionById(message.commandId) + " Error Code: " + message.statusCode, message.commandId);
				// 
				if (_errorDispatcher.hasEventListener(commandId))
				{
					_errorDispatcher.dispatchEvent(new XMessageEvent(commandId, message));
				}
				_errorDispatcher.dispatchEvent(new XMessageEvent(XMessageEvent.ERROR_CODE, message));
			}
			else
			{
				netLog("[S2C]: " + Command.findDescriptionById(message.commandId) + " dataLength: " + message.dataLength, message.commandId);
				_messageDispatcher.dispatchEvent(new XMessageEvent(commandId, message));
			}
		}

		/** 临时屏蔽消息   */
		public static function blockCommand(command:Command):void
		{
			var commandId:uint = command.id;
			//
			if (_blockedMap.hasKey(commandId) == false)
			{
				var blockedCommandStructure:BlockedCommandStructure = new BlockedCommandStructure();
				_blockedMap.set(commandId, blockedCommandStructure);
			}
		}

		/** 释放屏蔽的消息 */
		public static function releaseCommand(command:Command):void
		{
			var commandId:uint = command.id;
			if (_blockedMap.hasKey(commandId) == true)
			{
				var blockedCommandStructure:BlockedCommandStructure = _blockedMap.get(commandId) as BlockedCommandStructure;
				_blockedMap.remove(commandId);
				//
				var sMsgs:Vector.<RequestMessage> = blockedCommandStructure.sendMessageVec;
				for each (var msg:RequestMessage in sMsgs)
				{
					sendMessage(msg);
				}
				//
				var messageVec:Vector.<ResponseMessage> = blockedCommandStructure.messageVec;
				for each (var message:ResponseMessage in messageVec)
				{
					handleMessage(message);
				}
			}
		}

		public static function close():void
		{
			_socket.close();
		}

		private static function onSocketClose(e:Event):void
		{
			dispatchEvent(new Event(XMessageEvent.CLOSE));
		}

		// ###################################################################################
		//				Socket  Dispatcher		
		// ###################################################################################

		public static function addEventListener(type:String, succFun:Function, errorFun:Function = null):void
		{
			if (succFun != null)
			{
				_socket.addEventListener(type, succFun);
			}
			if (errorFun != null)
			{
				_errorDispatcher.addEventListener(type, errorFun);
			}
		}

		public static function removeEventListener(type:String, succFun:Function, errorFun:Function = null):void
		{
			if (succFun != null)
			{
				_socket.removeEventListener(type, succFun);
			}
			if (errorFun != null)
			{
				_errorDispatcher.removeEventListener(type, errorFun);
			}
		}

		public static function dispatchEvent(evt:Event):void
		{
			_socket.dispatchEvent(evt);
		}

		// ###################################################################################
		//				Error Message  Dispatcher		
		// ###################################################################################

		private static var _errorDispatcher:EventDispatcher = new EventDispatcher();

		public static function addErrorHandler(cmdId:uint, listener:Function):void
		{
			if (cmdId == 0)
			{
				return;
			}
			_errorDispatcher.addEventListener(String(cmdId), listener);
		}

		public static function removeErrorHandler(cmdId:uint, listener:Function):void
		{
			if (cmdId == 0)
			{
				return;
			}
			_errorDispatcher.removeEventListener(String(cmdId), listener);
		}

		public static function hasErrorListener(cmdId:uint):Boolean
		{
			if (cmdId == 0)
			{
				return false;
			}
			return _errorDispatcher.hasEventListener(String(cmdId).toString());
		}

		// ###################################################################################
		//				Message  Dispatcher		
		// ###################################################################################

		private static var _messageDispatcher:EventDispatcher = new EventDispatcher();

		public static function addCommandListener(cmdId:uint, listener:Function, priority:uint = 0):void
		{
			_messageDispatcher.addEventListener(String(cmdId), listener, false, priority);
		}

		public static function hasCommadnListener(cmdId:uint):Boolean
		{
			return _messageDispatcher.hasEventListener(String(cmdId));
		}

		public static function removeCommandListener(cmdId:uint, listener:Function):void
		{
			_messageDispatcher.removeEventListener(String(cmdId), listener);
		}

		public static function dispatchMessageEvent(event:XMessageEvent):void
		{
			_messageDispatcher.dispatchEvent(event);
		}

		// ###################################################################################
		//				Logger Filter
		// ###################################################################################
		private static var filterIds:Array = []; // 过滤不需要输出日志的命令号id列表

		private static function netLog(content:String, commandId:uint):void
		{
			if (filterIds.indexOf(commandId) == -1 && Logger.isDebug)
			{
				Logger.info("(Connection # " + content + ")");
			}
		}

	}
}
import x.game.net.core.RequestMessage;
import x.game.net.core.ResponseMessage;

class BlockedCommandStructure
{
	public var sendMessageVec:Vector.<RequestMessage>;
	public var messageVec:Vector.<ResponseMessage>;

	public function BlockedCommandStructure()
	{
		sendMessageVec = new Vector.<RequestMessage>();
		messageVec = new Vector.<ResponseMessage>();
	}
}
