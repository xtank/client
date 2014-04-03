package x.game.net.util
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * 小端的ByteArray
	 * @author fraser
	 *
	 */
	public class LittleEndianByteArray extends ByteArray
	{
		public function LittleEndianByteArray()
		{
			endian = Endian.LITTLE_ENDIAN;
		}

		public static function writeIntergerAsUnsignedByte(value:int):LittleEndianByteArray
		{
			var byteArr:LittleEndianByteArray = new LittleEndianByteArray();
			byteArr.writeByte(value);
			return byteArr;
		}

		public static function writeIntergerAsUnsignedShort(value:int):LittleEndianByteArray
		{
			var byteArr:LittleEndianByteArray = new LittleEndianByteArray();
			byteArr.writeShort(value);
			return byteArr;
		}

		public static function writeIntergerAsUnsignedInt(value:int):LittleEndianByteArray
		{
			var byteArr:LittleEndianByteArray = new LittleEndianByteArray();
			byteArr.writeUnsignedInt(value);
			return byteArr;
		}

		public function clone():LittleEndianByteArray
		{
			this.position = 0;
			var result:LittleEndianByteArray = new LittleEndianByteArray();
			this.readBytes(result);
			result.position = 0;
			this.position = 0;
			return result;
		}
	}
}
