package
{
	import com.fraser.tool.XMLFile;
	import com.fraser.tool.XMLPackageUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class XMLPackageTool extends Sprite
	{
		private var _txt:TextField ;
		private var _file:File = new File();
		
		public function XMLPackageTool()
		{
			//将一组xml 进行打包  
			_file.addEventListener(Event.SELECT, onSelectHandler);
			_file.browseForDirectory("请选择配置文件所在文件夹!");
		}
		
		private function onSelectHandler(event:Event):void
		{
			_txt = new TextField() ;
			_txt.border = true ;
			_txt.borderColor = 0x000000 ;
			_txt.selectable = false ;
			_txt.multiline = true ;
			_txt.width = 500 ;
			_txt.height = 400 ;
			addChild(_txt) ;
			// 获取文件列表
			var fileArr:Array = _file.getDirectoryListing();
			XMLPackageUtil.packageFiles(fileArr,onChildFilePackage,onComplete) ;
		}
		
		private function onChildFilePackage(name:String):void
		{
			_txt.scrollV = _txt.maxScrollV ;
			_txt.text += "\n [" + name + "] add package."
		}
		
		private function onComplete(pkgByteArray:ByteArray ):void
		{
//			trace(_file.nativePath) ;
//			trace(_file.url) ;
			var path:String = _file.url + "/cfg.bin" ;
			//
			var fileStream:FileStream = new FileStream();
			var newFile:File = new File(path) ;
			// var newFile:File = File.desktopDirectory.resolvePath("cfg.bin");
			fileStream.open(newFile, FileMode.WRITE);
			fileStream.position = 0;
			fileStream.writeBytes(pkgByteArray, 0, pkgByteArray.length);
			fileStream.close();			
			//
			_txt.text += "\n 打包完成，查看桌面!" ;
			
			pkgByteArray.position = 0 ;
			var content:Vector.<XMLFile> = XMLPackageUtil.unpackageFiles(pkgByteArray) ;
			trace(content[0].content) ;
			/** **/
		}
	}
}