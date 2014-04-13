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
	public dynamic final class room_data_t extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.room_data_t.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:uint;

		/**
		 *  @private
		 */
		public static const OWNERID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.room_data_t.ownerid", "ownerid", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var ownerid:uint;

		/**
		 *  @private
		 */
		public static const MAPID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.room_data_t.mapid", "mapid", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var mapid:uint;

		/**
		 *  @private
		 */
		public static const STATUS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.room_data_t.status", "status", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		public var status:uint;

		/**
		 *  @private
		 */
		public static const PLAYLIST:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("onlineproto.room_data_t.playlist", "playlist", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return onlineproto.player_data_t; });

		[ArrayElementType("onlineproto.player_data_t")]
		public var playlist:Array = [];

		/**
		 *  @private
		 */
		public static const PASSWD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("onlineproto.room_data_t.passwd", "passwd", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var passwd$field:uint;

		private var hasField$0:uint = 0;

		public function clearPasswd():void {
			hasField$0 &= 0xfffffffe;
			passwd$field = new uint();
		}

		public function get hasPasswd():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set passwd(value:uint):void {
			hasField$0 |= 0x1;
			passwd$field = value;
		}

		public function get passwd():uint {
			return passwd$field;
		}

		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("onlineproto.room_data_t.name", "name", (7 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var name:String;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.id);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.ownerid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.mapid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.status);
			for (var playlist$index:uint = 0; playlist$index < this.playlist.length; ++playlist$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.playlist[playlist$index]);
			}
			if (hasPasswd) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, passwd$field);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 7);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.name);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var id$count:uint = 0;
			var ownerid$count:uint = 0;
			var mapid$count:uint = 0;
			var status$count:uint = 0;
			var passwd$count:uint = 0;
			var name$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: room_data_t.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (ownerid$count != 0) {
						throw new flash.errors.IOError('Bad data format: room_data_t.ownerid cannot be set twice.');
					}
					++ownerid$count;
					this.ownerid = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (mapid$count != 0) {
						throw new flash.errors.IOError('Bad data format: room_data_t.mapid cannot be set twice.');
					}
					++mapid$count;
					this.mapid = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (status$count != 0) {
						throw new flash.errors.IOError('Bad data format: room_data_t.status cannot be set twice.');
					}
					++status$count;
					this.status = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 5:
					this.playlist.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new onlineproto.player_data_t()));
					break;
				case 6:
					if (passwd$count != 0) {
						throw new flash.errors.IOError('Bad data format: room_data_t.passwd cannot be set twice.');
					}
					++passwd$count;
					this.passwd = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 7:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: room_data_t.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
