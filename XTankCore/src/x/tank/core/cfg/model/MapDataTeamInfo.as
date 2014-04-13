package x.tank.core.cfg.model
{
	public class MapDataTeamInfo
	{
		public var count:uint ;
		
		public function MapDataTeamInfo(xml:XML)
		{
			count = xml.@count ;
		}
	}
}