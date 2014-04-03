package x.game.locale
{
    import mx.resources.ResourceBundle;
    import mx.resources.ResourceManager;
    
    import x.game.log.core.Logger;
    import x.game.util.StringUtil;

    /**
     * @author fraser
     *
     * 国际化定义文件解析
     */
    public class LocaleUtil
    {	
        public static function parser(str:String, bundle:ResourceBundle):void
        {
            var pairs:Array = str.split("\r\n");
            // 
            var len:uint = pairs.length;
            for (var i:uint = 0; i < len; i++)
            {
                var tmp:String = String(pairs[i]);
                if (tmp.indexOf("#") == -1)
                {
                    if (StringUtil.isWhitespace(tmp) == false)
                    {
                        tmp = StringUtil.removeWhitespace(tmp); // tmp.replace(/([ ]{1})/g,"");					
                        var value:Array = tmp.split("=");
                        bundle.content[value[0]] = value[1];
                    }
                }
            }
        }

        private static function getContent(bundleName:String,key:String):String
        {
            var message:String = ResourceManager.getInstance().getString(bundleName, key);
			if (message != null && message != "")
			{
				return message ;
			}
			else
			{
                Logger.error("在文件[" + bundleName +"]没有查询到[" + key + "]的定义");
				return "" ;
            }
        }
		
		public static function getError(key:String):String
		{
			return getContent("error", key) ;
		}
		
		public static function getLabel(key:String):String
		{
			return getContent("label", key) ;
		}
    }
}
