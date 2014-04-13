package x.game.module
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import x.game.core.IDisposeable;
	import x.game.manager.StageManager;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	import x.game.util.DisplayObjectUtil;
	
	/**
	 * 模块基础类
	 * @author fraser
	 *
	 */
	public class AbstractModule extends DraggableSprite implements IDisposeable
	{
		/** 模块的生命周期 */
		protected var _lifecycleType:String = LifecycleType.NONCE;
		/** 模块UI资源    */
		protected var _mainUI:MovieClip;
		/** 模块的关闭按钮  */
		protected var _closeBtn:XSimpleButton;
		/** 拖动条  */
		protected var _dragSprite:DisplayObject;
		/** 是否覆盖背景  */
		protected var _cover:Boolean = true;
		/** 初始化数据 */
		protected var _initData:IModuleInitData;
		
		protected var _moduleProxy:ModuleProxy;
		
		public function AbstractModule()
		{
			
		}
		
		public function get moduleWidth():Number
		{
			if(_mainUI)
			{
				return _mainUI.width;
			}
			else
			{
				throw new Error("module skin has not init!");
			}
		}
		
		public function get moduleHeight():Number
		{
			if(_mainUI)
			{
				return _mainUI.height;
			}
			else
			{
				throw new Error("module skin has not init!");
			}
		}
		
		protected function setMainUI(ui:MovieClip):void
		{
			_mainUI = ui;
			addChild(_mainUI);
			//
			if (_mainUI.hasOwnProperty("closeBtn"))
			{
				if(_closeBtn != null)
				{
					DisplayObjectUtil.removeFromParent(_closeBtn.skin) ;
					_closeBtn.dispose() ;
					_closeBtn = null ;
				}
				_closeBtn = new XSimpleButton(_mainUI["closeBtn"]);
			}
			else if (_mainUI.hasOwnProperty("close_btn"))
			{
				if(_closeBtn != null)
				{
					DisplayObjectUtil.removeFromParent(_closeBtn.skin) ;
					_closeBtn.dispose() ;
					_closeBtn = null ;
				}
				_closeBtn = new XSimpleButton(_mainUI["close_btn"]);
			}
            //
			
			if (_mainUI.hasOwnProperty("dragMC"))
			{
				_dragSprite = _mainUI["dragMC"] as Sprite;
				if (_dragSprite as Sprite)
				{
					Sprite(_dragSprite).buttonMode = true;
				}
				_dragSprite.alpha = 0;
			}
			initEventListener();
		}
		
		private function initEventListener():void
		{
			if (_dragSprite != null)
			{
				_dragSprite.addEventListener(MouseEvent.MOUSE_DOWN, onDragStart);
			}
			
			if (_closeBtn != null)
			{
				_closeBtn.addClick(onClose);
				addChild(_closeBtn.skin);
			}
		}
		
		/**
		 * 设置模块皮肤
		 */
		public function setup():void
		{
			// override by child
		}
		
		/**
		 * 初始化模块数据
		 * @param data
		 *
		 */
		public function init(data:IModuleInitData):void
		{
			_initData = data;
		}
		
		/**
		 * 显示模块
		 */
		public function show():void
		{
			
		}
		
		public function hide():void
		{
			
		}
		
		override public function dispose():void
		{
			hide();
			// 
			if (_closeBtn != null)
			{
				DisplayObjectUtil.removeFromParent(_closeBtn.skin) ;
				_closeBtn.dispose() ;
			}
			_closeBtn = null;
			if (_dragSprite != null)
			{
				_dragSprite.removeEventListener(MouseEvent.MOUSE_DOWN, onDragStart);
			}
			_dragSprite = null;
			DisplayObjectUtil.removeAllChildren(_mainUI);
			_mainUI = null;
			_initData = null;
			
			_moduleProxy = null;
			
			super.dispose();
		}
		
		public function get lifecycleType():String
		{
			return _lifecycleType;
		}
		
		public function get cover():Boolean
		{
			return _cover;
		}
		
		/* 回收关闭模块 */
		protected function onClose(button:IButton):void
		{
			close();
		}
		
		public function close():void
		{
			ModuleManager.closeForInstance(this);
		}
		
		private function onDragStart(event:MouseEvent):void
		{
			drag(false, StageManager.stageRect);
		}
		
		/** 模块代理 */
		public function get moduleProxy():ModuleProxy
		{
			return _moduleProxy;
		}
		
		/**
		 * @private
		 */
		public function set moduleProxy(value:ModuleProxy):void
		{
			_moduleProxy = value;
		}
	}
}
