package path
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import events.BarrierEvent;
	
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import views.MapView;
	import editordata.ElemeData;
	import editordata.MapData;
	
	public class BarrierLayer extends XComponent
	{
		private var _mapView:MapView ;
		private var _mapData:MapData ;
		
		public function BarrierLayer(skin:DisplayObject,mapView:MapView)
		{
			super(skin);
			_mapView = mapView ;
		}
		
		public function get skin():Sprite 
		{
			return _skin as Sprite ;
		}
		
		public function set mapData(value:MapData):void
		{
			clear() ;
			_mapData = value ;
		}
		
		public function updateBBox():void
		{
			initElements(_mapData.elemLayer);
			refreshBView();
		}
		
		private function initElements(elems:Vector.<ElemeData>):void
		{
			for each (var elem:ElemeData in elems)
			{
				elem.changeFun = moveBaseMapElement;
				addBaseMapElement(elem);
			}
		}
		
		private function moveBaseMapElement(elem:ElemeData):void
		{
			removeBaseMapElement(elem);
			//
			var mapx:uint = Math.floor((elem.res.x - elem.barrierConfigInfo.reg.x) / ElemeData.GRID_WIDTH);
			var mapy:uint = Math.floor((elem.res.y - elem.barrierConfigInfo.reg.y) / ElemeData.GRID_HEIGHT);
			
			if (mapx < 96 && mapy < 56)
			{
				elem.reg = new Point(mapx, mapy);
				addBaseMapElement(elem);
				refreshBView();
			}
			else
			{
				_mapData.elemLayer.splice(_mapData.elemLayer.indexOf(elem), 1);
				DisplayObjectUtil.removeFromParent(elem.res);
			}
			_mapView.pBox.refreshPathView();
		}
		
		private function addBaseMapElement(elem:ElemeData):void
		{
			var mapx:int;
			var mapy:int;
			var key:String;
			for each (var p:Point in elem.occpys)
			{
				mapx = elem.reg.x + p.x;
				mapy = elem.reg.y + p.y;
				key = mapx + "," + mapy;
				_mapView.pBox.addOccpy(key) ;
			}
		}
		
		
		public function addBarrier(event:BarrierEvent):void
		{
			var p:Point = skin.globalToLocal(event.stagePoint);
			var mapx:uint = Math.floor((p.x - event.info.reg.x) / ElemeData.GRID_WIDTH);
			var mapy:uint = Math.floor((p.y - event.info.reg.y) / ElemeData.GRID_HEIGHT);
			
			if (mapx < 96 && mapy < 56)
			{
				var rs:Boolean = true;
				for each (var elem:ElemeData in _mapData.elemLayer)
				{
					if (elem.reg.x == mapx && elem.reg.y == mapy)
					{
						rs = false;
						break;
					}
				}
				//
				if (rs)
				{
					var elem2:ElemeData = new ElemeData();
					elem2.id = event.info.id;
					elem2.reg = new Point(mapx, mapy);
					elem2.changeFun = moveBaseMapElement;
					_mapData.elemLayer.push(elem2);
					addBaseMapElement(elem2);
					refreshBView();
				}
			}
			_mapView.pBox.refreshPathView();
		}
		
		private function removeBaseMapElement(elem:ElemeData):void
		{
			var mapx:int;
			var mapy:int;
			var key:String;
			for each (var p:Point in elem.occpys)
			{
				mapx = elem.reg.x + p.x;
				mapy = elem.reg.y + p.y;
				key = mapx + "," + mapy;
				_mapView.pBox.removeOccpy(key) ;
			}
		}
		
		public function refreshBView():void
		{
			var elems:Vector.<ElemeData> = _mapData.elemLayer.sort(function(a:ElemeData, b:ElemeData):int
			{
				if (a.reg.y > b.reg.y)
				{
					return 1;
				}
				else if (a.reg.y < b.reg.y)
				{
					return -1
				}
				else
				{
					if (a.reg.x > b.reg.x)
					{
						return 1;
					}
					else
					{
						return -1;
					}
				}
			});
			var len:uint = elems.length;
			for (var i:uint = 0; i < len; i++)
			{
				skin.addChild(elems[i].res);
			}
		}
		
		public function clear():void
		{
			DisplayObjectUtil.removeAllChildren(skin);
		}
	}
}