package x.tank.core.cfg.model
{
	import flash.geom.Point;
	
	import x.game.util.StringUtil;

	public class MapDataTeamInfo
	{
		private var _id:uint;
		private var _count:uint;
		private var _home:Point;
		private var _members:Vector.<MapDataTeamMemberInfo> = new Vector.<MapDataTeamMemberInfo>();

		public function MapDataTeamInfo(xml:XML)
		{
			_id = xml.@id;
			_count = xml.@count;
			var homeContent:String = String(xml.@home);
			homeContent = StringUtil.isBlank(homeContent) ? "0,0" : homeContent;
			var home:Array = String(xml.@home).split(",");
			_home = new Point(home[0], home[1]);
			//
			var mems:XMLList = xml.member;
			for each (var mem:XML in mems)
			{
				var m:String = mem.@born;
				m = StringUtil.isBlank(m) ? "0,0" : m;
				var p:Array = m.split(",");
				_members.push(new MapDataTeamMemberInfo(new Point(p[0], p[1]), uint(mem.@id)));
			}
		}

		public function get id():uint
		{
			return _id;
		}

		public function get count():uint
		{
			return _count;
		}

		public function get members():Vector.<MapDataTeamMemberInfo>
		{
			return _members;
		}
	}
}
