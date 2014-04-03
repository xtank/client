package x.game.manager
{
    import flash.display.InteractiveObject;
    import flash.system.IME;
    import flash.text.TextField;
    import flash.text.TextFieldType;

    /**
     * 焦点管理
     * @author tb
     *
     */
    public class FocusManager
    {
        private static var _focusTargets:Array = new Array();

        public static function removeFocus(obj:InteractiveObject):void
        {
            var index:int = _focusTargets.indexOf(obj);
            if (index != -1)
            {
                _focusTargets.splice(index, 1);
            }

            if (_focusTargets.length <= 0)
            {
                setFocus(StageManager.stage);
            }
            else
            {
                setFocus(_focusTargets.pop());
            }
        }

        /**  设置焦点  */
        public static function setFocus(obj:InteractiveObject):void
        {
            StageManager.stage.focus = obj;
            //
            _focusTargets.push(obj);
            //
            if (obj is TextField && (obj as TextField).type == TextFieldType.INPUT)
            {
                IME.enabled = true;
            }
            else
            {
                IME.enabled = false;
            }
        }
    }
}
