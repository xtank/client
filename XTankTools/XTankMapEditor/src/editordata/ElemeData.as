package editordata
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import x.game.manager.UIManager;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.BarrierConfigInfo;

	public class ElemeData
	{
		public static const GRID_WIDTH:uint = 10;
		public static const GRID_HEIGHT:uint = 10;
		//
		public var id:uint ;
		private var _reg:Point ;
		private var _res:Sprite ;
		//
		private var _changeFun:Function ;
		
		public function ElemeData()
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
			//
			if(_res != null)
			{
				_res.x = _reg.x * GRID_WIDTH + GRID_WIDTH/2 + barrierConfigInfo.reg.x;
				_res.y = _reg.y * GRID_HEIGHT + GRID_HEIGHT/2 + barrierConfigInfo.reg.y;
			}	
		}

		public function get res():Sprite
		{
			if(_res == null)
			{
				_res = new Sprite() ;
				//
				var bitMap:Bitmap = new Bitmap(UIManager.getBitmapData("Barrier_" + id)) ;
				_res.addChild(bitMap) ;
				_res.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown) ;
				_res.x = _reg.x * GRID_WIDTH + GRID_WIDTH/2 + barrierConfigInfo.reg.x;
				_res.y = _reg.y * GRID_HEIGHT + GRID_HEIGHT/2 + barrierConfigInfo.reg.y;
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
		
		public function get barrierConfigInfo():BarrierConfigInfo
		{
			return DataProxyManager.barrierData.getBarrier(id) ;
		}
		
		public function get occpys():Vector.<Point>
		{
			return DataProxyManager.barrierData.getBarrier(id).occpys ;
		}
	}
}