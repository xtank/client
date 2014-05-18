package views
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import events.BarrierEvent;
	
	import x.game.manager.UIManager;
	import x.game.ui.XComponent;
	import x.game.ui.flipbar.FlipBarInitData;
	import x.game.ui.flipbar.IFilpBarHost;
	import x.game.ui.flipbar.XFlipBar;
	import x.game.util.DisplayObjectUtil;
	
	public class BarrierView extends XComponent implements IFilpBarHost
	{
		
		private var _ccc:MovieClip;
		private var _flipBar:XFlipBar;
		private var _barriers:Array;
		
		public function BarrierView(skin:DisplayObject)
		{
			super(skin);
			_ccc = _skin["ccc"];
			//
			_barriers = [];
			var index:uint = 1;
			while (UIManager.getBitmapData("Barrier_" + index) != null)
			{
				_barriers.push(new BarrierInfo(index));
				index++;
			}
			//
			_flipBar = new XFlipBar(new FlipBarInitData(2, this), _skin["flipBar"]);
			_flipBar.dataProvide = _barriers;
		}
		
		private var _selectedIndex:uint ;
		private var _sprites:Vector.<Sprite> = new Vector.<Sprite>();
		private var _infoDatas:Array;
		
		public function updatePageData(data:Array):void
		{
			DisplayObjectUtil.removeAllChildren(_ccc);
			while (_sprites.length > 0)
			{
				_sprites.pop().removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown) ;
			}
			//
			_infoDatas = data;
			//
			var startx:Number = 0;
			//
			var len:uint = data.length;
			var info:BarrierInfo;
			var spr:Sprite;
			for (var i:uint = 0; i < len; i++)
			{
				info = (data[i] as BarrierInfo);
				spr = new Sprite();
				spr.useHandCursor = true;
				spr.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown) ;
				spr.addChild(new Bitmap(info.res));
				spr.x = startx;
				_ccc.addChild(spr);
				_sprites.push(spr);
				//
				startx += (spr.width + 20);
			}
			//
		}
		
		private var _dragSpr:DragBarrier ;
		
		private function onMouseDown(event:MouseEvent):void
		{
			var spr:Sprite = event.currentTarget as Sprite ;
			_selectedIndex = _sprites.indexOf(spr) ;
			//
			_dragSpr = new DragBarrier(_infoDatas[_selectedIndex] as BarrierInfo);
			_dragSpr.addEventListener(MouseEvent.MOUSE_UP,onMouseUp) ;
			_dragSpr.addChild(new Bitmap(_dragSpr.info.res));
			_dragSpr.startDrag() ;
			_dragSpr.x = event.stageX + _dragSpr.info.reg.x ;
			_dragSpr.y = event.stageY + _dragSpr.info.reg.y ;
			_skin.stage.addChild(_dragSpr) ;
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_dragSpr.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp) ;
			//
			_dragSpr.stopDrag() ;
			DisplayObjectUtil.removeFromParent(_dragSpr) ;
			//
			var e:BarrierEvent = new BarrierEvent(BarrierEvent.UU) ;
			e.info = _dragSpr.info ;
			e.stagePoint = new Point(_dragSpr.x,_dragSpr.y) ;
			dispatchEvent(e) ;
		}
	}
}