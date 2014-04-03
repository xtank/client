package x.game.util
{
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    /**
     * 对象功能
     * @author tb
     *
     */
    public class ObjectUtil
    {
        /** 获取类名 */
        public static function getClassName(obj:Object):String
        {
            var name:String = getQualifiedClassName(obj);
            var index:int = name.indexOf("::");
            if (index != -1)
            {
                name = name.substr(index + 2);
            }
            return name;
        }

        public function clone(target:Object):Object
        {
            var typeName:String = getQualifiedClassName(target); //获取当前类完全类名
            var packageName:String = typeName.split("::")[0]; //截取命名空间之前的包名
            var type:Class = getDefinitionByName(typeName) as Class; //获取当前类定义

            registerClassAlias(packageName, type); //使用当前类的包名作为类别名，类定义作为注册类

            var copier:ByteArray = new ByteArray();
            copier.writeObject(target);
            copier.position = 0;

            return copier.readObject();
        }

        //是否为Email地址;   
        public static function isEmail(char:String):Boolean
        {
            if (char == null)
            {
                return false;
            }
            char = StringUtil.trim(char);
            var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var result:Object = pattern.exec(char);
            if (result == null)
            {
                return false;
            }
            return true;
        }
    }
}
