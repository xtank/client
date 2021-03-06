package x.tank.core.cfg.model
{

	public class MapConfigInfo
	{
		private var _id:uint;
		private var _name:String;
		private var _difficult:uint;
		public var teams:Vector.<MapDataTeamInfo>;
		//
		private var _bgLayer:String ;
		private var _lowLayer:String ;
		private var _elemLayer:String ;
		private var _pathLayer:String ;

		public function MapConfigInfo(xml:XML)
		{
			_id = xml.@id;
			_name = xml.@name;
			_difficult = xml.@difficult;
			//
			teams = new Vector.<MapDataTeamInfo>();
			var teamInfos:XMLList = xml.team;
			for each (var teamInfo:XML in teamInfos)
			{
				teams.push(new MapDataTeamInfo(teamInfo));
			}
			//
			_bgLayer = (xml.bgLayer[0] as XML).toString() ;
			_lowLayer = (xml.lowLayer[0] as XML).toString() ;
			_elemLayer = (xml.elemLayer[0] as XML).toString() ;
			_pathLayer = (xml.pathLyaer[0] as XML).toString() ;
		}
		
		public function getTeamInfo(teamId:uint):MapDataTeamInfo
		{
			var rs:MapDataTeamInfo ;
			var len:uint = teams.length ;
			for(var i:uint = 0;i<len;i++)
			{
				if(teams[i].id == teamId)
				{
					rs = teams[id] ;break;
				}
			}
				return rs ;
		}

		public function get id():uint
		{
			return _id;
		}
		
		public function get elemLayer():String
		{
			return _elemLayer ;
		}
		
		public function get pathLayer():String
		{
			return _pathLayer ;
		}
		
		public function get lowLayer():String
		{
			return _lowLayer ;
		}
		
		public function get bgLayer():String
		{
			return _bgLayer ;
		}

		public function get name():String
		{
			return _name;
		}

		public function get difficult():uint
		{
			return _difficult;
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
