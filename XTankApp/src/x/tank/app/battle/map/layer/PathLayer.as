package x.tank.app.battle.map.layer
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import de.polygonal.ds.HashMap;
	
	import x.game.ui.XComponent;
	import x.tank.app.battle.map.BattleMap;
	import x.tank.app.battle.map.elements.BaseMapElement;
	import x.tank.core.cfg.model.MapConfigInfo;

	public class PathLayer extends XComponent
	{
		private var _mapConfigInfo:MapConfigInfo;
		private var _unPassData:HashMap; // 不可通过的点集合

		public function PathLayer(mapConfigInfo:MapConfigInfo)
		{
			super(new Sprite());
			_mapConfigInfo = mapConfigInfo;
			initLayer();
		}

		public function get layerSkin():Sprite
		{
			return _skin as Sprite;
		}
		
		public function refresh():void
		{
			layerSkin.graphics.clear() ;
			layerSkin.graphics.lineStyle(1, 0x000000, .5);
			//
			for (var k:uint = 0; k < BattleMap.WIDTH / 10; k++)
			{
				layerSkin.graphics.moveTo(10 * k, 0);
				layerSkin.graphics.lineTo(10 * k, 560);
			}
			//
			for (var l:uint = 0; l < BattleMap.HEIGHT / 10; l++)
			{
				layerSkin.graphics.moveTo(0, 10 * l);
				layerSkin.graphics.lineTo(960, 10 * l);
			}
			//
			layerSkin.graphics.beginFill(0x0FF0000, .5);
			for (var i:uint = 0; i < BattleMap.HEIGHT/10; i++)
			{
				for (var j:uint = 0; j < BattleMap.WIDTH/10; j++)
				{
					if (!canPath(j, i))
					{
						layerSkin.graphics.drawRect(10 * j + 1, 10 * i + 1, 8, 8);
					}
				}
			}
			layerSkin.graphics.endFill();
		}
		
		private function initLayer():void
		{
			_unPassData = new HashMap();
			var pathData:Array = _mapConfigInfo.pathLayer.split(";") ;
			for each(var p:String in pathData)
			{
				_unPassData.set(p,1) ;
			}
		}
		
		public function initElements(elems:Vector.<BaseMapElement>):void
		{
			for each(var elem:BaseMapElement in elems)
			{
				addBaseMapElement(elem) ;
			}
		}
		
		public function addBaseMapElement(elem:BaseMapElement):void
		{
			var mapx:int ;
			var mapy:int ;
			var key:String ;
			for each(var p:Point in elem.occpys)
			{
				mapx = elem.mapx + p.x ;
				mapy = elem.mapy + p.y ;
				key = mapx + "," + mapy ;
				if(_unPassData.hasKey(key))
				{
					var count:uint = uint(_unPassData.get(key)) ;
					_unPassData.set(key,++count) ;
				}
				else
				{
					_unPassData.set(key,1) ;
				}
			}
		}
		
		public function removeBaseMapElement(elem:BaseMapElement):void
		{
			var mapx:int ;
			var mapy:int ;
			var key:String ;
			for each(var p:Point in elem.occpys)
			{
				mapx = elem.mapx + p.x ;
				mapy = elem.mapy + p.y ;
				key = mapx + "," + mapy ;
				if(_unPassData.hasKey(key))
				{
					var count:uint = uint(_unPassData.get(key)) ;
					if(count > 1)
					{
						_unPassData.set(key,--count) ;
					}
					else
					{
						_unPassData.clr(key) ;
					}
				}
			}
		}

		public function canPath(mapx:uint, mapy:uint):Boolean
		{
			var key:String = mapx + "," + mapy ;
			return !_unPassData.hasKey(key) ;
		}
	}
}
