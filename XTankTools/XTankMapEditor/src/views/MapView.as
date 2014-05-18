package views
{
	import flash.display.Sprite;
	
	import path.BarrierLayer;
	import path.PathLayer;
	import path.TerrianLayer;
	
	import x.game.ui.XComponent;
	import x.game.ui.button.XButton;
	import x.game.ui.buttonbar.XButtonBar;
	import x.game.util.DisplayObjectUtil;
	import editordata.MapData;

	public class MapView extends XComponent
	{
		private var _bar:XButtonBar;
		private var _tBox:TerrianLayer;
		private var _pBox:PathLayer;
		private var _bBox:BarrierLayer;
		//
		private var _mapData:MapData;

		public function get mapData():MapData
		{
			return _mapData;
		}
		
		public function get pBox():PathLayer
		{
			return _pBox ;
		}
		
		public function get bBox():BarrierLayer 
		{
			return _bBox ;
		}

		public function MapView(skin:Sprite)
		{
			super(skin);
			_tBox = new TerrianLayer(skin['tBox'],this);
			_bBox = new BarrierLayer(skin['bBox'],this);
			_pBox = new PathLayer(skin['pathBox']);
			//
			_bar = new XButtonBar(skin["buttonBar"]);
			_bar.addButton(new XButton(_bar.skin['btn1'], 1), true);
			_bar.addButton(new XButton(_bar.skin['btn2'], 2));
			_bar.addButton(new XButton(_bar.skin['btn3'], 3));
			_bar.addChange(function(bar:XButtonBar):void
			{
				var d:uint = uint(bar.selectedButton.data);
				switch (d)
				{
					case 1:
						DisplayObjectUtil.disableTarget(_pBox.skin);
						DisplayObjectUtil.disableTarget(_tBox.skin);
						DisplayObjectUtil.enableTarget(_bBox.skin);
						_pBox.skin.visible = false ;
						skin.addChild(_bBox.skin);
						break;
					case 2:
						DisplayObjectUtil.disableTarget(_bBox.skin);
						DisplayObjectUtil.disableTarget(_tBox.skin);
						DisplayObjectUtil.enableTarget(_pBox.skin);
						_pBox.skin.visible = true ;
						skin.addChild(_pBox.skin);
						break;
					case 3:
						DisplayObjectUtil.disableTarget(_pBox.skin);
						DisplayObjectUtil.disableTarget(_bBox.skin);
						DisplayObjectUtil.enableTarget(_tBox.skin);
						_pBox.skin.visible = false ;
						skin.addChild(_tBox.skin);
						break;
				}
			});
		}

		public function updateMapId(mapId:uint):void
		{
			_mapData = DataManager.getMapData(mapId);
			//
			_tBox.clear() ;
			//
			_pBox.mapData = _mapData ;
			_bBox.mapData = _mapData ;
			_tBox.mapData = _mapData ;
			//
			_pBox.clear() ;
			_bBox.clear() ;
			//
			_bBox.updateBBox();
			_pBox.udpatePBox();
			//
			_tBox.updateTBox();
		}
	}
}
