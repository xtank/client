package x.game.loader.core
{
	/**
	 * 统一资源加载（无loading显示）
	 * @author tb
	 * 
	 */	
	public class QueueLoader
	{
		private static var _impl:QueueLoaderImpl = new QueueLoaderImpl();
		
		public static function get currentInfo():QueueInfo
		{
			return _impl.currentInfo;
		}
		
		public static function get waitList():Array
		{
			return _impl.waitList;
		}
		
		/**
		 * 开始加载
		 * @param url       地址
		 * @param type      类型 LoadType
		 * @param complete  加载完成方法回调
		 * @param error     加载错误方法回调
		 * @param priority  加载优先级别
		 * @param open      加载开始方法回调
		 * @param progress  加载进度方法回调
		 * 
		 */		
		public static function load(url:String, type:String, complete:Function, error:Function = null, data:*=null,priority:int = 2, open:Function = null, progress:Function = null):void
		{
			_impl.load(url,type,complete,error,data,priority,open,progress);
		}
		
		/**
		 * 预加载，优先级最低，无回调需求的
		 * @param url
		 * @param type
		 * 
		 */		
		public static function addBef(url:String,type:String):void
		{
			_impl.addBef(url,type);
		}
		
		public static function hasCompleteHandlerFromData(url:String,attribute:String,complete:Function):Boolean
		{
			return _impl.hasCompleteHandlerFromData(url,attribute,complete);
		}
		/**
		 * 取消当前加载 
		 * @param url
		 * @param complete
		 * 
		 */		
		public static function cancel(url:String, complete:Function):void
		{
			_impl.cancel(url,complete);
		}
		
		/**
		 * 取消指定url的所有加载 
		 * @param url
		 * 
		 */		
		public static function cancelURL(url:String):void
		{
			_impl.cancelURL(url);
		}
		
		/**
		 * 取消指定侦听
		 * @param complete
		 * 
		 */		
		public static function cancelHandler(complete:Function):void
		{
			_impl.cancelHandler(complete);
		}
		
		/**
		 * 从data中指定的属性和值取消加载
		 * @param attribute
		 * @param value
		 * 
		 */		
		public static function cancelData(attribute:String,value:*,url:String = null):void
		{
			_impl.cancelData(attribute,value,url);
		}
		
		/**
		 * 取消所有加载 
		 * 
		 */		
		public static function cancelAll():void
		{
			_impl.cancelAll();
		}
		
		/**
		 * 暂停加载 
		 * 
		 */		
		public static function pause():void
		{
			_impl.pause();
		}
		
		/**
		 * 恢复加载
		 * 
		 */		
		public static function resume():void
		{
			_impl.resume();
		}
	}
}