package x.game.loader.core
{
	import x.game.core.IDisposeable;

	/**
	 * 队列加载信息
	 * @author tb
	 * 
	 */	
	public class QueueInfo implements IDisposeable
	{
		public var timeCount:uint;//超时次数，大于TIMEOUT_MAX次超时就干掉
		public var priority:int = QueuePriority.STANDARD;
		public var url:String;
		public var type:String;
		public var isCover:Boolean ;
		public var title:String;
		public var data:*;
		public var isShowBar:Boolean ;
		//
		public var openHandler:Function;
		public var completeHandler:Function;
		public var progressHandler:Function;
		public var errorHandler:Function;
        /** 标示是否已经被销毁 */
        private var _isDisposed:Boolean = false ;
		
		public function dispose():void
		{
			data = null;
			openHandler = null;
			completeHandler = null;
			progressHandler = null;
			errorHandler = null;
            //
            _isDisposed = true ;
		}
        
        public function get disposed():Boolean 
        {
            return _isDisposed ;
        }
	}
}