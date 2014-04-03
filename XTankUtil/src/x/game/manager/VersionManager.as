package x.game.manager
{
	/**
	 * 版本管理 
	 * @author tb
	 * 
	 */	
	public class VersionManager
	{
		private static  var _o:Object;
        
		public static function setup(o:Object):void
		{
			_o = o;
		}
		
		/**
		 * 版本号 单位秒
		 * @return 
		 * 
		 */		
		public static function get versionTime():Number
		{
			return (_o.getInstance().lastModifiedDate as Date).time*0.001;
		}
		
		/**
		 * 版本显示 
		 * @return 
		 * 
		 */		
		public static function get version():String
		{
			var t:Date = _o.getInstance().lastModifiedDate as Date;
			var str:String = t.fullYear+"."+(t.getMonth()+1)+"."+t.getDate()+" "+t.toLocaleTimeString();
			return str;
		}
		
		/**
		 * 带版本号的路径 
		 * @param p
		 * @return 
		 * 
		 */		
		public static function getURL(p:String):String
		{
			return _o.getVerURLByNameSpace(p) as String;
		}
	}
}