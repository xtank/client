 package x.tank.app.battle.map.layer
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import x.game.manager.UIManager;
	import x.game.tick.TimeTicker;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.game.util.StringUtil;
	import x.tank.app.battle.map.BattleMap;
	import x.tank.app.battle.map.elements.Barrier;
	import x.tank.app.battle.map.elements.BaseMapElement;
	import x.tank.app.battle.map.elements.Home;
	import x.tank.app.battle.map.tank.Tank;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.BarrierConfigInfo;
	import x.tank.core.cfg.model.MapConfigInfo;

	// 1. 需要实时排序
	public class ElemLayer extends XComponent
	{
		private var _battleMap:BattleMap;
		//
		private var _sortIntervalIndex:uint ;
		private var _rendererIntervalIndex:uint ;
		//
		private var _elems:Vector.<BaseMapElement>;
		private var _tanks:Vector.<Tank>;
		private var _homes:Vector.<Home> ;

		public function ElemLayer(battleMap:BattleMap,mapConfigInfo:MapConfigInfo)
		{
			super(new Sprite());
			_battleMap = battleMap ;
			initLayer(mapConfigInfo);
		}

		override public function dispose():void
		{
			if(_sortIntervalIndex != 0)
			{
				TimeTicker.clear(_sortIntervalIndex) ;
			}
			//
			if(_rendererIntervalIndex != 0)
			{
				TimeTicker.clear(_rendererIntervalIndex) ;
			}
			//
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
					var configInfo:BarrierConfigInfo = DataProxyManager.barrierData.getBarrier(infos[0]) ;
					//
					barrier = new Barrier(bitMap,configInfo) ;
					barrier.mapx = String(infos[1]).split(",")[0] ; // 96 * 56
					barrier.mapy = String(infos[1]).split(",")[1] ; // 96 * 56
					_elems.push(barrier) ;
					//
					layerSkin.addChild(barrier.elementSkin) ;
				}
			}
			//
			_battleMap.pathLayer.initElements(_elems) ;
			_battleMap.pathLayer.refresh() ;
			//
			_sortIntervalIndex = TimeTicker.setInterval(1000,onSortElements) ;
			_rendererIntervalIndex = TimeTicker.setInterval(200,onRendererElements) ;
		}
		
		private function onRendererElements(dtime:Number):void
		{
			for each(var elem:BaseMapElement in _elems)
			{
				elem.renderer() ;
			}
		}
		
		// 定时排序
		private function onSortElements(dtime:Number):void
		{
			_elems = _elems.sort(function(a:BaseMapElement,b:BaseMapElement):int{
				if(a.mapy > b.mapy)
				{
					return 1 ;
				}
				else if(a.mapy < b.mapy)
				{
					return -1
				}
				else
				{
					if(a.mapx > b.mapx)
					{
						return 1 ;
					}
					else
					{
						return -1 ;
					}
				}
			}) ;
			var len:uint = _elems.length ;
			for(var i:uint = 0;i<len;i++)
			{
				layerSkin.addChild(_elems[i].elementSkin) ;
			}
			//trace("sort...");
		}
		
		public function addHome(home:Home):void
		{
			if(_homes == null)
			{
				_homes = new Vector.<Home>() ;
			}
			_homes.push(home) ;
			_elems.push(home);
			//
			layerSkin.addChild(home.elementSkin);
		}
		
		public function getHomeByTeamId(teamId:uint):Home
		{
			var result:Home ;
			var len:uint = _homes.length;
			for (var i:uint = 0; i < len; i++)
			{
				if(_homes[i].teamData.teamid == teamId)
				{
					result = _homes[i];break;
				}
			}
			return result ;
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
