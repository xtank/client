package x.game.log.core
{

    /**
     * log输入类必须实现的接口
     *@author fraser
     */
    public interface IAppender
    {
        function append(level:int, msg:String):void;
    }
}
