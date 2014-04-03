package x.tank.core.cfg.handler
{
	import x.game.cfg.ICFGDataHandler;
	
	//
	public class MapDataHandler implements ICFGDataHandler
	{
		public static const FILE_NAME:String = "map.xml" ;

		public function MapDataHandler()
		{
			
		}
		
		public function get fileName():String
		{
			return FILE_NAME;
		}
		
		public function parser(xml:XML):void
		{
			trace("解析地图配置文件") ;
		}
	}
}