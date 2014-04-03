package x.game.module
{
	import flash.events.EventDispatcher;
	
	import x.game.core.IDisposeable;
	import x.game.loader.core.ContentInfo;
	import x.game.loader.core.LoadType;
	import x.game.loader.UILoader;
	import x.game.manager.StageManager;
	import x.game.util.StringUtil;

	/**
	 * 外部模块代理
	 * @author fraser
	 *
	 */
	public class ModuleProxy extends EventDispatcher implements IDisposeable
	{
		public static const HIDE:String = "hide";
		public static const SHOW:String = "show";
		public static const LOADING:String = "loading" ;
		public static const CLOSE:String = "close";
		
		/**  当前模块状态   */
		private var _state:String;
		private var _name:String;
		private var _url:String;
		private var _title:String;
		private var _data:IModuleInitData;
		private var _module:Module ;
		/** 标示是否已经被销毁 */
		private var _isDisposed:Boolean = false ;

		public function ModuleProxy(url:String, title:String)
		{
			super(this);
			_url = url;
			_title = title;
			_state = HIDE;
			_name = StringUtil.getFileName(_url);
		}
        
        public function get disposed():Boolean 
        {
            return _isDisposed ;
        }
		
		public function dispose():void
		{
			ModuleManager.removeModuleByName(_name);
			//
			if(_state == LOADING)
			{
				UILoader.cancel(_url, onLoadComplete);
			}
			
			if (_module != null)
			{
				_module.dispose();
				_module = null ;
			}
			_data = null;
            _isDisposed = true ;
			ModuleManager.dispatchEvent(_name, ModuleEvent.DISPOSE);
			// 激活场景
//			SceneManager.activeScene();
		}

		public function init(data:IModuleInitData = null):void
		{
			_data = data;
			//
			if (_module != null)
			{
				show() ;
			}
			else
			{
				loadModule();
			}
		}

		public function hide():void
		{
			if (_module != null)
			{
				_state = HIDE;
				ModuleManager.dispatchEvent(_name, ModuleEvent.HIDE);
				if (_module.parent)
				{
					_module.hide();
					//
				}
			}
			else if(state == LOADING)
			{
				UILoader.cancel(_url, onLoadComplete);
				_state = HIDE;
				//
				ModuleManager.dispatchEvent(_name, ModuleEvent.HIDE);
			}
			_data = null;
			// 激活场景
//			SceneManager.activeScene();
		}

		//--------------------------------------------------------------
		// private
		//--------------------------------------------------------------
		
		private function show():void
		{
			_module.init(_data);
			ModuleManager.dispatchEvent(_name, ModuleEvent.INIT);	
			//
			if (_module.parent == null)
			{
				_module.show();
			}
			_state = SHOW;
			ModuleManager.dispatchEvent(_name, ModuleEvent.SHOW);
			// 锁住场景
//			SceneManager.lockScene();
			//
            _module.updatePosition(StageManager.fixWidth,StageManager.fixHeight) ;
		}
		
		private function loadModule():void
		{
			if(_state == LOADING)
			{
				return ;
			}
			_state = LOADING ;			 
			// 加载模块资源
			UILoader.load(_url, LoadType.MODULE, onLoadComplete, onLoadError,_title);
		}
		
		private function onLoadError(info:ContentInfo):void
		{
			throw new Error("错误的模块加载地址[" + info.url + "]!") ;
			dispose();
		}
		
		private function onLoadComplete(info:ContentInfo):void
		{
			if(disposed == false)
			{
				_module = info.content as Module;
				_module.moduleProxy = this;
				_module.setup();				
				//
				ModuleManager.dispatchEvent(_name, ModuleEvent.SET_UP);
				//
				init(_data) ;
			}
		}
		
		/**
		 * 模块生命周期
		 * @return
		 *
		 */
		public function get lifecycleType():String
		{
			if (_module)
			{
				return _module.lifecycleType;
			}
			return LifecycleType.NONCE;
		}
		
		public function get module():AbstractModule
		{
			return _module;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get state():String
		{
			return _state;
		}
	}
}
