package x.game.model
{
    import flash.display.InteractiveObject;
    import flash.events.ContextMenuEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;

	/** 右键菜单项 */
    public class SimpleMenu
    {
        private var _menu:ContextMenu;

        public function SimpleMenu(obj:InteractiveObject)
        {
            _menu = new ContextMenu();
            _menu.hideBuiltInItems();
            obj.contextMenu = _menu;
        }

        public function addItem(caption:String, onHandle:Function = null):void
        {
            var item:ContextMenuItem = new ContextMenuItem(caption);
            _menu.customItems.push(item);
            if (onHandle != null)
            {
                item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onHandle);
            }
        }

        public function addLinkItem(caption:String, url:String, window:String = "_blank"):void
        {
            addItem(caption, onClick);
            function onClick(e:ContextMenuEvent):void
            {
                navigateToURL(new URLRequest(url), window);
            }
        }
    }
}
