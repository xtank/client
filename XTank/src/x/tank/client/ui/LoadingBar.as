package x.tank.client.ui
{
    import com.taomee.plugins.pandaVersionManager.PandaVersionManager;
    import com.taomee.xseer.ui.LoginLoadingBarUI2;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.utils.clearInterval;
    import flash.utils.setInterval;

    /**
     * @author fraser
     * 创建时间：2013-5-7下午4:49:25
     * 类说明：加载进度条包装类
     */
    public class LoadingBar
    {
        private static const TITLES:Array = 
		["","",""];

        //
        private var _container:Sprite;
        private var _title:TextField;
		private var _tiptitle:TextField;
        private var _coverUI:Sprite;
		//
        private var _childBar:LoadingProgressBar;
        private var _totalBar:LoadingProgressBar;
        //
        private var _totalCount:uint;
        //
        private var _titleShowFlag:Boolean = false;
        private var _index:int;
		// ##########################################################
		// 						bg
		// ##########################################################
		private var _bgLoader:Loader ;
		
		public function LoadingBar():void
		{
			_container = new LoginLoadingBarUI2() ;
			//
			_title = _container['title'];
			_tiptitle = _container['tiptitle'];
			_coverUI = _container["cover"];
			//
			_container.mouseChildren = false;
			_container.mouseEnabled = false;
			//
			_childBar = new LoadingProgressBar(_container['childBar']);
			_totalBar = new LoadingProgressBar(_container['totalBar']);
		}
		
		/** 加载背景 */
        public function loadBg(rootURL:String):void
        {
			var url:String = PandaVersionManager.getVerURLByNameSpace(rootURL + "assets/loadingbg/1.swf") ;
			_bgLoader = new Loader() ;
			_bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onbgComplete);
			_bgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_bgLoader.load(new URLRequest(url));
        }
		
		public function updatePosition(w:Number,h:Number):void
		{
			_container.x = w - 960 >> 1;
		}

		private function onbgComplete(event:Event):void
		{
			if(_container != null)
			{
				_container.addChildAt(_bgLoader.content,0) ;
			}
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			// do nothing
			//trace(e.text) ;
		}
		
        public function dispose():void
        {
            hide();
            if (_container != null)
            {
                while (_container.numChildren > 0)
                {
                    _container.removeChildAt(0);
                }
            }
            _childBar.dispose();
            _childBar = null;
            _totalBar.dispose();
            _totalBar = null;
            _container = null;
            _title = null;
            _coverUI = null;
			_tiptitle = null ;
			_bgLoader.unloadAndStop() ;
			_bgLoader = null ;
        }
		
		public function show(parent:DisplayObjectContainer, isCover:Boolean = false, coverWidth:Number =
							 NaN, coverHeight:Number = NaN):void
		{
			parent.addChild(_container);
			//
			if (isCover)
			{
				if (_container.contains(_coverUI) == false)
				{
					if (!isNaN(coverWidth))
					{
						_coverUI.width = coverWidth;
					}
					if (!isNaN(coverHeight))
					{
						_coverUI.height = coverHeight;
					}
					_container.addChildAt(_coverUI, 0);
				}
			}
			else
			{
				if (_coverUI.parent != null)
				{
					_coverUI.parent.removeChild(_coverUI);
				}
			}
			//
			if (isNaN(coverWidth))
			{
				coverWidth = _container.stage.stageWidth;
			}
			if (isNaN(coverHeight))
			{
				coverHeight = _container.stage.stageHeight;
			}
		}
		
		public function hide():void
		{
			if (_container.parent)
			{
				_container.parent.removeChild(_container);
			}
			//
			if (_container != null)
			{
				for (var i:uint = 0; i < _container.numChildren; i++)
				{
					if (_container.getChildAt(i) is MovieClip)
					{
						(_container.getChildAt(i) as MovieClip).gotoAndStop(1);
					}
				}
			}
			//
			endTitleShow();
		}
		
		private var _totalPercent:uint ;
		
		public function set progressTotal(percent:int):void
		{
			_totalPercent = percent ;
			_totalBar.updateTitle("总进度：" + percent + "/" + _totalCount);
			_totalBar.progress(percent * 100 / _totalCount);
		}
		
		public function get progressTotal():int
		{
			return _totalPercent ;
		}
		
		public function get totalCount():uint
		{
			return _totalCount ;
		}

        public function set totalCount(totalCount:uint):void
        {
            _totalCount = totalCount;
            //
			_totalBar.updateTitle("");
			_totalBar.resetBar() ;
			progressTotal = 0 ;
			//
			_childBar.updateTitle("");
			_childBar.resetBar() ;
            //
            startTitleShow();
        }
		
		public function set loadingTip(value:String):void
		{
			_tiptitle.text = value ;
		}

        public function set progressChild(percent:int):void
        {
            _childBar.updateTitle("加载：" + percent + "%");
            _childBar.progress(percent,true);
        }

        /////////////////////////////////////////////////////////////////////////////////////////


        private function startTitleShow():void
        {
            if (_titleShowFlag == false)
            {
                _titleShowFlag = true;
                _index = setInterval(randomTitle, 3000);
                randomTitle();
            }
        }

        private function randomTitle():void
        {
            _title.text = TITLES[random(0, TITLES.length - 1)];
        }

        private static function random(nMinimum:Number, nMaximum:Number = 0, nRoundToInterval:Number = 1):Number
        {
            if (nMinimum > nMaximum)
            {
                var nTemp:Number = nMinimum;
                nMinimum = nMaximum;
                nMaximum = nTemp;
            }
            var nDeltaRange:Number = (nMaximum - nMinimum) + (1 * nRoundToInterval);
            var nRandomNumber:Number = Math.random() * nDeltaRange;
            nRandomNumber += nMinimum;
            return floor(nRandomNumber, nRoundToInterval);
        }

        private static function floor(nNumber:Number, nRoundToInterval:Number = 1):Number
        {
            return Math.floor(nNumber / nRoundToInterval) * nRoundToInterval;
        }

        private function endTitleShow():void
        {
            if (_titleShowFlag == true)
            {
                clearInterval(_index);
                _index = 0;
                _titleShowFlag = false;
            }
        }

    }
}
