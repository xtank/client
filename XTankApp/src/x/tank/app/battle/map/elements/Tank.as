package x.tank.app.battle.map.elements
{
	import flash.display.Sprite;
	
	import onlineproto.battle_member_data_t;
	
	
	/** 坦克 */
	public class Tank extends BaseMapElement
	{
		private var _memberData:battle_member_data_t ;
		
		public function Tank(memberData:battle_member_data_t)
		{
			super(null);
			_passable = false ;
		}
		
		public function get tankSkin():Sprite
		{
			return _skin as Sprite ;
		}
		
		public function get memberData():battle_member_data_t
		{
			return _memberData ;
		}
	}
}