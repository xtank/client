package com.xtank.module.room
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import onlineproto.cs_select_tank;
	
	import x.game.manager.SurfaceManager;
	import x.game.net.post.SimplePost;
	import x.game.ui.XComponent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	import x.game.ui.flipbar.FlipBarInitData;
	import x.game.ui.flipbar.IFilpBarHost;
	import x.game.ui.flipbar.XFlipBar;
	import x.game.util.DisplayObjectUtil;
	import x.game.util.MathUtil;
	import x.tank.app.cfg.TankConfig;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.TankConfigInfo;
	import x.tank.core.manager.PlayerManager;
	import x.tank.core.model.TankConstant;
	import x.tank.net.CommandSet;

	public class TankSelectView extends XComponent implements IFilpBarHost
	{
		private var _tankName:TextField;
		//
		private var _hpBar:MovieClip;
		private var _speedBar:MovieClip;
		private var _defenseBar:MovieClip;
		private var _attackBar:MovieClip;
		private var _attackSpeedBar:MovieClip;
		private var _attackScopeBar:MovieClip;
		//
		private var _selectedTank:MovieClip ;
		private var _tankBoxs:Vector.<TankView>;
		private var _flipBar:XFlipBar;
		private var _selectedTankView:TankView ;
		private var _useBtn:XSimpleButton ;
		private var _useTag:MovieClip ;

		public function TankSelectView(skin:DisplayObject)
		{
			super(skin);
			//
			_tankName = _skin["tankName"];
			_hpBar = _skin["hpBar"];
			_speedBar = _skin["speedBar"];
			_defenseBar = _skin["defenseBar"];
			_attackBar = _skin["attackBar"];
			_attackSpeedBar = _skin["attackSpeedBar"];
			_attackScopeBar = _skin["attackScopeBar"];
			//
			_selectedTank = _skin["selectedTank"];
			_selectedTank.gotoAndStop(1) ;
			//
			DisplayObjectUtil.disableTarget(_hpBar);
			DisplayObjectUtil.disableTarget(_speedBar);
			DisplayObjectUtil.disableTarget(_defenseBar);
			DisplayObjectUtil.disableTarget(_attackBar);
			DisplayObjectUtil.disableTarget(_attackSpeedBar);
			DisplayObjectUtil.disableTarget(_attackScopeBar);
			//
			_tankBoxs = new Vector.<TankView>();
			_tankBoxs.push(new TankView(_skin["tankBox1"],onTankViewClick));
			_tankBoxs.push(new TankView(_skin["tankBox2"],onTankViewClick));
			_tankBoxs.push(new TankView(_skin["tankBox3"],onTankViewClick));
			//
			_useBtn = new XSimpleButton(skin["useBtn"]) ;
			_useBtn.addClick(onUseTank) ;
			//
			_useTag = skin["useTag"] ;
			_useTag.visible = false ;
			DisplayObjectUtil.disableTarget(_useTag) ;
			//
			_flipBar = new XFlipBar(new FlipBarInitData(3, this), _skin["flipBar"] as Sprite);
			_flipBar.dataProvide = DataProxyManager.tankData.tanks;
		}

		override public function dispose():void
		{
			while(_tankBoxs.length > 0)
			{
				_tankBoxs.pop().dispose() ;
			}
			_tankBoxs = null ;
			_flipBar.dispose() ;
			_flipBar = null ;
			_useBtn.dispose() ;
			_useBtn = null ;
			super.dispose();
		}

		override public function set data(value:Object):void
		{
			super.data = value;
			updateView();
		}
		
		private function onUseTank(btn:IButton):void
		{
			if(_selectedTankView != null && _selectedTankView.data != null)
			{
				var msg:cs_select_tank = new cs_select_tank() ;
				msg.tankid = (_selectedTankView.data as TankConfigInfo).id ;
				new SimplePost(CommandSet.$160.id, msg).send();
			}
			else
			{
				SurfaceManager.addTextSurface("请选择要出战的坦克!") ;
			}
		}
		
		public function set lock(value:Boolean):void
		{
			value ? DisplayObjectUtil.disableTarget((_skin as Sprite)):DisplayObjectUtil.enableTarget((_skin as Sprite)) ;
		}

		public function updatePageData(pageData:Array):void
		{
			var len:uint = _tankBoxs.length;
			for (var i:uint = 0; i < len; i++)
			{
				if(i < pageData.length)
				{
					_tankBoxs[i].data = pageData[i] ;
				}
				else
				{
					_tankBoxs[i].data = null ;
				}
			}
			// 触发默认选中第一个坦克
			_tankBoxs[0].onTankClick(null) ;
		}
		
		private function onTankViewClick(tankView:TankView):void
		{
			if(_selectedTankView != null)
			{
				_selectedTankView.selected = false ;
			}
			_selectedTankView = tankView ;
			_selectedTankView.selected = true ;
			//
			data = _selectedTankView.data ;
		}

		public function updateView():void
		{
			var tankInfo:TankConfigInfo = data as TankConfigInfo;
			_tankName.text = tankInfo.name;
			//
			_hpBar.gotoAndStop(MathUtil.ceil(tankInfo.hp * 100 / TankConstant.MAX_HP));
			_speedBar.gotoAndStop(MathUtil.ceil(tankInfo.speed * 100 / TankConstant.MAX_SPEED));
			_defenseBar.gotoAndStop(MathUtil.ceil(tankInfo.defense * 100 / TankConstant.MAX_DEFENSE));
			_attackBar.gotoAndStop(MathUtil.ceil(tankInfo.attack * 100 / TankConstant.MAX_ATTACK));
			_attackSpeedBar.gotoAndStop(MathUtil.ceil(tankInfo.attackSpeed * 100 / TankConstant.MAX_ATTACKSPEED));
			_attackScopeBar.gotoAndStop(MathUtil.ceil(tankInfo.attackScope * 100 / TankConstant.MAX_ATTACKSCOPE));
			//
			_selectedTank.gotoAndStop(tankInfo.id) ;
			//
			if(tankInfo.id == PlayerManager.getPlayer(TankConfig.userId).tankid)
			{
				_useBtn.enable = _useBtn.visible = false ;
				_useTag.visible = true ;
			}
			else
			{
				_useBtn.enable = _useBtn.visible = true ;
				_useTag.visible = false ;
			}
		}
	}
}
