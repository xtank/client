package x.game.util
{
    
    /**
     * XFlash - UniqueUtil
     * 
     * Created By fraser on 2014-2-9
     * Copyright TAOMEE 2014.All rights reserved
     */
    public class UniqueUtil
    {
        /**
         * 生成全球唯一随机GUID字符串
         * @return (String) 获得全球唯一随机GUID字符串
         * */
        public static function getGUID():String{
            return GUID.getGUID();
        }
        
        private static var _aUniqueIDs:Array;
        
        /**  唯一值  */
        public static function getUnique():Number
        {
            if (_aUniqueIDs == null)
            {
                _aUniqueIDs = new Array();
            }
            
            var dCurrent:Date = new Date();
            var nID:Number = dCurrent.getTime();
            
            while (!isUnique(nID))
            {
                nID += Random.random(dCurrent.getTime(), 2 * dCurrent.getTime());
            }
            
            _aUniqueIDs.push(nID);
            return nID;
        }
        
        private static function isUnique(nNumber:Number):Boolean
        {
            for (var i:Number = 0; i < _aUniqueIDs.length; i++)
            {
                if (_aUniqueIDs[i] == nNumber)
                {
                    return false;
                }
            }
            return true;
        }
    }
}