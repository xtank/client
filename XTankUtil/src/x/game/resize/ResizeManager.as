package x.game.resize
{
    import de.polygonal.ds.HashMap;
    import de.polygonal.ds.Itr;

    /**
     * @author fraser
     * 创建时间：2013-1-14 上午10:57:38
     */
    public class ResizeManager
    {
        private static var _maps:HashMap = new HashMap();

        /** 添加重布局组件 */
        public static function addComponent(component:IResizeable):void
        {
            _maps.set(component.resizeName, component);
        }
        
        /** 移除重布局组件 */
        public static function removeComponent(component:IResizeable):void
        {
            _maps.clr(component.resizeName);
        }
        
        /** 重布局组件 */
        public static function updatePosition(newWidth:Number, newHeight:Number):void
        {
            var itr:Itr = _maps.iterator() ;
            while(itr.hasNext())
            {
                (itr.next() as IResizeable).updatePosition(newWidth,newHeight) ;
            }
        }
    }
}