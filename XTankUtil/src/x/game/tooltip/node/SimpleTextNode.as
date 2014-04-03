package x.game.tooltip.node
{
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    import x.game.manager.UIManager;
    import x.game.util.DisplayObjectUtil;

    /**
     * @author fraser
     * 创建时间：2013-3-20下午6:10:10
     * 类说明：
     */
    public class SimpleTextNode extends BaseNode
    {	
		public static const NODE_Name:String = "SIMPLETEXT";
		
        private var _key_txt:TextField;

        public function SimpleTextNode(val:String,txtColor:uint = 0x69C1F5)
        {
            super(UIManager.getSprite("Tip_RES_UI_SimpleTextNode"));

            _key_txt = nodeSkin["key_txt"];
			_key_txt.autoSize = TextFieldAutoSize.RIGHT ;
            _key_txt.htmlText = val;
			_key_txt.textColor = txtColor ;
            DisplayObjectUtil.disableTarget(_key_txt);
        }

        override public function dispose():void
        {
            super.dispose();
            _key_txt = null;
        }
    }
}


