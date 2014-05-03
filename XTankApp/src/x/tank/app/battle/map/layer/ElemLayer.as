package x.tank.app.battle.map.layer
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import x.game.manager.UIManager;
	import x.game.tick.TimeTicker;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.game.util.StringUtil;
	import x.tank.app.battle.map.elements.Barrier;
	import x.tank.app.battle.map.elements.BaseMapElement;
	import x.tank.app.battle.map.elements.Tank;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.MapConfigInfo;

	// 1. 需要实时排序
	public class ElemLayer extends XComponent
	{
		private var _intervalIndex:uint ;
		private var _elems:Vector.<BaseMapElement>;
		private var _tanks:Vector.<Tank>;

		public function ElemLayer(mapConfigInfo:MapConfigInfo)
		{
			super(new Sprite());
			initLayer(mapConfigInfo);
		}

		override public function dispose():void
		{
			if(_intervalIndex != 0)
			{
				TimeTicker.clear(_intervalIndex) ;
			}
			DisplayObjectUtil.removeFromParent(layerSkin);
			super.dispose();
		}

		public function get layerSkin():Sprite
		{
			return _skin as Sprite;
		}

		private function initLayer(mapConfigInfo:MapConfigInfo):void
		{
			_elems = new Vector.<BaseMapElement>();
			//
			var elements:Array = mapConfigInfo.elemLayer.split(";"); //1-41,0;1-42,0;
			var barrier:Barrier ;
			for each(var ele:String in elements)
			{
				ele = StringUtil.removeWhitespace(ele) ;
				if(!StringUtil.isBlank(ele))
				{
					var infos:Array = ele.split("-") ;
					var bitMap:Bitmap = new Bitmap(UIManager.getBitmapData("Barrier_" + infos[0])) ;
					barrier = new Barrier(bitMap,DataProxyManager.barrierData.getBarrier(infos[0])) ;
					barrier.mapx = String(infos[1]).split(",")[0] ; // 96 * 56
					barrier.mapy = String(infos[1]).split(",")[1] ; // 96 * 56
					_elems.push(barrier) ;
					//
					layerSkin.addChild(barrier.barrierSkin) ;
				}
			}
			//
			_intervalIndex = TimeTicker.setInterval(1000,onSortElements) ;
		}
		
		private function onSortElements(dtime:Number):void
		{
			
		}

		public function addTank(tank:Tank):void
		{
			if (_tanks == null)
			{
				_tanks = new Vector.<Tank>();
			}
			_tanks.push(tank);
			_elems.push(tank);
			//
			layerSkin.addChild(tank.tankSkin);
		}

		//
		public function getTankByUserId(userId:uint):Tank
		{
			var result:Tank ;
			var len:uint = _tanks.length;
			for (var i:uint = 0; i < len; i++)
			{
				if(_tanks[i].memberData.userid == userId)
				{
					result = _tanks[i];break;
				}
			}
			return result ;
		}
	}
}
