package x.tank.app.battle.map.layer
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import x.game.tick.FrameTicker;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.battle.map.BattleMap;

	public class BgLayer extends XComponent
	{
		private var _terrianBd:BitmapData;

		public function BgLayer(terrianBD:BitmapData)
		{
			super(new Sprite());
			_terrianBd = terrianBD ;
			initLayer();
		}
		
		override public function dispose():void
		{
			DisplayObjectUtil.removeFromParent(layerSkin) ;
			super.dispose() ;
		}

		public function get layerSkin():Sprite
		{
			return _skin as Sprite;
		}

		private var _initTicker:uint ;
		private var _startX:uint ;
		private var _startY:uint ;
		private var _yIndex:uint ;
		//
		private var _maxXIndex:uint ;
		private var _maxYIndex:uint ;
		
		private function initLayer():void
		{
			_maxXIndex = Math.ceil(BattleMap.WIDTH / _terrianBd.width);
			_maxYIndex = Math.ceil(BattleMap.HEIGHT / _terrianBd.height);
			//
			_initTicker = FrameTicker.setInterval(onInitLine,1) ;
		}
		
		private function onInitLine(dtime:Number):void
		{
			if(_yIndex >= _maxYIndex)
			{
				FrameTicker.clearInterval(_initTicker) ;
			}
			else
			{
				var c:Bitmap ;
				for (var j:uint = 0; j < _maxXIndex; j++)
				{
					c = new Bitmap(_terrianBd) ;
					c.x = _startX ;
					c.y = _startY ;
					layerSkin.addChild(c) ;
					//
					_startX += _terrianBd.width;
				}
				_startX = 0 ;
				_startY += _terrianBd.height;
				_yIndex ++ ;
			}
		}
	}
}
