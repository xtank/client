package x.game.statistic
{
    
    
    /**
     * XFlash - StatisticsManager
     * 
     * Created By fraser on 2014-2-9
     * Copyright TAOMEE 2014.All rights reserved
     */
    public class StatisticsManager
    {
        private static var _imple:IStatistic ;
        
        public static function setUp(imple:IStatistic):void
        {
            _imple = imple; 
        }
        
        public static function send(value:*):void
        {
            if(_imple != null)
            {
                _imple.send(value) ;
            }
            else
            {
                throw new Error("你需要安装一个 x.game.statistic.IStatistic 接口的实现");
            }
        }
    }
}