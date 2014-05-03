package onlineproto {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import onlineproto.battle_team_data_t;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class battle_data_t extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const MAPID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.battle_data_t.mapid", "mapid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var mapid:uint;

		/**
		 *  @private
		 */
		public static const TEAM1:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("onlineproto.battle_data_t.team1", "team1", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return onlineproto.battle_team_data_t; });

		public var team1:onlineproto.battle_team_data_t;

		/**
		 *  @private
		 */
		public static const TEAM2:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("onlineproto.battle_data_t.team2", "team2", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return onlineproto.battle_team_data_t; });

		public var team2:onlineproto.battle_team_data_t;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.mapid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.team1);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.team2);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var mapid$count:uint = 0;
			var team1$count:uint = 0;
			var team2$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (mapid$count != 0) {
						throw new flash.errors.IOError('Bad data format: battle_data_t.mapid cannot be set twice.');
					}
					++mapid$count;
					this.mapid = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (team1$count != 0) {
						throw new flash.errors.IOError('Bad data format: battle_data_t.team1 cannot be set twice.');
					}
					++team1$count;
					this.team1 = new onlineproto.battle_team_data_t();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.team1);
					break;
				case 3:
					if (team2$count != 0) {
						throw new flash.errors.IOError('Bad data format: battle_data_t.team2 cannot be set twice.');
					}
					++team2$count;
					this.team2 = new onlineproto.battle_team_data_t();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.team2);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
