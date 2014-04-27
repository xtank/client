package x.tank.core.cfg.model
{

	public class MapConfigInfo
	{
		private var _id:uint;
		private var _name:String;
		private var _difficult:uint;
		private var _res:uint;
		public var teams:Vector.<MapDataTeamInfo>;

		public function MapConfigInfo(xml:XML)
		{
			_id = xml.@id;
			_name = xml.@name;
			_difficult = xml.@difficult;
			_res = xml.@res;
			//
			teams = new Vector.<MapDataTeamInfo>();
			var teamInfos:XMLList = xml.team;
			for each (var teamInfo:XML in teamInfos)
			{
				teams.push(new MapDataTeamInfo(teamInfo));
			}
		}

		public function get id():uint
		{
			return _id;
		}

		public function get name():String
		{
			return _name;
		}

		public function get difficult():uint
		{
			return _difficult;
		}

		public function get res():uint
		{
			return _res;
		}

		public function get teamLimitCount():uint
		{
			return teams.length;
		}

		public function get playerLimitCount():uint
		{
			var rs:uint = 0;
			for each (var teamInfo:MapDataTeamInfo in teams)
			{
				rs += teamInfo.count;
			}
			return rs;
		}
	}
}
