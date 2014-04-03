package x.tank.login
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    
    import x.game.log.core.Logger;
    import x.game.net.Connection;

    /**
     * 登陆服务代理
     * @author fraser
     *
     */
    public class LoginServerAgent
    {
        private static var _connectSuccess:Function;
        private static var _socketTimeOutIndex:int; //server 连接超时

        /** 连接登陆服务器 */
        public static function connectServer(userId:int,ip:String, port:uint, connectSuccess:Function):void
        {
			// Logger.info("连接服务器:" + ip + ":" + port,null,true) ;
            _connectSuccess = connectSuccess;
            // ---------------------------------------------------------------------
			Connection.setConnectInfo(userId) ;
            // ---------------------------------------------------------------------
            if (Connection.isConnecting())
            {
                if (_connectSuccess != null)
                {
                    _connectSuccess();
                    _connectSuccess = null;
                }
            }
            else
            {
                Connection.addEventListener(Event.CONNECT, onSocketConnect);
                Connection.addEventListener(IOErrorEvent.IO_ERROR, onSocketError);
                Connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSocketSecurityError);
                //
                try
                {
                    _socketTimeOutIndex = setTimeout(onSocketTimeOut, 30000);
                    //			
					Logger.info("##########################################");
					Logger.info("登陆服务器信息[" + ip + ":" + port + "]");
					Logger.info("##########################################");
                    //
                    Connection.connect(ip, port);
                }
                catch (e:SecurityError)
                {
                    onSocketSecurityError(null);
                }
            }
        }

        private static function onSocketConnect(event:Event):void
        {
			Logger.info("[Xtank Server Connected!!]");
            removeSocketEvent();

            if (_connectSuccess != null)
            {
                _connectSuccess();
                _connectSuccess = null;
            }
        }

        private static function onSocketTimeOut():void
        {
            onSocketError(null);
        }

        private static function onSocketSecurityError(event:SecurityErrorEvent):void
        {
            onSocketError(null);
        }

        private static function onSocketError(event:IOErrorEvent):void
        {
            removeSocketEvent();
            //
            var errMsg:String = "";
            if (event)
            {
                errMsg += event.toString();
            }
            else
            {
                errMsg += "连接Online超时！";
            }
            //AlertUtil.alert("\n" + errMsg);
        }

        private static function removeSocketEvent():void
        {
            Connection.removeEventListener(Event.CONNECT, onSocketConnect);
            Connection.removeEventListener(IOErrorEvent.IO_ERROR, onSocketError);
            Connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSocketSecurityError);
            //
            clearTimeout(_socketTimeOutIndex);
        }
    }
}
