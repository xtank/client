package com.fraser.tool
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class XMLPackageUtil
	{
		/** 解包 */
		public static function unpackageFiles(byteArray:ByteArray):Vector.<XMLFile>
		{
			byteArray.uncompress();
			//
			var xmlData:Vector.<XMLFile> = new Vector.<XMLFile>(); 
			while (byteArray.bytesAvailable > 0)
			{
				var name:String = byteArray.readUTF();
				var len:int = byteArray.readInt();
				//
				xmlData.push(new XMLFile(name,byteArray.readUTFBytes(len))) ;
			}
			return xmlData ;
		}
		
		public static function packageFiles(files:Array,onChildPackage:Function,onComplete:Function):void
		{
			var result:ByteArray = new ByteArray() ;
			for each (var f:File in files)
			{
				if(f.isDirectory == false && endsWith(f.name,"xml"))
				{					
					var st:FileStream = new FileStream();
					st.open(f, FileMode.READ);
					//
					var xmlData:ByteArray = new ByteArray();
					st.readBytes(xmlData);
					//
					var byte:ByteArray = new ByteArray();
					byte.writeUTF(f.name); //名字  
					byte.writeInt(xmlData.length); //长度  
					byte.writeBytes(xmlData, 0, xmlData.length); //内容  
					result.writeBytes(byte, 0, byte.length);
					//
					if(onChildPackage != null)
					{
						onChildPackage(f.name) ;
					}
				}
			}
			// 
			if(onComplete != null)
			{
				result.position = 0;
				result.compress();
				onComplete(result) ;
			}
		}
		
		/**  一个字符串从结尾起是否有指定的字符串 */
		private static function endsWith(input:String, suffix:String):Boolean
		{
			var a:String = suffix.toLocaleLowerCase() ;
			var b:String = input.substring(input.length - suffix.length).toLocaleLowerCase() ;
			var rs:Boolean = (a == b) ;
			return rs ;
		}
	}
}