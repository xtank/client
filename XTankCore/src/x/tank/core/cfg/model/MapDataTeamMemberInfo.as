package x.tank.core.cfg.model
{
	import flash.geom.Point;

	public class MapDataTeamMemberInfo
	{
		private var _id:uint ;
		private var _born:Point ;
		
		public function MapDataTeamMemberInfo(born:Point,id:uint)
		{
			this._id = id ;
			this._born = born ;
		}
		
		public function get id():uint { return _id ;}
		
		public function get born():Point{return _born;}
	}
}