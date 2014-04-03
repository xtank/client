package x.game.cfg
{
	import de.polygonal.ds.HashMap;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;

	public class DataProxy
	{
		private static var _head:String ;
		private static var _zip:FZip ;
		private static var _handlers:HashMap ;
		
		static public function init(head:String,zip:FZip):void
		{
			_head = head ;
			_zip = zip ;
			_handlers = new HashMap() ;
		}
		
		static public function getXmlFile(name:String):XML
		{
			var file:FZipFile = (_zip as FZip).getFileByName(_head + name);
			return new XML(file.getContentAsString()) ;
		}

		// ----------------------------------------------------------------------
	}
}