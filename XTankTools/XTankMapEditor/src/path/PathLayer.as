package path
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import de.polygonal.ds.HashMap;
	
	import editordata.MapData;
	
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.battle.map.BattleMap;

	public class PathLayer extends XComponent
	{
		private var _mapData:MapData;
		private var _unPassData:HashMap = new HashMap(); // 不可通过的点集合

		public function PathLayer(skin:DisplayObject)
		{
			super(skin);
			skin.addEventListener(MouseEvent.CLICK, onLayerClick);
		}

		private function onLayerClick(event:MouseEvent):void
		{
//			
			var targetX:int = Math.floor(event.localX / 10);
			var targetY:int = Math.floor(event.localY / 10);
			if (targetX >= 0 && targetX <= 95 && targetY >= 0 && targetY <= 55)
			{
				var ps:Vector.<Point> = _mapData.pathLayer;
				var len:uint = ps.length;
				var p:Point;
				var remove:Boolean = false;
				for (var i:uint = 0; i < len; i++)
				{
					p = ps[i];
					//
					if (p.x == targetX && p.y == targetY)
					{
						var index:int = _mapData.pathLayer.indexOf(p);
						if (index != -1)
						{
							remove = true;
							_mapData.pathLayer.splice(index, 1);
							removeOccpy(targetX + ',' + targetY);
						}
						refreshPathView();
						break;
					}
				}
				if (!remove)
				{
					_mapData.pathLayer.push(new Point(targetX, targetY));
					addOccpy(targetX + ',' + targetY);
				}
				refreshPathView();
			}
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

		public function refreshPathView():void
		{
			skin.graphics.clear();
			skin.graphics.lineStyle(1, 0x000000, .5);
			//
			for (var k:uint = 0; k < BattleMap.WIDTH / 10; k++)
			{
				skin.graphics.moveTo(10 * k, 0);
				skin.graphics.lineTo(10 * k, 560);
			}
			//
			for (var l:uint = 0; l < BattleMap.HEIGHT / 10; l++)
			{
				skin.graphics.moveTo(0, 10 * l);
				skin.graphics.lineTo(960, 10 * l);
			}
			//
			for (var i:uint = 0; i < BattleMap.HEIGHT / 10; i++)
			{
				for (var j:uint = 0; j < BattleMap.WIDTH / 10; j++)
				{
					if (!canPath(j, i))
					{
//						trace(j, i,false) ;
						skin.graphics.beginFill(0xFF0000, .5);
						skin.graphics.drawRect(10 * j + 1, 10 * i + 1, 8, 8);
					}
					else
					{
//						trace(j, i,true) ;
						skin.graphics.beginFill(0x00FF00, .2);
						skin.graphics.drawRect(10 * j + 1, 10 * i + 1, 8, 8);
					}
				}
			}
			skin.graphics.endFill();
		}

		public function udpatePBox():void
		{
			for each (var p:Point in _mapData.pathLayer)
			{
				_unPassData.set(p.x + ',' + p.y, 1);
			}
			refreshPathView();
		}

		public function addOccpy(key:String):void
		{
			var count:uint ;
			if (_unPassData.hasKey(key))
			{
				count = uint(_unPassData.get(key));
				count += 1;
				_unPassData.remap(key, count);
			}
			else
			{
				count = 1 ;
				_unPassData.set(key, count);
			}
//			trace("addOccpy",key,_unPassData.get(key),canPath2(key.split(",")[0],key.split(",")[1]));
			
		}

		public function removeOccpy(key:String):void
		{
			if (_unPassData.hasKey(key))
			{
				var count:uint = uint(_unPassData.get(key));
				if (count > 1)
				{
					count -= 1;
				}
				else
				{
					count = 0 ;
				}
				_unPassData.remap(key, count);
				//
//				trace("removeOccpy:", key, _unPassData.get(key),canPath2(key.split(",")[0],key.split(",")[1]));
			}
		}
		
		public function canPath2(mapx:uint, mapy:uint):Boolean
		{
			var key:String = mapx + "," + mapy;
			if(_unPassData.hasKey(key) == false)
			{
				return true ;
			}
			else if(_unPassData.get(key) <= 0)
			{
				return true ;
			}
			else
			{
				return false ;
			}
		}
		
		public function canPath(mapx:uint, mapy:uint):Boolean
		{
			var key:String = mapx + "," + mapy;
			if(_unPassData.hasKey(key) == false)
			{
				return true ;
			}
			else if(_unPassData.get(key) <= 0)
			{
				return true ;
			}
			else
			{
				return false ;
			}
		}

		public function clear():void
		{
			_unPassData.clear();
			DisplayObjectUtil.removeAllChildren(skin);
		}
	}
}
