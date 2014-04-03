package x.game.loader
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	/**
	 * air上的load有安全限制，用loadBytes转了下 
	 * @author tb
	 * 
	 */	
	public class AirLoader extends EventDispatcher
	{
		private var _context:LoaderContext;
		private var _byteLoader:URLLoader;
		private var _loader:Loader;
		private var _url:String;
		
		public function AirLoader()
		{
			_byteLoader = new URLLoader();
			_byteLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_byteLoader.addEventListener(Event.OPEN,onOpen);
			_byteLoader.addEventListener(Event.COMPLETE,onURLComplete);
			_byteLoader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			_byteLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			_byteLoader.addEventListener(ProgressEvent.PROGRESS,onProgress);
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		public function dispose():void
		{
			_byteLoader.removeEventListener(Event.OPEN,onOpen);
			_byteLoader.removeEventListener(Event.COMPLETE,onURLComplete);
			_byteLoader.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
			_byteLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			_byteLoader.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
			_loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			
			_context = null;
			_byteLoader = null;
			_loader = null;
		}
		
		public function get bytesTotal():uint
		{
			return _byteLoader.bytesTotal ;
		}
		public function get content():DisplayObject
		{
			return _loader.content;
		}
		
		public function load(request:URLRequest,context:LoaderContext = null):void
		{
			_context = context;
			_url = request.url;
			_byteLoader.load(request);
		}
		
		public function close():void
		{
			try
			{
				_byteLoader.close();
				_loader.close();
			}catch(e:Error){}
		}
		
		public function unload():void
		{
			_loader.unload();
		}
		public function unloadAndStop(gc:Boolean = true):void
		{
			_loader.unloadAndStop(gc);
		}
		private function onURLComplete(event:Event):void
		{
			if(_context == null)
			{
				_context = new LoaderContext();
			}
			if("allowCodeImport" in _context)
			{
				_context["allowCodeImport"] = true;
			}
			_loader.loadBytes(ByteArray(_byteLoader.data),_context);
		}
		private function onComplete(event:Event):void
		{
			trace(">>>>>>["+getString(_loader.contentLoaderInfo.url)+":"+getString(_url)+"]");
			dispatchEvent(event);
		}
		private function onIOError(event:IOErrorEvent):void
		{
			dispatchEvent(event);
		}
		private function onOpen(event:Event):void
		{
			dispatchEvent(event);
		}
		private function onProgress(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
		private function onSecurityError(event:SecurityErrorEvent):void
		{
			dispatchEvent(event);
		}
		
		private function getString(s:String):String
		{
			var index:int = s.lastIndexOf("/");
			if (index != -1)
			{
				s = s.substr(index+1);
			}
			return s;
		}
	}
}