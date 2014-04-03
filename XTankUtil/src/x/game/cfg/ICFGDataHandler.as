package x.game.cfg
{
	public interface ICFGDataHandler
	{
		function get fileName():String ;
		function parser(xml:XML):void ;
	}
}