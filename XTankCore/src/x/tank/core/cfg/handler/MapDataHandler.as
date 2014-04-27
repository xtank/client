package x.tank.core.cfg.handler
{
	import de.polygonal.ds.HashMap;
	
	import x.game.cfg.ICFGDataHandler;
	import x.tank.core.cfg.model.MapConfigInfo;

	//
	public class MapDataHandler implements ICFGDataHandler
	{
		public static const FILE_NAME:String = "map.xml";

		private var _mapDatas:HashMap;

		public function MapDataHandler()
		{
			_mapDatas = new HashMap();
		}

		public function get fileName():String
		{
			return FILE_NAME;
		}

		public function parser(xml:XML):void
		{
			var tp:XMLList = xml.map;
			var len:uint = tp.length();
			for (var i:uint = 0; i < len; i++)
			{
				var info:MapConfigInfo = new MapConfigInfo(tp[i]);
				_mapDatas.set(info.id, info);
			}
		}
		
		public function getMapInfo(mapId:uint):MapConfigInfo
		{
			return _mapDatas.get(mapId) as MapConfigInfo ;
		}
		
		public function getAllMapInfos():Array
		{
			return _mapDatas.toArray() ;
		}
	}
}
