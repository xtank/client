package x.game.util
{
	
	/**
	 * AntUtilsSWC -  FileUtil
	 * 
	 * Created by fraser on 2013-12-19
	 * Copyright TAOMEE 2013. All rights reserved
	 *
	 */
	public class FileUtil
	{
		/** 移除文件扩展名*/
		public static function removeExtension(filename:String):String
		{
			var extensionIndex:Number = filename.lastIndexOf('.');
			if (extensionIndex == -1)
			{
				return filename;
			}
			else
			{
				return filename.substr(0, extensionIndex);
			}
		}
		
		/** 获取文件扩展名*/
		public static function extractExtension(filename:String):String
		{
			var extensionIndex:Number = filename.lastIndexOf('.');
			if (extensionIndex == -1)
			{
				return "";
			}
			else
			{
				return filename.substr(extensionIndex + 1, filename.length);
			}
		}
		
		/**
		 * 获取url中的文件名
		 * @param url
		 * @return
		 *
		 */
		public static function getFileName(url:String):String
		{
			var sindex:int = url.indexOf("?");
			if (sindex == -1)
			{
				sindex = int.MAX_VALUE;
			}
			var index1:int = url.lastIndexOf(".", sindex);
			var index2:int = url.lastIndexOf("/") + 1;
			return url.substring(index2, index1);
		}		
	}
}