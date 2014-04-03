package x.game.manager
{

    import flash.display.InteractiveObject;
    import flash.display.Sprite;
    
    import x.game.tooltip.BaseTipSkin;
    import x.game.tooltip.BaseTooltip;

    /**
     * 提示管理
     * @author fraser
     *
     */
    public class TooltipManager
    {
        private static var _toolTip:BaseTooltip;
        private static var _tipLayer:Sprite;

        public static function init(tipLayer:Sprite):void
        {
            _toolTip = new BaseTooltip();
            _tipLayer = tipLayer;
        }

        public static function get tipLayer():Sprite
        {
            return _tipLayer;
        }

        /** 移除提示  */
        public static function remove(target:InteractiveObject):void
        {
            if (_toolTip == null)
            {
                throw new Error("init TooltipManager First!");
            }
            else
            {
                _toolTip.remove(target);
            }
        }

        /** 隐藏所有Tip */
        public static function hideAll():void
        {
            if (_toolTip == null)
            {
                throw new Error("init TooltipManager First!");
            }
            else
            {
                _toolTip.hideAll();
            }
        }

        /** 自定义皮肤  */
        public static function addCustomerTipSkin(target:InteractiveObject, skin:BaseTipSkin):void
        {
            if (_toolTip == null)
            {
                throw new Error("init TooltipManager First!");
            }
            else
            {
                _toolTip.add(target, skin);
            }
        }
    }
}
