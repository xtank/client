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
	public dynamic final class player_data_t extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const USIERID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.player_data_t.usierid", "usierid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var usierid:uint;

		/**
		 *  @private
		 */
		public static const STATUS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.player_data_t.status", "status", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var status:uint;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.usierid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.status);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var usierid$count:uint = 0;
			var status$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (usierid$count != 0) {
						throw new flash.errors.IOError('Bad data format: player_data_t.usierid cannot be set twice.');
					}
					++usierid$count;
					this.usierid = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (status$count != 0) {
						throw new flash.errors.IOError('Bad data format: player_data_t.status cannot be set twice.');
					}
					++status$count;
					this.status = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
