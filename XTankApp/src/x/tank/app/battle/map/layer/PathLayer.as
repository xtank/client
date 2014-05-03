package x.tank.app.battle.map.layer
{
	import flash.display.Sprite;
	
	import de.polygonal.ds.HashMap;
	
	import x.game.model.ScopeValue;
	import x.game.ui.XComponent;
	import x.game.util.StringUtil;
	import x.tank.app.battle.map.BattleMap;
	import x.tank.core.cfg.model.MapConfigInfo;

	public class PathLayer extends XComponent
	{
		private var _mapConfigInfo:MapConfigInfo;
		private var _pathData:HashMap;

		public function PathLayer(mapConfigInfo:MapConfigInfo)
		{
			super(new Sprite());
			_mapConfigInfo = mapConfigInfo;
			initLayer(_mapConfigInfo);
			drawLayer();
		}

		public function get layerSkin():Sprite
		{
			return _skin as Sprite;
		}

		private function drawLayer():void
		{
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
					if (!getPath(j, i))
					{
						layerSkin.graphics.drawRect(10 * j + 1, 10 * i + 1, 8, 8);
					}
				}
			}
			layerSkin.graphics.endFill();
		}

		private function initLayer(mapConfigInfo:MapConfigInfo):void
		{
			_pathData = new HashMap();
			//
			var lineIndex:uint;
			var pathData:Array = mapConfigInfo.pathLayer.split(";"); // 0-95:1;
			var scopeData:Vector.<ScopeValue>;
			while (pathData.length > 0)
			{
				var info:String = StringUtil.removeWhitespace(pathData.shift());
				if (!StringUtil.isBlank(info))
				{
					var a:Array = info.split(":");
					var b:Array = String(a[0]).split("-");
					if (info.charAt(0) != '0')
					{
						scopeData.push(ScopeValue.createScopeValue(b[0], b[1], a[1]));
					}
					else
					{
						// 创建新行
						scopeData = new Vector.<ScopeValue>();
						_pathData.set(lineIndex, scopeData);
						scopeData.push(ScopeValue.createScopeValue(b[0], b[1], a[1]));
						lineIndex++;
					}
				}
			}
		}

		public function getPath(mapx:uint, mapy:uint):Boolean
		{
			var rs:Boolean;
			var scopeData:Vector.<ScopeValue> = _pathData.get(mapy) as Vector.<ScopeValue>;
			var len:uint = scopeData.length;
			for (var i:uint = 0; i < len; i++)
			{
				if (scopeData[i].isInScope(mapx))
				{
					rs = (uint(scopeData[i].data) == 1);
					break;
				}
			}
			return rs;
		}
	}
}
