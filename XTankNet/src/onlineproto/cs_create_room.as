package onlineproto {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class cs_create_room extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const MAP_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.cs_create_room.map_id", "mapId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var mapId:uint;

		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("onlineproto.cs_create_room.name", "name", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var name:String;

		/**
		 *  @private
		 */
		public static const PASSWD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.cs_create_room.passwd", "passwd", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var passwd:uint;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.mapId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.name);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.passwd);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var map_id$count:uint = 0;
			var name$count:uint = 0;
			var passwd$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (map_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: cs_create_room.mapId cannot be set twice.');
					}
					++map_id$count;
					this.mapId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: cs_create_room.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (passwd$count != 0) {
						throw new flash.errors.IOError('Bad data format: cs_create_room.passwd cannot be set twice.');
					}
					++passwd$count;
					this.passwd = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
