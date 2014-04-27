package com.xtank.module.room
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import x.game.ui.XComponent;
	import x.game.ui.flipbar.FlipBarInitData;
	import x.game.ui.flipbar.IFilpBarHost;
	import x.game.ui.flipbar.XFlipBar;
	import x.game.util.DisplayObjectUtil;
	import x.game.util.MathUtil;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.TankConfigInfo;
	import x.tank.core.model.TankConstant;

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
			_flipBar = new XFlipBar(new FlipBarInitData(3, this), _skin["flipBar"] as Sprite);
			_flipBar.dataProvide = DataProxyManager.tankData.tanks;
		}

		override public function dispose():void
		{
			super.dispose();
		}

		override public function set data(value:Object):void
		{
			super.data = value;
			updateView();
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

		private function updateView():void
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
		}
	}
}
