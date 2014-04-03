package x.tank.client
{
    import flash.errors.IOError;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.net.URLStream;
    import flash.utils.ByteArray;

    /**
     *
     * @author tb
     *
     */
    public class XMLLoader 
    {
        private var _xmlloader:URLStream;
        private var _isCompress:Boolean;
		private var _onComplete:Function ;
		private var _onProgress:Function ;

        public function XMLLoader()
        {
            _xmlloader = new URLStream();
            _xmlloader.addEventListener(Event.COMPLETE, onComplete);
            _xmlloader.addEventListener(Event.OPEN, onOpen);
            _xmlloader.addEventListener(ProgressEvent.PROGRESS, onProgress);
            _xmlloader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
            _xmlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        /**
         *
         * @param url
         * @param isCompress zlib
         *
         */
        public function load(url:String,onComplete:Function,onProgress:Function = null, isCompress:Boolean = false):void
        {
			_onComplete = onComplete ;
			_onProgress = onProgress ;
			_isCompress = isCompress;
            
            _xmlloader.load(new URLRequest(url));
        }

        public function close():void
        {
            if (_xmlloader.connected)
            {
                _xmlloader.close();
            }
        }

        public function destroy():void
        {
            close();
            _xmlloader.removeEventListener(Event.COMPLETE, onComplete);
            _xmlloader.removeEventListener(Event.OPEN, onOpen);
            _xmlloader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
            _xmlloader.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
            _xmlloader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
            _xmlloader = null;
        }

        private function onOpen(e:Event):void
        {
//            dispatchEvent(e);
        }

        private function onComplete(e:Event):void
        {
            var data:ByteArray = new ByteArray();
            _xmlloader.readBytes(data);
            if (_isCompress)
            {
                data.uncompress();
            }
			//
			_onComplete(XML(data.readUTFBytes(data.bytesAvailable))) ;
        }

        private function onProgress(e:ProgressEvent):void
        {
			if(_onProgress != null)
			{
				_onProgress(e.bytesLoaded,e.bytesTotal) ;
			}
        }

        private function onIoError(e:IOErrorEvent):void
        {
            throw new IOError(e.text);
        }

        private function onSecurityError(e:SecurityErrorEvent):void
        {
            throw new SecurityError(e.text);
        }
    }
}
