package x.tank.login
{
	public class XtankInitData
	{
		static private var _data:Object;
		
		static public function init(data:Object):void
		{
			_data = data;
		}
		//
		public static function getDataByKey(key:String):Object
		{
			return _data[key] ;
		}
		
		public static function setDataByKey(key:String,value:*):void
		{
			_data[key] = value ;
		}
	}
}