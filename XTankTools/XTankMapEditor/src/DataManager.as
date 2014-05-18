package
{
	import editordata.MapData;
	
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.Itr;

	public class DataManager
	{
		private static var _datas:HashMap = new HashMap() ;
		
		public static function addMapData(data:MapData):void
		{
			_datas.set(data.id,data) ;
		}
		
		public static function getMapData(id:uint):MapData
		{
			return _datas.get(id) as MapData;
		}
		
		public static function parserContent():String
		{
			var rs:String = "<maps>\n" ;
				var des:Array = [] ;
			var itr:Itr = _datas.iterator() ;
			var map:MapData ;
			while(itr.hasNext())
			{
				map = itr.next() as MapData;
				des.push(map.description) ;
			}
			return (rs + des.join("\n")+ "\n</maps>") ;
		}
	}
}