package x.tank.core.cfg.model
{
	public class MapDataTeamInfo
	{
		private var _count:uint ;
		
		public function MapDataTeamInfo(xml:XML)
		{
			_count = xml.@count ;
		}
		
		public function get count():uint{return _count;}
	}
}