package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import x.game.manager.UIManager;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XButton;
	import x.game.ui.flipbar.FlipBarInitData;
	import x.game.ui.flipbar.IFilpBarHost;
	import x.game.ui.flipbar.XFlipBar;
	import x.game.util.DisplayObjectUtil;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.handler.BarrierDataHandler;

	// 障碍物信息编辑器
	[SWF(width = "960", height = "560", frameRate = 30, backgroundColor = 0xFFFFFF)]
	public class XTankBarrierEditor extends Sprite implements IFilpBarHost
	{
		private var _uiLoader:Loader;
		private var _urlLoader:URLLoader;

		public function XTankBarrierEditor()
		{
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, loadBARComplete);
			_urlLoader.load(new URLRequest("../../../../proto/cfg/barriers.xml"));
		}

		private function loadBARComplete(event:Event):void
		{
			_urlLoader.removeEventListener(Event.COMPLETE, loadBARComplete);
			//
			var handler:BarrierDataHandler = new BarrierDataHandler();
			handler.parser(XML(_urlLoader.data));
			DataProxyManager.addHandler2(handler);
			//
			loadUI();
		}

		private function loadUI():void
		{
			_uiLoader = new Loader();
			_uiLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onUIComplete);
			//
			var req:URLRequest = new URLRequest("../../../../client/XTankPublish/dlls/XTankUI.swf");
			_uiLoader.load(req);
		}

		private var _barriers:Array;

		private function onUIComplete(event:Event):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onUIComplete);
			UIManager.setup(_uiLoader.contentLoaderInfo.applicationDomain);
			// <barrier id="1" reg="16,16" type="1" hp="" cls="Barrier_1" occpy=""/>
			_barriers = [];
			//
			var index:uint = 1;
			while (UIManager.getBitmapData("Barrier_" + index) != null)
			{
				_barriers.push(new BarrierInfo(index,"Barrier_","barrier"));
				index++;
			}
			//
			index = 1 ;
			while (UIManager.getBitmapData("Home_" + index) != null)
			{
				_barriers.push(new BarrierInfo(index,"Home_","home"));
				index++;
			}
			//
			initUI();
		}

		private var _skin:MovieClip;
		private var _pBox:MovieClip;
		private var _bBox:MovieClip;
		private var _saveBtn:XButton;
		private var _ccc:MovieClip;
		private var _pathBox:MovieClip;
		private var _pathBtn:XButton;
		private var _flipBar:XFlipBar;

		private function initUI():void
		{
			_currentSprite = new Sprite();
			_currentSprite.scaleX = _currentSprite.scaleY = 2;
			_currentSprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			//
			_skin = new XTankBarrierEditorUI();
			addChild(_skin);
			//
			_ccc = _skin["ccc"];
			//
			_pathBox = _skin["pathBox"];
			DisplayObjectUtil.disableTarget(_pathBox);
			//
			_bBox = _skin["bBox"];
			//
			_pBox = _skin["pBox"];
			DisplayObjectUtil.disableTarget(_pBox);
			//
			drawCoordinate();
			//
			_saveBtn = new XButton(_skin["saveBtn"]);
			_saveBtn.addClick(onSave);
			//
			_pathBtn = new XButton(_skin["pathBtn"]);
			//
			DisplayObjectUtil.disableTarget(_pathBox);
			_pathBtn.toggle = true;
			_pathBtn.addClick(function(btn:IButton):void
			{
				_skin.swapChildren(_pathBox, _bBox);
				if (_pathBox.mouseEnabled)
				{
					DisplayObjectUtil.disableTarget(_pathBox);
					DisplayObjectUtil.enableTarget(_bBox);
				}
				else
				{
					DisplayObjectUtil.enableTarget(_pathBox);
					DisplayObjectUtil.disableTarget(_bBox);
				}
			});
			//
			_flipBar = new XFlipBar(new FlipBarInitData(2, this), _skin["flipBar"]);
			_flipBar.dataProvide = _barriers;
		}

		private var _coordinates:Vector.<Grid>;

		private function drawCoordinate():void
		{
			_coordinates = new Vector.<Grid>();
			for (var i:int = -10; i < 10; i++)
			{
				for (var j:int = -10; j < 10; j++)
				{
					_coordinates.push(new Grid(i, j, onGridClick));
				}
			}

			//
			for each (var grid:Grid in _coordinates)
			{
				_pathBox.addChild(grid.gridSkin);
			}
		}

		private function updateGridInfo():void
		{
			for each (var grid:Grid in _coordinates)
			{
				grid.occpy = false;
			}
			//
			var occpys:Vector.<Point> = _currentBarrier.occpys;
			for each (var p:Point in occpys)
			{
				var len:uint = _coordinates.length;
				for (var i:uint = 0; i < len; i++)
				{
					if (_coordinates[i].mapx == p.x && _coordinates[i].mapy == p.y)
					{
						_coordinates[i].occpy = true;
						break;
					}
				}

			}

		}

		private function onGridClick(mapx:int, mapy:int):void
		{
			if (_currentBarrier != null)
			{
				_currentBarrier.addOccpy(mapx, mapy);
			}
		}

		private var _currentBarrier:BarrierInfo;
		private var _currentSprite:Sprite;

		public function setBarrier(barrier:BarrierInfo):void
		{
			DisplayObjectUtil.removeAllChildren(_currentSprite);
			_currentBarrier = barrier;
			//
			_currentSprite.x = _currentBarrier.reg.x * 2;
			_currentSprite.y = _currentBarrier.reg.y * 2;
			_currentSprite.addChild(new Bitmap(_currentBarrier.res));
			_bBox.addChild(_currentSprite);
			//
			updateGridInfo();
		}

		private function onMouseDown(event:MouseEvent):void
		{
			_currentSprite.addEventListener(MouseEvent.MOUSE_UP, onMouseUP);
			_currentSprite.startDrag();
		}

		private function onMouseUP(event:MouseEvent):void
		{
			_currentSprite.stopDrag();
			_currentBarrier.reg = new Point(_currentSprite.x / 2, _currentSprite.y / 2);
		}

		private var _sprites:Vector.<Sprite> = new Vector.<Sprite>();
		private var _infoDatas:Array;

		public function updatePageData(data:Array):void
		{
			DisplayObjectUtil.removeAllChildren(_ccc);
			while (_sprites.length > 0)
			{
				_sprites.pop().removeEventListener(MouseEvent.CLICK, onClick);
			}
			//
			_infoDatas = data;
			//
			var starty:Number = 0;
			//
			var len:uint = data.length;
			var info:BarrierInfo;
			var spr:Sprite;
			for (var i:uint = 0; i < len; i++)
			{
				info = (data[i] as BarrierInfo);
				spr = new Sprite();
				spr.useHandCursor = true;
				spr.addEventListener(MouseEvent.CLICK, onClick);
				spr.addChild(new Bitmap(info.res));
				spr.y = starty;
				_ccc.addChild(spr);
				_sprites.push(spr);
				//
				starty += spr.height;
			}
			if (_infoDatas.length > 0)
			{
				setBarrier(_infoDatas[0]);
			}
		}

		private function onClick(event:MouseEvent):void
		{
			setBarrier(_infoDatas[_sprites.indexOf(event.target)]);
		}
		
		private function parserContent():String
		{
			var content:String = "<!-- id\ntype  0 不可击穿  1 可击穿\nhp 如果不可击穿 该值为无限大  如果可击穿则为血量\ncls  资源名\noccpy  x1,y1;x2,y2 [占据的不可通过的点集合] -->\n<barriers>" ;
			var len:uint = _barriers.length ;
				for(var i:uint = 0;i<len;i++)
				{
					content += ("\n" + (_barriers[i] as BarrierInfo).description()) ;
				}
						
			return content+"\n</barriers>" ;
		}

		//
		private var fileRef:FileReference ;
		
		private function onSave(btn:IButton):void
		{
			fileRef = new FileReference();
			fileRef.addEventListener(Event.SELECT, onSaveFileSelected);
			fileRef.save(parserContent(),"barriers.xml");
		}
		
		private function onSaveFileSelected(evt:Event):void
		{
			fileRef.addEventListener(ProgressEvent.PROGRESS, onSaveProgress);
			fileRef.addEventListener(Event.COMPLETE, onSaveComplete);
			fileRef.addEventListener(Event.CANCEL, onSaveCancel);
		}
		
		private function onSaveProgress(evt:ProgressEvent):void
		{
			trace("Saved " + evt.bytesLoaded + " of " + evt.bytesTotal + " bytes.");
		}
		
		private function onSaveComplete(evt:Event):void
		{
			//保存动作结束后，删除相关侦听，以减轻服务器的负荷
			trace("File saved.");
			fileRef.removeEventListener(Event.SELECT, onSaveFileSelected);
			fileRef.removeEventListener(ProgressEvent.PROGRESS, onSaveProgress);
			fileRef.removeEventListener(Event.COMPLETE, onSaveComplete);
			fileRef.removeEventListener(Event.CANCEL, onSaveCancel);
		}
		//以下为信息提示
		private function onSaveCancel(evt:Event):void
		{
			trace("The save request was canceled by the user.");
		}
		
		private function onIOError(evt:IOErrorEvent):void
		{
			trace("There was an IO Error.");
		}
		
		private function onSecurityError(evt:Event):void
		{
			trace("There was a security error.");
		}
	}
}
