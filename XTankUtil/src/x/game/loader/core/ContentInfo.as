package x.game.loader.core
{
	import flash.system.ApplicationDomain;

	/**
	 * 加载输出内容信息 
	 * @author tb
	 * 
	 */	
	public class ContentInfo
	{
		/**
		 * 加载的内容 
		 */		
		public var content:*;
		/**
		 * 加载的应用程序域
		 */		
		public var domain:ApplicationDomain;
		/**
		 * 自定义数据 
		 */		
		public var data:*;
		//
		private var _url:String;
		private var _type:String;
		
		public function ContentInfo(url:String,type:String,content:*,domain:ApplicationDomain=null,data:*=null)
		{
			_url = url;
			_type = type;
			this.content = content;
			this.domain = domain;
			this.data = data;
		}
		
		public function dispose():void
		{
			content = null;
			domain = null;
			data = null;
		}
		
		/**
		 * url地址 
		 * @return 
		 * 
		 */		
		public function get url():String
		{
			return _url;
		}
		
		/**
		 * 加载类型 
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}
	}
}