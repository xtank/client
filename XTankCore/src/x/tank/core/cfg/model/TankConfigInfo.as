package x.tank.core.cfg.model
{

	public class TankConfigInfo
	{
		// <tank id="1" hp="100" speed="10" defense="10" attack="10"
		// attackSpeed="2" attackScope="50"/>
		private var _id:uint;
		private var _name:String;
		private var _hp:uint;
		private var _speed:uint;
		private var _defense:uint;
		private var _attack:uint;
		private var _attackSpeed:uint;
		private var _attackScope:uint;

		public function TankConfigInfo(xml:XML)
		{
			_id = xml.@id;
			_name = xml.@name;
			_hp = xml.@hp;
			_speed = xml.@speed;
			_defense = xml.@defense;
			_attack = xml.@attack;
			_attackSpeed = xml.@attackSpeed;
			_attackScope = xml.@attackScope;
		}

		public function get id():uint
		{
			return _id;
		}

		public function get name():String
		{
			return _name;
		}

		public function get hp():uint
		{
			return _hp;
		}

		public function get speed():uint
		{
			return _speed;
		}

		public function get defense():uint
		{
			return _defense;
		}

		public function get attack():uint
		{
			return _attack;
		}

		public function get attackSpeed():uint
		{
			return _attackSpeed;
		}

		public function get attackScope():uint
		{
			return _attackScope;
		}
	}
}
