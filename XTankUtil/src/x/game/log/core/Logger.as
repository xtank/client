package x.game.log.core
{
    import flash.utils.getQualifiedClassName;
    
    import x.game.log.appender.ChromeAppender;

;

    /**
     * 日志打印系统类
     * @author fraser
     *
     * 加入时间戳
     *
     */
    public class Logger
    {
        public static var isDebug:Boolean ;
        public static var LOGGER_LEVEL:int = LogLevel.DEBUG;

//		private static var _appenders:Vector.<IAppender> = Vector.<IAppender>([new ArthropodAppender()]);
//		private static var _appenders:Vector.<IAppender> = Vector.<IAppender>([new MonsterAppender()]);
        private static var _appenders:Vector.<IAppender> = Vector.<IAppender>([new ChromeAppender()]);
//		private static var _appenders:Vector.<IAppender> = Vector.<IAppender>([new TraceAppender()]);

        public static function addAppender(appender:IAppender):void
        {
            _appenders.push(appender);
        }

        public static function debug(msg:String, target:Object = null,skipDebugFlag:Boolean = false):void
        {
            log(LogLevel.DEBUG, msg, target,skipDebugFlag);
        }

        public static function info(msg:String, target:Object = null,skipDebugFlag:Boolean = false):void
        {
            log(LogLevel.INFO, msg, target,skipDebugFlag);
        }

        public static function warn(msg:String, target:Object = null):void
        {
            log(LogLevel.WARN, msg, target);
        }

        public static function error(msg:String, target:Object = null):void
        {
            log(LogLevel.ERROR, msg, target);
        }

        public static function fatal(msg:String, target:Object = null):void
        {
            log(LogLevel.FATAL, msg, target);
        }

        private static function log(level:int, msg:String, target:Object ,skipDebugFlag:Boolean = false):void
        {
            if(skipDebugFlag == false)
            {
                if (level < LOGGER_LEVEL || isDebug == false)
                {
                    return;
                }
            }
            var clsName:String = "#";
            if (target != null)
            {
                clsName = getQualifiedClassName(target);
            }

            var appenderMsg:String = preprocessMsg(level, msg, clsName);
            for each (var appender:IAppender in _appenders)
            {
                appender.append(level, appenderMsg);
            }
        }

        private static function preprocessMsg(level:int, msg:String, name:String):String
        {
            var result:String = "(" + name + ")[" + new Date().time + "] " + msg;
            switch (level)
            {
                case LogLevel.DEBUG:
                    result = "Debug: " + result;
                    break;
                case LogLevel.INFO:
                    result = "Info: " + result;
                    break;
                case LogLevel.WARN:
                    result = "Warn: " + result;
                    break;
                case LogLevel.ERROR:
                    result = "Error: " + result;
                    break;
                case LogLevel.FATAL:
                    result = "Fatal: " + result;
                    break;
            }
            return result;
        }
    }
}


