package x.game.resize
{
    
    /**
     * XFlash - class_name
     * 
     * Created By fraser on 2014-1-30
     * Copyright TAOMEE 2014.All rights reserved
     */
    public interface IResizeable
    {
        function get resizeName():String;
        //
        function updatePosition(newWidth:Number, newHeight:Number):void;
    }
}