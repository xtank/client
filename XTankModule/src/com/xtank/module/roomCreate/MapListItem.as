package com.xtank.module.roomCreate
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import x.game.ui.list.XListItem;
	import x.game.util.DisplayObjectUtil;
	import x.tank.core.cfg.model.MapConfigInfo;

	public class MapListItem extends XListItem
	{
		private var _clickHandler:Function ;
		private var _mapName:TextField;

		public function MapListItem(data:MapConfigInfo,clickHandler:Function)
		{
			super(new MapListItemUI());
			_mapName = _skin["mapName"];
			DisplayObjectUtil.disableTarget(_mapName);
			//
			_mapName.text = "";
			_clickHandler = clickHandler ;
			skin.addEventListener(MouseEvent.CLICK,onClick) ;
			skin.buttonMode = true ;
			skin.useHandCursor = true ;
			this.data = data;
		}
		
		override public function dispose():void
		{
			_clickHandler = null ;
			skin.removeEventListener(MouseEvent.CLICK,onClick) ;
			super.dispose() ;
		}

		// 根据新刷入的数据  更新视图
		override protected function updateItemView():void
		{
			var mapConfigInfo:MapConfigInfo = data as MapConfigInfo;
			_mapName.text = mapConfigInfo.name;
		}

		// 无数据时显示的内容
		override protected function updateNullDataItemView():void
		{
			_mapName.text = "";
		}

		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			skin.gotoAndStop(selected ? 2 : 1);
		}
		
		private function onClick(event:MouseEvent):void
		{
			if(_clickHandler != null)
			{
				_clickHandler((data as MapConfigInfo).id)  ;
			}
		}
	}
}
