package x.tank.core.cfg.model
{
	public class MapConfigInfo
	{
		public var id:uint ;
		public var name:String ;
		public var difficult:uint ;
		public var res:uint ;
		public var teams:Vector.<MapDataTeamInfo> ;
		
		public function MapConfigInfo(xml:XML)
		{
			id = xml.@id ;
			name = xml.@name ;
			difficult = xml.@difficult ;
			res = xml.@res ;
			//
			teams = new Vector.<MapDataTeamInfo>() ;
			var teamInfos:XMLList = xml.team ;
			for each(var teamInfo:XML in teamInfos)
			{
				teams.push(new MapDataTeamInfo(teamInfo)) ;
			}
		}
		
		public function get teamLimitCount():uint
		{
			return teams.length ;
		}
		
		public function get playerLimitCount():uint
		{
			var rs:uint = 0 ;
			for each(var teamInfo:MapDataTeamInfo in teams)
			{
				rs += teamInfo.count ;
			}
			return rs ;
		}
	}
}