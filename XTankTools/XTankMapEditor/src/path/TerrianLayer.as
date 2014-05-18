package path
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import x.game.manager.UIManager;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.battle.map.BattleMap;
	import views.MapView;
	import editordata.MapData;
	
	public class TerrianLayer extends XComponent
	{
		private var _mapView:MapView ;
		private var _mapData:MapData;
		
		public function TerrianLayer(skin:DisplayObject,mapView:MapView)
		{
			super(skin);
			_mapView = mapView ;
		}
		
		public function get skin():Sprite
		{
			return _skin as Sprite;
		}
		
		public function set mapData(value:MapData):void
		{
			clear();
			_mapData = value;
		}
		
		public function clear():void
		{
			DisplayObjectUtil.removeAllChildren(skin);
		}
		
		
		
		public function updateTBox():void
		{
			var terrianBd:BitmapData = UIManager.getBitmapData(_mapData.bgLayer);
			var _startX:uint;
			var _startY:uint;
			var _maxXIndex:uint = Math.ceil(BattleMap.WIDTH / terrianBd.width);
			var _maxYIndex:uint = Math.ceil(BattleMap.HEIGHT / terrianBd.height);
			
			var c:Bitmap;
			for (var i:uint = 0; i < _maxYIndex; i++)
			{
				for (var j:uint = 0; j < _maxXIndex; j++)
				{
					c = new Bitmap(terrianBd);
					c.x = _startX;
					c.y = _startY;
					skin.addChild(c);
					//
					_startX += terrianBd.width;
				}
				_startX = 0;
				_startY += terrianBd.height;
			}
			
			for (var k:uint = 0; k < _mapData.lowLayer.length; k++)
			{
				skin.addChild(_mapData.lowLayer[k].res);
			}
			
		}
	}
}