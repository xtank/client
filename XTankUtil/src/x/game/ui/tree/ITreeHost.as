package x.game.ui.tree
{
    
    /**
     * XFlash - class_name
     * 
     * Created By fraser on 2014-2-12
     * Copyright TAOMEE 2014.All rights reserved
     */
    public interface ITreeHost
    {
        /** 
        * 当前选中的树叶项发生变更时会被触发 
        * baseUI.data 
        * 
        * */
        function onLeafChange(baseUI:TreeLeafBaseUI):void ;
        /** 
        * 
        * 当前选中的树干项发生变更时会被触发 
        * baseUI.data 
        * 
        * */
        function onTrunkChange(baseUI:TreeTrunkBaseUI):void
    }
}