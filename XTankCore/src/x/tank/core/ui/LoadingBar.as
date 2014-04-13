package x.tank.core.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import x.game.manager.UIManager;

	/**
	 * 加载进度条
	 * @author fraser
	 *
	 */
	internal class LoadingBar
	{
		private var _container:Sprite;
		private var _bar:MovieClip;
		private var _numberVec:Vector.<MovieClip>;
		private var _title:TextField;
		private var _coverUI:Sprite;
		//
		public function LoadingBar()
		{
			var uiCls:Class = UIManager.getClass("GameLoadingBar_UI")  ;
			_container = new uiCls() ;
			//
			var progressNum:MovieClip = _container['bar']["num"];
			_numberVec = new Vector.<MovieClip>();
			_numberVec.push(progressNum["unit"]);
			_numberVec[0].gotoAndStop(1);
			_numberVec.push(progressNum["ten"]);
			_numberVec[1].gotoAndStop(1);
			_numberVec.push(progressNum["hundred"]);
			_numberVec[2].gotoAndStop(1);
			//
			_bar = _container['bar']['bar'];
			_bar.gotoAndStop(1);
			//
			_title = _container['bar']['title'];
			_coverUI = _container["cover"];
			//
			_container.mouseChildren = false ;
			_container.mouseEnabled = false ;
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
			_container = null;
			_numberVec = null;
			_title = null;
			_coverUI = null;
			_bar = null;
		}

		public function set title(t:String):void
		{
			_title.text = t ? t : "";
		}

		public function show(parent:DisplayObjectContainer, isCover:Boolean = false, coverWidth:Number = NaN, coverHeight:Number = NaN):void
		{
			progress(0);
			//
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
			if (isNaN(coverWidth))
			{
				coverWidth = _container.stage.stageWidth;
			}
			if (isNaN(coverHeight))
			{
				coverHeight = _container.stage.stageHeight;
			}
			// 居中显示
			_container['bar'].x = coverWidth >> 1
		}

		public function hide():void
		{
			_bar.gotoAndStop(1);
			if (_container.parent)
			{
				_container.parent.removeChild(_container);
			}
			if(_container!=null)
			{
				for(var i:uint = 0;i<_container.numChildren;i++)
				{
					if(_container.getChildAt(i) is MovieClip)
					{
						(_container.getChildAt(i) as MovieClip).gotoAndStop(1);
					}				
				}			
			}			
			title = "" ;
		}

		public function progress(percent:int):void
		{
			updateNum(percent);
			//
			var frameIndex:uint = uint(_bar.totalFrames * percent / 100);
			_bar.gotoAndStop(frameIndex);
		}

		private function updateNum(percent:int):void
		{
			var digitStringArr:Array = percent.toString().split("");
			var digitVec:Vector.<int> = Vector.<int>(digitStringArr).reverse();
			var length:int = digitVec.length;
			for (var i:int = 0; i < 3; i++)
			{
				if (i <= (length - 1))
				{
					_numberVec[i].visible = true;
					_numberVec[i].gotoAndStop(digitVec[i] + 1);
				}
				else
				{
					_numberVec[i].visible = false;
				}
			}
		}
	}
}
