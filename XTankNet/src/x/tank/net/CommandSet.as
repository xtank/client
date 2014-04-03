
package x.tank.net.core
{
    import onlineproto.* ;
    import x.game.log.core.Logger ;

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

       public static const $101: Command = new Command(101, cs_enter_server, sc_enter_server); // 进入在线服务器
       public static const $102: Command = new Command(102, cs_keep_live, sc_keep_live); // 进入在线服务器

	}
}
