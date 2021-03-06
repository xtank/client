
package x.tank.net
{
    import onlineproto.* ;
    import x.game.log.core.Logger ;
    import x.game.net.core.Command;

	/**
	 * command list
	 * @author	fraser
	 */
	public final class CommandSet
	{
        static public function initCMDS():void
        {
            Logger.info("init cmds") ;
        }
      public static const $101: Command = new Command(101, cs_enter_server, sc_enter_server);      // 进入在线服务器
      public static const $102: Command = new Command(102, cs_keep_live, sc_keep_live);      // 心跳包
      public static const $103: Command = new Command(103, cs_create_role, sc_create_role);      // create role
      public static const $151: Command = new Command(151, cs_get_room_list, sc_get_room_list);      // 拉取房间列表
      public static const $152: Command = new Command(152, cs_enter_room, sc_enter_room);      // 进入房间
      public static const $153: Command = new Command(153, cs_leave_room, sc_leave_room);      // 离开房间
      public static const $154: Command = new Command(154, cs_inside_ready, sc_inside_ready);      // 玩家准备
      public static const $155: Command = new Command(155, cs_inside_start, sc_inside_start);      // 房主开始游戏
      public static const $156: Command = new Command(156, cs_notify_room_update, sc_notify_room_update);      // 房间信息更新
      public static const $157: Command = new Command(157, cs_create_room, sc_create_room);      // 创建房间
      public static const $158: Command = new Command(158, cs_cancel_inside_ready, sc_cancel_inside_ready);      // 玩家取消准备
      public static const $159: Command = new Command(159, cs_select_team, sc_select_team);      // 玩家选择队伍
      public static const $160: Command = new Command(160, cs_select_tank, sc_select_tank);      // 玩家选择出战坦克
      public static const $201: Command = new Command(201, cs_notify_player_update, sc_notify_player_update);      // 玩家状态更新
      public static const $301: Command = new Command(301, cs_battle_ready, sc_battle_ready);      // 客户端资源准备完成后通知服务器的消息包
      public static const $302: Command = new Command(302, cs_notify_battle_start, sc_notify_battle_start);      // 通知开始游戏
      public static const $303: Command = new Command(303, cs_notify_member_leave, sc_notify_member_leave);      // 通知成员离线
      public static const $304: Command = new Command(304, cs_tank_move, sc_tank_move);      // 通知移动
      public static const $305: Command = new Command(305, cs_tank_move_stop, sc_tank_move_stop);      // 通知停止移动

	}
}
