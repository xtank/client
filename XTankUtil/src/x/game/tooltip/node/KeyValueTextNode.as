package x.game.tooltip.node
{
    import flash.text.TextField;
    
    import x.game.manager.UIManager;
    import x.game.util.DisplayObjectUtil;



    /**
     * 属性
     *
     * @author barlow
     * 创建时间：2013-1-25上午10:25:49
     */
    public class KeyValueTextNode extends BaseNode
    {
        public static const NODE_Name:String = "KeyValueText";
        //
        private var _key_txt:TextField;
        private var _val_txt:TextField;

        public function KeyValueTextNode(val:String)
        {
            super(UIManager.getSprite("Tip_RES_UI_KeyValueTextNode"));

            _key_txt = nodeSkin["key_txt"];
            _val_txt = nodeSkin["value_txt"];
            //
            var tmpVal:Array = val.split(BaseNode.NODE_KEY_TAG);
            _key_txt.htmlText = tmpVal[0];
            _val_txt.htmlText = tmpVal[1];
            //
            DisplayObjectUtil.disableTarget(_key_txt);
            DisplayObjectUtil.disableTarget(_val_txt);
        }

        override public function dispose():void
        {
            _key_txt = null;
            _val_txt = null;
            super.dispose();
        }
    }
}


