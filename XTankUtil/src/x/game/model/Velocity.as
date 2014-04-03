package x.game.model
{
    import x.game.util.MathUtil;
	
	/**
	 * 矢量
	 * @author fraser
	 */
	public class Velocity 
	{
		/** 速度 */
		private var _speed:Number ;
		/** 角度 */
		private var _angle:Number ;
		
		public function Velocity(speed:Number = 0,angle:Number = 0) 
		{
			_speed = speed ;
			_angle = angle ;
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
		
		public function get angle():Number 
		{
			return _angle;
		}
		
		public function set angle(value:Number):void 
		{
			_angle = value;
		}

		public function get vx():Number
		{
			return Math.cos(MathUtil.angle2radius(_angle)) * _speed ;
		}

		public function get vy():Number
		{
			return Math.sin(MathUtil.angle2radius(_angle)) * _speed ;
		}
		
		//
		public function add(velocity:Velocity):void
		{
			var a:Number = vx + velocity.vx ;
			var b:Number = vy + velocity.vy ;
			//
			angle = MathUtil.radius2angle(Math.atan2(b, a)) ;
			speed = Math.sqrt(a * a + b * b) ;
		}		
	}

}