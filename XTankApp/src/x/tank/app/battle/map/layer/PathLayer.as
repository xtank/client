package x.tank.app.battle.map.layer
{
	import flash.display.Sprite;
	
	import de.polygonal.ds.HashMap;
	
	import x.game.ui.XComponent;
	import x.tank.app.battle.map.BattleMap;
	import x.tank.core.cfg.model.MapConfigInfo;

	public class PathLayer extends XComponent
	{
		private var _mapConfigInfo:MapConfigInfo;
		private var _unPassData:HashMap; // 不可通过的点集合

		public function PathLayer(mapConfigInfo:MapConfigInfo)
		{
			super(new Sprite());
			_mapConfigInfo = mapConfigInfo;
			initLayer(_mapConfigInfo);
		}

		public function get layerSkin():Sprite
		{
			return _skin as Sprite;
		}

		private function initLayer(mapConfigInfo:MapConfigInfo):void
		{
			_unPassData = new HashMap();
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
			layerSkin.graphics.beginFill(0x000000, .5);
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

		public function canPath(mapx:uint, mapy:uint):Boolean
		{
			var key:String = mapx + "_" + mapy ;
			return !_unPassData.hasKey(key) ;
		}
	}
}
