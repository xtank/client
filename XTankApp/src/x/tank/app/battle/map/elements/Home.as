package x.tank.app.battle.map.elements
{
	import flash.display.Bitmap;
	
	import onlineproto.battle_team_data_t;
	
	import x.game.manager.UIManager;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.BarrierConfigInfo;
	import x.tank.core.cfg.model.MapConfigInfo;
	import x.tank.core.cfg.model.MapDataTeamInfo;

	//
	public class Home extends Barrier
	{
		public var teamData:battle_team_data_t ;
		
		public function Home(teamData:battle_team_data_t,mapConfig:MapConfigInfo)
		{
			this.teamData = teamData ;
			//
			var teamInfo:MapDataTeamInfo = mapConfig.getTeamInfo(teamData.teamid) ;
			var configInfo:BarrierConfigInfo = DataProxyManager.barrierData.getHome(teamInfo.homeId) ;
			var bitMap:Bitmap = new Bitmap(UIManager.getBitmapData(configInfo.cls)) ;
			//
			super(bitMap,configInfo);
			//
			mapx = teamInfo.home.x ;
			mapy = teamInfo.home.y ;
		}
	}
}
