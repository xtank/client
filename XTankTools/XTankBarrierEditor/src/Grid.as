package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import x.game.ui.XComponent;
	
	public class Grid extends XComponent
	{
		public var mapx:int ;
		public var mapy:int ;
		private var _onGridClick:Function ;
		private var _isOccpy:Boolean =  false ;
		
		public function Grid(mapx:int,mapy:int,onGridClick:Function)
		{
			super(new Sprite());
			this.mapx = mapx ;
			this.mapy = mapy ;
			//
			occpy = false ;
			//
			gridSkin.x = mapx * 20 ;
			gridSkin.y = mapy * 20 ;
			//
			gridSkin.useHandCursor = true ;
			gridSkin.buttonMode = true ;
			gridSkin.addEventListener(MouseEvent.CLICK,onClick) ;
			_onGridClick = onGridClick ;
		}
		
		public function set occpy(value:Boolean):void
		{
			_isOccpy = value ;
			gridSkin.graphics.clear() ;
			if(_isOccpy)
			{
				gridSkin.graphics.beginFill(0xFF0000,.7) ;
			}
			else
			{
				gridSkin.graphics.beginFill(0x000000,.3) ;
			}
			gridSkin.graphics.drawRect(-9,-9,18,18) ;
			gridSkin.graphics.endFill() ;
		}
		
		private function onClick(event:MouseEvent):void
		{
			_onGridClick(mapx,mapy) ;
			occpy = !_isOccpy ;
		}
		
		public function get gridSkin():Sprite
		{
			return _skin as Sprite ;
		}
		
		public function get description():String
		{
			return "" ;
		}
	}
}