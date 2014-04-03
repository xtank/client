package x.game.net.core
{
    import com.netease.protobuf.Message;
    
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    
    import x.game.net.Connection;

    /**
     * 消息发包
     * @author fraser
     */
    public class RequestMessage
    {
        public var cmdId:uint;
		// 请求包的序列号
        public var stamp:uint;
		public var msg:Message ;
		//
		private var _sendData:ByteArray ;

        public function RequestMessage(cmdId:uint, msg:Message = null)
        {
            this.cmdId = cmdId;
            this.msg = msg ;
        }

        public function getSendData():ByteArray
        {
            if (_sendData == null)
            {
                _sendData = pack(Connection.userId, cmdId, msg, Endian.LITTLE_ENDIAN);
                stamp = getCurrentStamp() ;
            }
            return _sendData;
        }
		
		private static var _stamp:uint = 0;
		
		public static function pack(userId:uint, commandId:uint, msg:Message = null, endian:String = null):ByteArray
		{
			if (endian == null)
			{
				endian = Endian.LITTLE_ENDIAN;
			}
			var body:ByteArray = new ByteArray();
			body.endian = endian;
			// 序列化包体
			serializeBinary(body, msg);
			//
			var head:ByteArray = packHead(userId, commandId, body.length, endian);
			// 
			var request:ByteArray = new ByteArray();
			request.endian = endian;
			request.writeBytes(head);
			request.writeBytes(body);
			request.position = 0;
			//
			return request ;
		}
		
		private static function serializeBinary(data:ByteArray, msg:Message):void
		{
			if(msg != null)
			{
				msg.writeTo(data) ;
			}
		}
		
		private static function packHead(userId:uint, commandId:uint, bodyLen:int, endian:String):ByteArray
		{
			/*
			uint32 len 包体长度 
			uint32 seq 顺序号
			uint32 cmd 命令号
			uint32 ret 用户号
			uint32 checksum 验证
			*/
			var head:ByteArray = new ByteArray();
			head.endian = endian;
			head.writeUnsignedInt(Connection.HEAD_LENGTH + bodyLen);
			head.writeUnsignedInt(getNewStamp());
			head.writeUnsignedInt(commandId);
			head.writeUnsignedInt(userId);
			head.writeUnsignedInt(0);
			return head;
		}
		
		// 序号戳
		private static function getNewStamp():uint
		{
			++_stamp;
			if (_stamp == 0)
				_stamp = 1;
			
			return _stamp;
		}
		
		/** 获取当前标志位 */
		public static function getCurrentStamp():uint
		{
			return _stamp;
		}
    }
}
