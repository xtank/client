package x.tank.core.cfg.model
{
	public class MapDataTeamInfo
	{
		private var _id:uint ;
		private var _count:uint ;
		
		public function MapDataTeamInfo(xml:XML)
		{
			_id = xml.@id ;
			_count = xml.@count ;
		}
		
		public function get id():uint{return _id;}
		public function get count():uint{return _count;}
	}
}