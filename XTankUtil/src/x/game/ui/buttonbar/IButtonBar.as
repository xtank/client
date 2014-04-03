package x.game.ui.buttonbar
{
    import x.game.ui.button.IToggleButton;
    
    /**
     * XFlash - class_name
     * 
     * Created By fraser on 2014-2-9
     * Copyright TAOMEE 2014.All rights reserved
     */
    public interface IButtonBar
    {
        // 添加按钮
        function addButton(button:IToggleButton,isDefaultSelected:Boolean = false) :void;
        //
        function addChange(fun:Function):void ;
        //
        function setDefaultSelectedButton(index:uint):void ;
        //
        function getButtons():Vector.<IToggleButton> ;
        //
        function get selectedButton():IToggleButton 
    }
}