package x.game.util
{
	/**
	 * 给方法增加参数
	 * @author tb
	 *
	 */
	public class Delegate
	{
		public static function create(func:Function, ...args):Function
		{
			var f:Function = function():*
			{
				var func:Function = arguments.callee.func;
				var pat:Array = arguments.concat(args);
				return func.apply(null, pat);
			};
			f["func"] = func;
			return f;
		}
	}
}