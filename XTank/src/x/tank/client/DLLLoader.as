package x.tank.client
{    
    import com.taomee.plugins.pandaVersionManager.PandaVersionManager;
    
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    import flash.net.URLStream;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.ByteArray;

    /**
     * Flash DLL加载
     * @author tb
     *
     */
    public class DLLLoader 
    {
        private var _dllList:Vector.<DllInfo>;
        private var _stream:URLStream;
        private var _loader:Loader;
		private var _onComplete:Function ;
		private var _onChildComplete:Function ;
		private var _onProgress:Function ;
		//
        private var _rootURL:String;
        private var _index:uint = 0;
        private var _len:uint = 0;

        public function DLLLoader()
        {
            _stream = new URLStream();
            _stream.addEventListener(Event.OPEN, onOpen);
            _stream.addEventListener(Event.COMPLETE, onComplete);
            _stream.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);

            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderOver);
        }
		
		public function dispose():void
		{
			_dllList = null ;
			_stream = null ;
			_loader = null ;
			_onComplete = null ;
			_onChildComplete = null ;
			_onProgress = null ;
		}

        public function doLoad(infos:Vector.<DllInfo>, rootURL:String, onComplete:Function,onChildComplete:Function,onProgress:Function = null):void
        {
            _dllList = infos;
			_onComplete = onComplete ;
			_onChildComplete = onChildComplete ;
			_onProgress = onProgress ;
            _rootURL = rootURL;
			//
            _len = _dllList.length;
            beginLoad();
        }

        /**  开始加载  */
        public function beginLoad():void
        {
            if (_dllList.length > 0)
            {
                var info:DllInfo = _dllList[0];
				trace("[Load DLL] >>>> " + info.path);
                _stream.load(new URLRequest(PandaVersionManager.getVerURLByNameSpace(_rootURL + info.path)));
                _index++;
            }
            else
            {
                _stream.removeEventListener(Event.OPEN, onOpen);
                _stream.removeEventListener(Event.COMPLETE, onComplete);
                _stream.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				//
                _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderOver);
                _loader = null;
                _stream = null;
				//
				_onComplete() ;
            }
        }

        private function onOpen(e:Event):void
        {
        }

        private function onProgressHandler(e:ProgressEvent):void
        {
			if(_onProgress != null)
			{
				var _singlePercent:Number = e.bytesLoaded / e.bytesTotal;
				_onProgress(_index - 1 + _singlePercent,_len) ;
			}
        }

        private function onComplete(e:Event):void
        {
            var byteArray:ByteArray = new ByteArray();
            _stream.readBytes(byteArray);
            _stream.close();
			trace("[size] >>>> " + byteArray.length);
			//
            _loader.loadBytes(byteArray, new LoaderContext(false, ApplicationDomain.currentDomain));
        }

        private function onLoaderOver(e:Event):void
        {
            _dllList.shift();
			if(_onChildComplete != null)
			{
				_onChildComplete() ;
			}
			//
            beginLoad();
        }
    }
}
