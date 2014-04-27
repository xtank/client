package x.game.ui.list
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import x.game.ui.XComponent;


	/**
	 * XFlash - XList
	 *
	 * Created By fraser on 2014-2-15
	 * Copyright TAOMEE 2014.All rights reserved
	 *
	 * 列表
	 */
	public class XList extends XComponent
	{
		private var _items:Vector.<XListItem> = new Vector.<XListItem>();

		public function XList(skin:DisplayObject)
		{
			super(skin);
		}
		
		public function get listSkin():Sprite
		{
			return _skin as Sprite ;
		}

		public function addItem(item:XListItem):void
		{
			_items.push(item);
			//
			if (!_skin.hasEventListener(Event.ENTER_FRAME))
			{
				_skin.addEventListener(Event.ENTER_FRAME, onLayout);
			}
		}
		
		public function getSelectedItem(data:Object):XListItem
		{
			var rs:XListItem ;
			var len:uint = _items.length;
			for (var i:uint = 0; i < len; i++)
			{
				if(_items[i].data == data)
				{
					rs = _items[i];break;
				}
			}
			return rs ;
		}
		
		public function clear():void
		{
			var len:uint = _items.length;
			for (var i:uint = 0; i < len; i++)
			{
				_items[i].dispose();
			}
			_items.splice(0,_items.length) ;
		}

		private function onLayout(event:Event):void
		{
			_skin.removeEventListener(Event.ENTER_FRAME, onLayout);
			//
			var xPos:Number = 2 ;
			var yPos:Number = 0 ;
			var len:uint = _items.length;
			for (var i:uint = 0; i < len; i++)
			{
				_items[i].x = xPos ;
				_items[i].y = yPos ;
				//
				yPos += (_items[i].height + 2) ;
				listSkin.addChild(_items[i].skin) ;
			}
		}

		override public function dispose():void
		{
			var len:uint = _items.length;
			for (var i:uint = 0; i < len; i++)
			{
				_items[i].dispose();
			}
			_items = null;
			super.dispose();
		}
	}
}
