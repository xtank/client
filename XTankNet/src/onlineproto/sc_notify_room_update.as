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
	public dynamic final class sc_notify_room_update extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const OPER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.sc_notify_room_update.oper", "oper", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var oper:uint;

		/**
		 *  @private
		 */
		public static const ROOM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("onlineproto.sc_notify_room_update.room", "room", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return onlineproto.room_data_t; });

		private var room$field:onlineproto.room_data_t;

		public function clearRoom():void {
			room$field = null;
		}

		public function get hasRoom():Boolean {
			return room$field != null;
		}

		public function set room(value:onlineproto.room_data_t):void {
			room$field = value;
		}

		public function get room():onlineproto.room_data_t {
			return room$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.oper);
			if (hasRoom) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, room$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var oper$count:uint = 0;
			var room$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (oper$count != 0) {
						throw new flash.errors.IOError('Bad data format: sc_notify_room_update.oper cannot be set twice.');
					}
					++oper$count;
					this.oper = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (room$count != 0) {
						throw new flash.errors.IOError('Bad data format: sc_notify_room_update.room cannot be set twice.');
					}
					++room$count;
					this.room = new onlineproto.room_data_t();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.room);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
