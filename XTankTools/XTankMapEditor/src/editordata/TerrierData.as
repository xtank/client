package editordata
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import x.game.manager.UIManager;

	public class TerrierData
	{
		public var id:uint ;
		private var _reg:Point ;
		private var _res:Sprite ;
		//
		private var _changeFun:Function ;
		
		public function TerrierData()
		{
		}
		
		public function set changeFun(value:Function):void
		{
			_changeFun = value ;
		}
		
		public function get reg():Point
		{
			return _reg;
		}
		
		public function set reg(value:Point):void
		{
			_reg = value;
		}
		
		public function get res():Sprite
		{
			if(_res == null)
			{
				_res = new Sprite() ;
				//
				var bitMap:Bitmap = new Bitmap(UIManager.getBitmapData("Tank_Bg_" + id)) ;
				_res.addChild(bitMap) ;
				_res.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown) ;
				_res.x = _reg.x 
				_res.y = _reg.y ;
			}
			return _res ;
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			_res.startDrag() ;
			_res.addEventListener(MouseEvent.MOUSE_UP,onMouseUp) ;
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_res.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp) ;
			_res.stopDrag() ;
			//
			if(_changeFun != null)
			{
				_changeFun(this) ;
			}
		}
		
		public function get description():String
		{
			return id+"-"+reg.x+","+reg.y ;
		}
	}
}