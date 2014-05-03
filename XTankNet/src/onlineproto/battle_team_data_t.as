package onlineproto {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import onlineproto.battle_member_data_t;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class battle_team_data_t extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TEAMID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.battle_team_data_t.teamid", "teamid", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var teamid:uint;

		/**
		 *  @private
		 */
		public static const MEMBER_LIST:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("onlineproto.battle_team_data_t.member_list", "memberList", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return onlineproto.battle_member_data_t; });

		[ArrayElementType("onlineproto.battle_member_data_t")]
		public var memberList:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.teamid);
			for (var memberList$index:uint = 0; memberList$index < this.memberList.length; ++memberList$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.memberList[memberList$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var teamid$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (teamid$count != 0) {
						throw new flash.errors.IOError('Bad data format: battle_team_data_t.teamid cannot be set twice.');
					}
					++teamid$count;
					this.teamid = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					this.memberList.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new onlineproto.battle_member_data_t()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
