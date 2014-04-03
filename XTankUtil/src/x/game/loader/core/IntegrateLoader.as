package x.game.loader.core
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	import x.game.loader.AirLoader;
	
	/**
	 * 集合加载器 
	 * @author tb
	 * 
	 */	
	internal class IntegrateLoader extends EventDispatcher
	{
		private var _info:QueueInfo;
		
		private var _urlLoader:URLLoader;
		private var _loader:Loader;
		private var _sound:Sound;
		private var _module:AirLoader;
		//
		private var _loaderStartTime:uint = 0 ;
		
		public function IntegrateLoader()
		{
			
		}
		
		public function dispose():void
		{
			close();
			if(_urlLoader)
			{
				_urlLoader.removeEventListener(Event.OPEN,onOpen);
				_urlLoader.removeEventListener(Event.COMPLETE,onComplete);
				_urlLoader.removeEventListener(ProgressEvent.PROGRESS,onProgress);
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
				_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			}
			if(_loader)
			{
				_loader.contentLoaderInfo.removeEventListener(Event.OPEN,onOpen);
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
				_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgress);
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onError);
			}
			if(_module)
			{
				_module.removeEventListener(Event.OPEN,onOpen);
				_module.removeEventListener(Event.COMPLETE,onComplete);
				_module.removeEventListener(ProgressEvent.PROGRESS,onProgress);
				_module.removeEventListener(IOErrorEvent.IO_ERROR,onError);
				_module.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
				_module.dispose();
			}
			_urlLoader = null;
			_loader = null;
			_sound = null;
			_module = null;
		}
		
		public function get info():QueueInfo
		{
			return _info;
		}
		
		public function load(info:QueueInfo):void
		{
			_info = info;
			switch(_info.type)
			{
				case LoadType.BINARY:
					trace(">>>>>>  加载 BINARY:[" + info.url + "]");
					getURLLoader().dataFormat = _info.type;
					getURLLoader().load(new URLRequest(_info.url));
					break;
				case LoadType.TEXT:
					trace(">>>>>>  加载 TEXT:[" + info.url + "]");
					getURLLoader().dataFormat = _info.type;
					getURLLoader().load(new URLRequest(_info.url));					
					break;
				case LoadType.DLL:
					trace(">>>>>>  加载 DLL:[" + info.url + "]");
					getLoader().load(new URLRequest(_info.url),new LoaderContext(false,ApplicationDomain.currentDomain));
					break;
				case LoadType.SWF:
					trace(">>>>>>  加载 SWF:[" + info.url + "]");
					getLoader().load(new URLRequest(_info.url));
					break;					
				case LoadType.DOMAIN:
					trace(">>>>>>  加载 DOMAIN:[" + info.url + "]");
					getLoader().load(new URLRequest(_info.url));
					break;					
				case LoadType.IMAGE:
					trace(">>>>>>  加载 IMAGE:[" + info.url + "]");
					getLoader().load(new URLRequest(_info.url));
					break;
				case LoadType.SOUND:
					trace(">>>>>/>  加载 SOUND:[" + info.url + "]");
					getSound().load(new URLRequest(_info.url));
					break;
				case LoadType.MODULE:
					trace(">>>>>>  加载 MODULE:[" + info.url + "]");
					getModule().load(new URLRequest(_info.url));
//					getLoader().load(new URLRequest(_info.url),new LoaderContext(false,ApplicationDomain.currentDomain));
					break;
				default :
					return ;
			}
		}
		
		public function close():void
		{
			if(_info)
			{
				switch(_info.type)
				{
					case LoadType.BINARY:
					case LoadType.TEXT:
						closeURLLoader();
						break;
					case LoadType.DLL:
					case LoadType.SWF:
					case LoadType.DOMAIN:
					case LoadType.IMAGE:
						closeLoader();
						break;
					case LoadType.SOUND:
						closeSound();
					case LoadType.MODULE:
//						closeLoader();
						closeModule();
						break;
				}
			}
			_info = null;
		}
		
		//--------------------------------------------------
		// get
		//--------------------------------------------------
		
		private function getURLLoader():URLLoader
		{
			if(_urlLoader == null)
			{
				_urlLoader = new URLLoader();
				_urlLoader.addEventListener(Event.OPEN,onOpen);
				_urlLoader.addEventListener(Event.COMPLETE,onComplete);
				_urlLoader.addEventListener(ProgressEvent.PROGRESS,onProgress);
				_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
				_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			}
			_loaderStartTime = getTimer() ;
			return _urlLoader;
		}
		private function getLoader():Loader
		{
			if(_loader == null)
			{
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.OPEN,onOpen);
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
			}
			_loaderStartTime = getTimer() ;
			return _loader;
		}
		private function getSound():Sound
		{
			closeSound();
			_sound = new Sound();
			_sound.addEventListener(Event.OPEN,onOpen);
			_sound.addEventListener(Event.COMPLETE,onComplete);
			_sound.addEventListener(ProgressEvent.PROGRESS,onProgress);
			_sound.addEventListener(IOErrorEvent.IO_ERROR,onError);
			// 
			_loaderStartTime = getTimer() ;
			return _sound;
		}
		private function getModule():AirLoader
		{
			if(_module == null)
			{
				_module = new AirLoader();
				_module.addEventListener(Event.OPEN,onOpen);
				_module.addEventListener(Event.COMPLETE,onComplete);
				_module.addEventListener(ProgressEvent.PROGRESS,onProgress);
				_module.addEventListener(IOErrorEvent.IO_ERROR,onError);
				_module.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			}
			_loaderStartTime = getTimer() ;
			return _module;
		}
		//--------------------------------------------------
		// close
		//--------------------------------------------------
		
		private function closeURLLoader():void
		{
			if(_urlLoader)
			{
				try
				{
					_urlLoader.close();
				}catch(e:Error){}
			}
		}
		private function closeLoader():void
		{
			if(_loader)
			{
				_loader.unload();
				try
				{
					_loader.close();
				}catch(e:Error){}
			}
		}
		private function closeSound():void
		{
			if(_sound)
			{
				_sound.removeEventListener(Event.OPEN,onOpen);
				_sound.removeEventListener(Event.COMPLETE,onComplete);
				_sound.removeEventListener(ProgressEvent.PROGRESS,onProgress);
				_sound.removeEventListener(IOErrorEvent.IO_ERROR,onError);
				try
				{
					_sound.close();
				}catch(e:Error){}
				_sound = null;
			}
		}
		private function closeModule():void
		{
			if(_module)
			{
				_module.unload();
				try
				{
					_module.close();
				}catch(e:Error){}
			}
//			_module = null;
		}
		//--------------------------------------------------
		// event
		//--------------------------------------------------
		
		private function onOpen(event:Event):void
		{
			dispatchEvent(event);
		}
		private function onComplete(event:Event):void
		{
			//
			switch(_info.type)
			{
				case LoadType.BINARY:
				case LoadType.TEXT:					
					dispatchEvent(new IntegrateLoaderEvent(IntegrateLoaderEvent.COMPLETE,_urlLoader.data));
					break;
				case LoadType.DLL:					
					dispatchEvent(new IntegrateLoaderEvent(IntegrateLoaderEvent.COMPLETE,null,_loader.contentLoaderInfo.applicationDomain));
					break;
				case LoadType.SWF:					
					dispatchEvent(new IntegrateLoaderEvent(IntegrateLoaderEvent.COMPLETE,_loader.content,_loader.contentLoaderInfo.applicationDomain));
					break;
				case LoadType.DOMAIN:
					dispatchEvent(new IntegrateLoaderEvent(IntegrateLoaderEvent.COMPLETE,_loader.contentLoaderInfo.applicationDomain,_loader.contentLoaderInfo.applicationDomain));
					break;
				case LoadType.IMAGE:
					dispatchEvent(new IntegrateLoaderEvent(IntegrateLoaderEvent.COMPLETE,Bitmap(_loader.content).bitmapData,_loader.contentLoaderInfo.applicationDomain));
					break;
				case LoadType.SOUND:
					dispatchEvent(new IntegrateLoaderEvent(IntegrateLoaderEvent.COMPLETE,_sound));
					break;
				case LoadType.MODULE:
//					dispatchEvent(new IntegrateLoaderEvent(IntegrateLoaderEvent.COMPLETE,_loader.content,_loader.contentLoaderInfo.applicationDomain));
					dispatchEvent(new IntegrateLoaderEvent(IntegrateLoaderEvent.COMPLETE,_module.content));
					break;
			}
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
		private function onError(event:ErrorEvent):void
		{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
		}
	}
}