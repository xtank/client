package x.game.ui.combobox
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import x.game.util.DisplayObjectUtil;
	
	
	/**
	 * @author fraser
	 * 创建时间：2013-4-16下午3:50:09
	 * 类说明：
	 */
	public class SimpleTxtComboItem extends XComboBoxItem
	{
		protected var _txt:TextField ;
		
		public function SimpleTxtComboItem()
		{
            var skin:Sprite = new Sprite() ;
            _txt = new TextField() ;
            _txt.height = 20 ; 
            _txt.width = 100 ;
            _txt.textColor = 0xFFFFFF ;
            //
            _txt.selectable = false ;
            DisplayObjectUtil.disableTarget(_txt) ;
            skin.addChild(_txt) ;
            //
            skin.buttonMode = true ;
            skin.useHandCursor = true ;
            //
			super(skin);
		}
		
		override public function set width(value:Number):void
		{
			_txt.width = value ;
		}
        
        override public function set comboBoxItemData(value:XComboBoxData):void
        {
            super.comboBoxItemData = value ;
            //
            if(comboBoxItemData != null)
            {
                _txt.htmlText = String(comboBoxItemData.label) ;
            }	
            else
            {
                _txt.htmlText = "" ;
            }	
        }
		
		override public function dispose():void
		{
			super.dispose() ;
			_txt = null ;
		}
	}
}