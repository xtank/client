package x.game.loader.loadingUI
{
	import flash.display.DisplayObjectContainer;
    
    /**
     * XFlash - class_name
     * 
     * Created By fraser on 2014-2-9
     * Copyright TAOMEE 2014.All rights reserved
     */
    public interface ILoaderUI
    {
        function show(title:String = "", isCover:Boolean = true, parent:DisplayObjectContainer = null):void
        //
        function hide():void ;
        //
        function progressTotal(percent:uint):void ;
    }
}