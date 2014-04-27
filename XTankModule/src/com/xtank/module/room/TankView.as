package com.xtank.module.room
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.core.cfg.model.TankConfigInfo;
	
	public class TankView extends XComponent
	{
		private var _selected:Boolean = false ;
		private var _selectedTag:MovieClip ;
		private var _tank:MovieClip ;
		private var _onClick:Function ;
		
		public function TankView(skin:DisplayObject,onClick:Function)
		{
			super(skin);
			_selectedTag = skin["tag"] ;
			_selectedTag.visible = false ;
			DisplayObjectUtil.disableTarget(_selectedTag) ;
			//
			_tank = skin["tank"];
			_tank.gotoAndStop(1) ;
			//DisplayObjectUtil.disableTarget(_tank) ;
			//
			_onClick = onClick ;
			skinTankView.useHandCursor = true ;
			skinTankView.buttonMode = true ;
			skinTankView.addEventListener(MouseEvent.CLICK,onTankClick) ;
		}
		
		public function get skinTankView():Sprite
		{
			return _skin as Sprite ;
		}
		
		override public function dispose():void
		{
			skinTankView.removeEventListener(MouseEvent.CLICK,onTankClick) ;
		}
		
		public function onTankClick(event:MouseEvent):void
		{
			if(data != null && _onClick != null)
			{
				_onClick(this) ;
			}
		}
		
		public function get selected():Boolean
		{
			return _selected ;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value ;
			_selectedTag.visible = _selected ;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			updateView();
		}
		
		private function updateView():void
		{
			if (data != null)
			{
				_tank.gotoAndStop((data as TankConfigInfo).id) ;
				_tank.visible = true ;
			}
			else
			{
				_tank.visible = false ;
			}
		}
	}
}