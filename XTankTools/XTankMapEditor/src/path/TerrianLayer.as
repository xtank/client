package path
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import editordata.MapData;
	import editordata.TerrierData;
	
	import events.TerrianEvent;
	
	import views.MapView;
	
	import x.game.manager.UIManager;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.battle.map.BattleMap;
	
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
			
			//
			for (var k:uint = 0; k < _mapData.lowLayer.length; k++)
			{
				_mapData.lowLayer[k].changeFun  = onMoveFun ;
				skin.addChild(_mapData.lowLayer[k].res);
			}
			//
		}
		
		public function addTerrian(event:TerrianEvent):void
		{
			var p:Point = skin.globalToLocal(event.stagePoint);
			
			if (p.x < 960 && p.y < 560)
			{
				var terrierData:TerrierData = new TerrierData() ;
				terrierData.id = event.info.id ;
				terrierData.reg = new Point(event.stagePoint.x, event.stagePoint.y);
				terrierData.changeFun = onMoveFun ;
				_mapData.addTerrier(terrierData) ;
				//
				skin.addChild(terrierData.res);
			}
		}
		
		private function onMoveFun(elem:TerrierData):void
		{
			if (elem.res.x < 960 && elem.res.y < 560)
			{
				elem.reg = new Point(elem.res.x, elem.res.y);
			}
			else
			{
				_mapData.lowLayer.splice(_mapData.lowLayer.indexOf(elem), 1);
				DisplayObjectUtil.removeFromParent(elem.res);
			}
		}
	}
}