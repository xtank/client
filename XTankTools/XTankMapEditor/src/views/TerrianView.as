package views
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import events.TerrianEvent;
	
	import x.game.manager.UIManager;
	import x.game.ui.XComponent;
	import x.game.ui.flipbar.FlipBarInitData;
	import x.game.ui.flipbar.IFilpBarHost;
	import x.game.ui.flipbar.XFlipBar;
	import x.game.util.DisplayObjectUtil;
	
	public class TerrianView extends XComponent implements IFilpBarHost
	{
		private var _ccc:MovieClip;
		private var _flipBar:XFlipBar;
		private var _terriers:Array;
		
		public function TerrianView(skin:DisplayObject)
		{
			super(skin);
			_ccc = _skin["ccc"];
			//
			_terriers = [];
			var index:uint = 1;
			while (UIManager.getBitmapData("Tank_Bg_" + index) != null)
			{
				_terriers.push(new TerrianInfo(index));
				index++;
			}
			//
			_flipBar = new XFlipBar(new FlipBarInitData(2, this), _skin["flipBar"]);
			_flipBar.dataProvide = _terriers;
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
			var info:TerrianInfo;
			var spr:Sprite;
			for (var i:uint = 0; i < len; i++)
			{
				info = (data[i] as TerrianInfo);
				spr = new Sprite();
				spr.useHandCursor = true;
				spr.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown) ;
				spr.addChild(new Bitmap(UIManager.getBitmapData("Tank_Bg_" + info.id)));
				spr.x = startx;
				_ccc.addChild(spr);
				_sprites.push(spr);
				//
				startx += (spr.width + 20);
			}
			//
		}
		
		private var _dragSpr:DragTerrian ;
		
		private function onMouseDown(event:MouseEvent):void
		{
			var spr:Sprite = event.currentTarget as Sprite ;
			_selectedIndex = _sprites.indexOf(spr) ;
			//
			_dragSpr = new DragTerrian(_infoDatas[_selectedIndex] as TerrianInfo);
			_dragSpr.addEventListener(MouseEvent.MOUSE_UP,onMouseUp) ;
			_dragSpr.addChild(new Bitmap(_dragSpr.res));
			_dragSpr.startDrag() ;
			_dragSpr.x = event.stageX - _dragSpr.res.width/2  ;
			_dragSpr.y = event.stageY - _dragSpr.res.height/2 ;
			_skin.stage.addChild(_dragSpr) ;
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_dragSpr.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp) ;
			//
			_dragSpr.stopDrag() ;
			DisplayObjectUtil.removeFromParent(_dragSpr) ;
			//
			var e:TerrianEvent = new TerrianEvent(TerrianEvent.UU) ;
			e.info = _dragSpr.info ;
			e.stagePoint = new Point(_dragSpr.x,_dragSpr.y) ;
			dispatchEvent(e) ;
		}
	}
}