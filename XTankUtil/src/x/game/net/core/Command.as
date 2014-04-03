package x.game.net.core
{
    import de.polygonal.ds.HashMap;

    /**
     * 客户端发送至服务器端命令
     * @author fraser
     *
     */
    public class Command
    {
        public var id:uint;
		public var encodeCls:Class ;
		public var decodeCls:Class ;

        public function Command(id:uint,encodeCls:Class,decodeCls:Class)
        {
            this.id = id;	
			this.encodeCls = encodeCls ;
			this.decodeCls = decodeCls ;
			//
			_map.set(this.id, this);
        }
		
        public function toString():String
        {
            return "[" + id + "]";
        }
		
		// --------------------------------------------------------------------------------------
		
		private static var _map:HashMap = new HashMap();
		
        public static function findDescriptionById(id:uint):String
        {
            if (getCommand(id) != null)
            {
                return getCommand(id).toString();
            }
            else
            {
                return "！！该条命令[" + id + "]定义不存在！！";
            }
        }

        public static function getCommand(id:uint):Command
        {
			if (_map.hasKey(id))
            {
                return _map.get(id) as Command;
            }
            else
            {
                return null;
            }
        }
		
		/** 删除指定命令 */
		public static function removeCommand(id:uint):Command
		{
			var result:Command =  _map.get(id) as Command ;
			_map.clr(id) ;
			return result ;
		}
    }
}
