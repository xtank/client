package x.tank.app.battle.map.elements
{
	import flash.display.Bitmap;
	
	import onlineproto.battle_team_data_t;
	
	import x.game.manager.UIManager;
	import x.tank.app.battle.map.BattleMap;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.BarrierConfigInfo;
	import x.tank.core.cfg.model.MapDataTeamInfo;

	//
	public class Home extends Barrier
	{
		public var teamData:battle_team_data_t ;
		
		public function Home(teamData:battle_team_data_t,teamInfo:MapDataTeamInfo,$map:BattleMap)
		{
			this.teamData = teamData ;
			//
			var configInfo:BarrierConfigInfo = DataProxyManager.barrierData.getHome(teamInfo.homeId) ;
			//
			super(new Bitmap(UIManager.getBitmapData(configInfo.cls)),configInfo,$map);
			//
			mapx = teamInfo.home.x ;
			mapy = teamInfo.home.y ;
		}
	}
}
