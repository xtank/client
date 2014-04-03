package onlineproto {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import onlineproto.player_data_t;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class sc_notify_player_update extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PLAYER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("onlineproto.sc_notify_player_update.player", "player", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return onlineproto.player_data_t; });

		public var player:onlineproto.player_data_t;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.player);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var player$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (player$count != 0) {
						throw new flash.errors.IOError('Bad data format: sc_notify_player_update.player cannot be set twice.');
					}
					++player$count;
					this.player = new onlineproto.player_data_t();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.player);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
