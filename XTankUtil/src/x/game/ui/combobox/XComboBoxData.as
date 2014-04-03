package x.game.ui.combobox
{
    
    /**
     * XFlash - XComboBoxData
     * 
     * Created By fraser on 2014-2-16
     * Copyright TAOMEE 2014.All rights reserved
     */
    public class XComboBoxData
    {
        public var label:String ;
        public var data:Object ;
        //
        public function XComboBoxData(label:String,data:Object)
        {
            this.label = label ;
            this.data = data ;
        }
        
        // override by child
        public function compare(data:Object):Boolean
        {
            return this.data == data ;
        }
    }
}