
package x.tank.net
{
	import onlineproto.*;
	import x.game.log.core.Logger;
	import x.game.net.core.Command;

	/**
	 * command list
	 * @author	fraser
	 */
	public final class CommandSet
	{
		static public function initCMDS():void
		{
			Logger.info("init cmds");
		}

		public static const $101:Command = new Command(101, cs_enter_server, sc_enter_server); // 进入在线服务器
		public static const $102:Command = new Command(102, cs_keep_live, sc_keep_live); // 心跳包
		public static const $151:Command = new Command(151, cs_get_room_list, sc_get_room_list); // 拉取房间列表
		public static const $152:Command = new Command(152, cs_enter_room, sc_enter_room); // 进入房间
		public static const $153:Command = new Command(153, cs_leave_room, sc_leave_room); // 离开房间
		public static const $154:Command = new Command(154, cs_inside_ready, sc_inside_ready); // 玩家准备
		public static const $155:Command = new Command(155, cs_inside_start, sc_inside_start); // 房主开始游戏
		public static const $156:Command = new Command(156, cs_notify_room_update, sc_notify_room_update); // 房间信息更新
		public static const $157:Command = new Command(157, cs_create_room, sc_create_room); // 创建房间
		public static const $201:Command = new Command(201, cs_notify_player_update, sc_notify_player_update); // 玩家状态更新

	}
}
