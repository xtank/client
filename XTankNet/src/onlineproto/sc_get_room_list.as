package onlineproto {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import onlineproto.room_data_t;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class sc_get_room_list extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ROOM_LIST:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("onlineproto.sc_get_room_list.room_list", "roomList", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return onlineproto.room_data_t; });

		[ArrayElementType("onlineproto.room_data_t")]
		public var roomList:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var roomList$index:uint = 0; roomList$index < this.roomList.length; ++roomList$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.roomList[roomList$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.roomList.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new onlineproto.room_data_t()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
