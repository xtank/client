package x.tank.app.battle.map
{
	import flash.display.Sprite;
	
	import x.game.ui.XComponent;
	import x.tank.app.battle.map.layer.BgLayer;
	import x.tank.app.battle.map.layer.ElemLayer;
	import x.tank.app.battle.map.layer.PathLayer;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.MapConfigInfo;

//	地图的设置初稿:
//	
//	960 * 560 
//	
//	单元格切割为 10 * 10
//	
//	层级:
//	------------------------------------------
//	1.底层 (放置背景图片)
//	2.内容层(放置坦克和各类地图元素)
//	3.寻路层 (A*算法)
//	4.顶层 (天气 ,战争迷雾等拓展功能预留层)
//	------------------------------------------
	public class BattleMap extends XComponent
	{
		public static const WIDTH:uint = 960 ;
		public static const HEIGHT:uint = 560 ;
		//
		private var _mapConfigInfo:MapConfigInfo ;
		private var _bgLayer:BgLayer ;
		private var _elemLayer:ElemLayer ;
		private var _pathLayer:PathLayer ;
		
		public function BattleMap(mapId:uint)
		{
			super(new Sprite()) ;
			_mapConfigInfo = DataProxyManager.mapData.getMapInfo(mapId) ;
			// 寻路层
			_pathLayer = new PathLayer(_mapConfigInfo) ;
			// 背景层
			_bgLayer = new BgLayer(_mapConfigInfo) ;
			mapSkin.addChild(_bgLayer.layerSkin) ;
			// 元素层
			_elemLayer = new ElemLayer(this,_mapConfigInfo) ;
			//
			mapSkin.addChild(_elemLayer.layerSkin) ;
			mapSkin.addChild(_pathLayer.layerSkin) ;
		}
		
		public function get mapSkin():Sprite
		{
			return _skin as Sprite ;
		}
		
		override public function dispose():void
		{
			_bgLayer.dispose() ;
			_elemLayer.dispose() ;
			_pathLayer.dispose() ;
			//
			super.dispose() ;
		}
		
		public function get pathLayer():PathLayer
		{
			return _pathLayer ;
		}
	}
}