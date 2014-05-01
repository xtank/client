package x.game.util
{
    import flash.utils.ByteArray;

    public class StringUtil
    {
        
        public static const HEX_Head:String = "0x"; //十六进制数字表示头
        public static const DOT:String = "."; //点
        
        /**
         * 字符串相反排列函数
         * @param $str 原字符串
         * @return (String) 返回相反的原字符串
         * */
        public static function reverseSort($str:String):String
        {
            var s:String = "";
            var r:Array = $str.split("");
            var n:Number = r.length;
            for (var i:int = 0; i < n; i++)
            {
                s += r[n - i - 1];
            }
            return s;
        }

        /**
         * 全部替换指定的字符串（区分大小写）。如要替换的字符串不在源字符串中则返回源字符串。
         * @param $str 源总字符串
         * @param $old 要替换的字符串
         * @param $new 替换成的新字符串
         * @return (String) 替换后的新字符串
         * */
        public static function replaceAll($str:String, $old:String, $new:String):String
        {
            var str:String = "";
            var r:Array = $str.split($old);
            var n:int = r.length;
            var i:int = 0;
            for each (var s:String in r)
            {
                if (i < n - 1)
                {
                    str += s + $new;
                }
                else
                {
                    str += s;
                }
                i++;
            }
            return str;
        }

        /**
         * 全部替换指定的字符串（区分大小写）。如要替换的字符串不在源字符串中则返回源字符串。
         * @param $str 源总字符串
         * @param $old 要替换的字符串
         * @param $new 替换成的新字符串
         * @return (String) 替换后的新字符串
         * */
        public static function replaceAll2($str:String, $old:String, $new:String):String
        {
            return $str.replace(new RegExp($old, "g"), $new);
        }

        /**
         * 全部替换指定的字符串（不区分大小写）。如要替换的字符串不在源字符串中则返回源字符串。
         * @param $str 源总字符串
         * @param $old 要替换的字符串
         * @param $new 替换成的新字符串
         * @return (String) 替换后的新字符串
         * */
        public static function replaceAll3($str:String, $old:String, $new:String):String
        {
            return $str.replace(new RegExp($old, "gi"), $new);
        }

        /**
         * 当忽略大小写时字符串是否相等
         * @param $str1
         * @param $str2
         * @return (Boolean) 如果相等返回true，否则返回false
         * */
        public static function isEqual($str1:String, $str2:String):Boolean
        {
            if ($str1.toLowerCase() == $str2.toLowerCase())
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /**
         * 是否为空白，包括多个空白和换行空白等
         * @param $str 源字符串
         * @return (Boolean) 如源字符串含有空白则返回true，否则返回false
         * */
        public static function isBlank($str:String):Boolean
        {
            switch ($str)
            {
				case "":
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "\f":
                    return true;
                default:
                    return false;
            }
        }

        /**
         * 指定字符串在源字符串中出现的次数
         * @param $str 源字符串
         * @param $target 目标字符串
         * @return (int) 出现的次数
         * */
        public static function strAmount($str:String, $target:String):int
        {
            return $str.split($target).length - 1;
        }



        /**
         * 去掉指定字符串两边的空格
         * @param $str 源字符串
         * @return (String) 新字符串
         * */
        public static function deleteBothEmpty($str:String):String
        {
            var r:Array = $str.split("");
            var arr:Array = [];
            var n:Number = r.length;
            var i:int = 0;
            for each (var s:String in r)
            {
                if (s == " ")
                {
                    arr = r.slice(i + 1, n);
                }
                else
                {
                    r = arr;
                    break;
                }
                i++;
            }
            var j:int = r.length - 1;
            for (j; j > -1; j--)
            {
                if (r[j] == " ")
                {
                    arr = r.slice(0, j);
                }
                else
                {
                    break;
                }
            }
            return arr.join("");
        }

        /**
         * 指定字符是否在原字符串的开头
         * @param $str 要指定的字符串
         * @param $target 源字符串
         * @return (Boolean) 指定字符串在开头返回true，否则返回false
         * */
        public static function isTargetFirst($str:String, $target:String):Boolean
        {
            if ($target == $str.split("")[0])
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /**
         * 指定字符是否在原字符串的结尾
         * @param $str 要指定的字符串
         * @param $target 源字符串
         * @return (Boolean) 指定字符串在结尾返回true，否则返回false
         * */
        public static function isTargetEnd($str:String, $target:String):Boolean
        {
            var r:Array = $str.split("");
            if ($target == r[r.length - 1])
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /**
         * 是否全部都是中文字符(中文形式的标点符号也是中文、但数字和-都不算中文)
         * @param $str 源字符串
         * @return (Boolean) 如果源字符串全都是中文字符则返回true，否则返回false
         * */
        public static function isChinese($str:String):Boolean
        {
            if ($str != null)
            {
                //str = trim(str);    //消除两边空格 
                var re:RegExp = /^[\u0391-\uFFE5]+$/;
                var obj:Object = re.exec($str);
                if (obj != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        /**
         * 是否含有中文字符(中文形式的标点符号也是中文、但数字和-都不算中文)
         * @param $str 源字符串
         * @return (Boolean) 如果源字符串含有中文字符则返回true，否则返回false
         * */
        public static function hasChinese($str:String):Boolean
        {
            if ($str != null)
            {
                //str = trim(str);    //消除两边空格 
                var re:RegExp = /[^\x00-\xff]/;
                var obj:Object = re.exec($str);
                if (obj != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        /**
         * 提取中中文字符组成纯中文字符串
         * @param $str 源字符串
         * @return (String) 提取后的纯中文字符串
         * */
        public static function getChinese($str:String):String
        {
            var str:String = "";
            var re:RegExp = /[^\x00-\xff]/;
            var r:Array = $str.split("");
            for each (var s:String in r)
            {
                var t:String = re.exec(s);
                if (t != null)
                {
                    str += t;
                }
            }
            return str;
        }

        /**
         * 消除双换行符
         * @param $str 源字符串
         * @return (String) 新字符串
         * */
        public static function enterStr(str:String):String
        {
            return str.replace(/\r\n/gm, "\n");
        }



        /**
         * 获取两个字符串之间的字符串
         * @param $str 源字符串
         * @param $before 前面的指定字符串
         * @param $after 后面的指定字符串
         * @return (String) 之间的字符串
         * */
        public static function getBetween($str:String, $before:String, $after:String):String
        {
            var s:String = "";
            if (($str.split($before).length - 1) == 1)
            {
                if (($str.split($after).length - 1) == 1)
                {
                    s = ($str.split($before)[1]).split($after)[0];
                }
            }
            return s;
        }

        /**
         * 在一个字符串中删除所有指定的字符串
         * @param $str 源字符串
         * @param $target 指定要删除的字符串
         * @return (String) 删除后得到的新字符串
         * */
        public static function deleteAll($str:String, $target:String):String
        {
            return $target.replace(/^\s*|\s*$/g, "").split($str).join("");
        }

        /**
         * 有多少个中文字符
         * @param $str 源字符串
         * @param (int) 中文字符的个数
         * */
        public static function chineseAmount($str:String):int
        {
            var str:String = "";
            var re:RegExp = /[^\x00-\xff]/;
            var r:Array = $str.split("");
            for each (var s:String in r)
            {
                var t:String = re.exec(s);
                if (t != null)
                {
                    str += t;
                }
            }
            return str.length; //中文字符串
        }

        /**
         * 有多少个非中文字符
         * @param $str 源字符串
         * @param (int) 中文字符的个数
         * */
        public static function englishAmount($str:String):int
        {
            var str:String = "";
            var re:RegExp = /[^\x00-\xff]/;
            var r:Array = $str.split("");
            for each (var s:String in r)
            {
                var t:String = re.exec(s);
                if (t != null)
                {
                    str += t;
                }
            }
            return $str.length - str.length;
        }

        /**
         * 中文字符串转换为拼音函数
         * @param $str 要转为拼音的中文字符串
         * @return (String) 转换后的拼音字符串
         * */
        public static function chinese2Py($str:String):String
        {
            return HanziToPinyin.toPinyin($str);
        }

        /**
         * 纯单种闭合标识符分割字符串(非嵌套关系)
         * 把形如"(a)(b)(c)"的字符串转换为数组对象[a, b, c]
         * @param $str 源字符串
         * @param start 指定开始字符
         * @param end 指定末尾字符
         * @param tag 是否带着原标识符,true表示带(如[(a), (b), (c)])，false表示不带(如[a, b, c])
         * @return (Array) 返回标准数组对象
         * */
        public static function biheArr($str:String, $start:String, $end:String, $tag:Boolean):Array
        {
            var arr:Array = [];
            var r:Array = $str.split($end);
            var n:int = r.length;
            var i:int = 0;
            if ($tag)
            {
                while (i < n - 1)
                {
                    arr[i] = $start + r[i].replace($start, "") + $end;
                    i++;
                }
            }
            else
            {
                while (i < n - 1)
                {
                    arr[i] = r[i].replace($start, "");
                    i++;
                }
            }
            return arr;
        }

        /**
         * <bb><cc><aa>dd<ee><ff>  ==>  <bb>,<cc>,<aa>,dd,<ee>,<ff>
         * 复杂单种闭合标识符分割字符串(非嵌套关系)
         * 把形如"abc(def)gh(hi)"的字符串转换为数组对象[def, hi]
         * @param $str 源字符串
         * @param start 指定开始字符
         * @param end 指定末尾字符
         * @return (Array) 返回标准数组对象
         * */
        public static function bihe2Arr($str:String, $start:String, $end:String, $tag:Boolean):Array
        {
            var arr:Array = [];
            var temp:String = $str;
            var r:Array = $str.split($end);
            var n:int = r.length;
            var i:int = 0;
            while (i < n - 1)
            {
                var a3:Array = r[i].split($start);
                var s3:String = $start + a3[a3.length - 1] + $end;
                var r3:Array = temp.split(s3);
                var t3:String = r3[0];
                if (t3 != "")
                {
                    arr.push(t3);
                }
                arr.push(s3);
                temp = temp.replace(t3 + s3, "");
                i++;
            }
            var se:String = r[n - 1];
            if (se != "")
            {
                arr.push(se);
            }
            if (!$tag)
            {
                var j:int = 0;
                for each (var str:String in arr)
                {
                    str = str.replace(new RegExp($start, "g"), "");
                    str = str.replace(new RegExp($end, "g"), "");
                    arr[j] = str;
                    j++;
                }
            }
            return arr;
        }

        /**
         * bihe3Arr("a*bc.e<fg>{hij}tp<kmn>", {r1:['<', '>'], r2:['{', '}']}, true);
         * 复杂多种闭合标识符分割字符串(非嵌套关系)
         * @param $str 源字符串
         * @param $obj 闭合部分的标识符
         * @param $tag true  a*bc.e,<fg>,{hij},tp,<kmn>， false a*bc.e,fg,hij,tp,kmn
         * */
        public static function bihe3Arr($str:String, $obj:Object, $tag:Boolean):Array
        {
            var arr:Array = [];
            var arr2:Array = []; //提取出来的闭合字符串
            var n:int = $str.length;
            var i:int = 0;
            var j:int = 1;
            var leftn:int = 0;
            var rightn:int = 0;
            /*提取arr2*/
            while (i < n)
            {
                var s:String = $str.charAt(i);
                for each (var r:Array in $obj)
                {
                    if (s == r[0] || s == r[1])
                    {
                        if (j % 2 == 0)
                        {
                            rightn = i;
                            arr2.push($str.substring(leftn, rightn + 1));
                        }
                        else
                        {
                            leftn = i;
                        }
                        j++;
                    }
                }
                i++;
            }
            var temp:String = $str;
            for each (var s3:String in arr2)
            {
                var s4:String = temp.split(s3)[0];
                if (s4 != "")
                {
                    arr.push(s4);
                }
                arr.push(s3);
                temp = temp.replace(s4 + s3, "");
            }

            if (temp != "")
            {
                arr.push(temp);
            }

            if (!$tag)
            {
                var k:int = 0;
                for each (var s5:String in arr)
                {
                    for each (var r2:Array in $obj)
                    {
                        s5 = s5.replace(new RegExp(r2[0], "g"), "");
                        s5 = s5.replace(new RegExp(r2[1], "g"), "");
                    }
                    arr[k] = s5;
                    k++;
                }
            }
            return arr;
        }

        /**
         * 字符串提取数组
         * 把形如"abc(def)gh(hi)"的字符串转换为数组对象[def, hi]
         * @param $str 源字符串
         * @param start 指定开始字符
         * @param end 指定末尾字符
         * @param tag 是否带着原标识符,true表示带(如[(def), (hi)])，false表示不带(如[def, hi])
         * @return 返回标准数组对象
         * */
        public static function tiquArr($str:String, $start:String, $end:String, $tag:Boolean):Array
        {
            var arr:Array = [];
            var r:Array = $str.split($end);
            var n:int = r.length;
            var i:int = 0;
            if ($tag)
            {
                while (i < n - 1)
                {
                    var r2:Array = r[i].split($start);
                    arr[i] = $start + r2[r2.length - 1] + $end;
                    i++;
                }
            }
            else
            {
                while (i < n - 1)
                {
                    var r3:Array = r[i].split($start);
                    arr[i] = r3[r3.length - 1];
                    i++;
                }
            }
            return arr;
        }

        /**
         * a*bc.e<fg>{hij}<kmn>, r2:['{', '}']}
         * 复杂多种闭合标识符提取字符串(非嵌套关系)
         * @param $str 源字符串
         * @param $obj 闭合部分的标识符
         * @param $tag 是否显示原分割标识符
         * */
        public static function tiqu2Arr($str:String, $obj:Object, $tag:Boolean):Array
        {
            var arr:Array = [];
            var n:int = $str.length;
            var i:int = 0;
            var j:int = 1;
            var leftn:int = 0;
            var rightn:int = 0;
            if ($tag)
            {
                while (i < n)
                {
                    var s:String = $str.charAt(i);
                    for each (var r:Array in $obj)
                    {
                        if (s == r[0] || s == r[1])
                        {
                            if (j % 2 == 0)
                            {
                                rightn = i;
                                arr.push($str.substring(leftn, rightn + 1));
                            }
                            else
                            {
                                leftn = i;
                            }
                            j++;
                        }
                    }
                    i++;
                }
            }
            else
            {
                while (i < n)
                {
                    var t:String = $str.charAt(i);
                    for each (var a:Array in $obj)
                    {
                        if (t == a[0] || t == a[1])
                        {
                            if (j % 2 == 0)
                            {
                                rightn = i;
                                arr.push($str.substring(leftn + 1, rightn));
                            }
                            else
                            {
                                leftn = i;
                            }
                            j++;
                        }
                    }
                    i++;
                }
            }
            return arr;
        }

        /**
         * 更新数组值,每个数组元素统一删除某字符串(如果存在)
         * @param $arr 源数组对象
         * @param ...arr 不定个数参数
         * @reutrn (Array) 新数组对象
         * */
        public static function updateDelArr($arr:Array, ... arg):Array
        {
            var i:int = 0;
            for each (var s:String in $arr)
            {
                for each (var t:String in arg)
                {
                    s = s.replace(new RegExp(t, "g"), "");
                }
                $arr[i] = s;
                i++;
            }
            return $arr;
        }

        /**
         * 解析出数组中的重复元素(由c语言改编)
         * 参数例：[1, 3, 5, 7, 1, 3, 8, "a", "b", "a", -1, -1]
         * @param $r 源数组对象
         * @return (Array) 返回一个数组对象 [重复数组对象, 非重复数据对象]
         * */
        public static function getRepeatArr($r:Array):Array
        {
            var repeat:Array = []; //记录重复的元素
            var noRepeat:Array = []; //记录没有重复的元素
            var f:String = ""; //设定一个标识符(任意值)，要确保此值不和源数组中的任何元素相同
            var m:int = 0;
            var n:int = $r.length;
            var i:int = -1;
            for each (var a:* in $r)
            {
                i++;
                m = 1;
                if (a == f)
                {
                    continue;
                }
                var j:int = i + 1;
                while (j < n)
                {
                    if (a == $r[j])
                    {
                        m++;
                        $r[j] = f;
                    }
                    j++;
                }
                if (m > 1)
                {
                    repeat.push(a);
                }
                else if (m == 1)
                {
                    noRepeat.push(a);
                }
            }
            return [repeat, noRepeat];
        }

        /**
         * 字符串替换方法
         * @param str
         * @param rest
         * @example
         *	<listing version="3.0">
         //把{0},{1}替换成参数列表里的值
         var alertStr:String = "购买{0}个物品需要{1}个xxx";
         var str:String = substituteStr(alertStr:String,5,66)
         trace(str)//购买5个物品需要6个xxx
         *	</listing>
         * @return
         *
         */
        public static function substituteStr(str:String, ... rest):String
        {
            if (str == null)
                return '';
            var len:uint = rest.length;
            var args:Array;
            if (len == 1 && rest[0] is Array)
            {
                args = rest[0] as Array;
                len = args.length;
            }
            else
            {
                args = rest;
            }
            for (var i:int = 0; i < len; i++)
            {
                str = str.replace(new RegExp("\\{" + i + "\\}", "g"), args[i]);
            }
            return str;
        }
        /**
         * 传入的字符串是否为空
         * 【常用于用户输入的检测】
         * */
        public static function isWhitespace(ch:String):Boolean
        {
            return ch == '\r' || ch == '\n' || ch == '\f' || ch == '\t' || ch == ' ' || ch == '' || ch == '　';
        }

        /**　语句首字母大写处理  */
        public static function toTitleCase(original:String):String
        {
            var words:Array = original.split(" ");
            for (var i:int = 0; i < words.length; i++)
            {
                words[i] = toInitialCap(words[i]);
            }
            return (words.join(" "));
        }

        /**　首字母大写处理  */
        public static function toInitialCap(original:String):String
        {
            return original.charAt(0).toUpperCase() + original.substr(1).toLowerCase();
        }

        /** 移除文件扩展名*/
        public static function removeExtension(filename:String):String
        {
            var extensionIndex:Number = filename.lastIndexOf('.');
            if (extensionIndex == -1)
            {
                return filename;
            }
            else
            {
                return filename.substr(0, extensionIndex);
            }
        }

        /** 获取文件扩展名*/
        public static function extractExtension(filename:String):String
        {
            var extensionIndex:Number = filename.lastIndexOf('.');
            if (extensionIndex == -1)
            {
                return "";
            }
            else
            {
                return filename.substr(extensionIndex + 1, filename.length);
            }
        }


        //URL地址;   
        public static function isURL(char:String):Boolean
        {
            if (char == null)
            {
                return false;
            }
            char = trim(char).toLowerCase();
            var pattern:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
            var result:Object = pattern.exec(char);
            if (result == null)
            {
                return false;
            }
            return true;
        }

        /**
         * 获取url中的文件名
         * @param url
         * @return
         *
         */
        public static function getFileName(url:String):String
        {
            var sindex:int = url.indexOf("?");
            if (sindex == -1)
            {
                sindex = int.MAX_VALUE;
            }
            var index1:int = url.lastIndexOf(".", sindex);
            var index2:int = url.lastIndexOf("/") + 1;
            return url.substring(index2, index1);
        }

        /**
         * 十进制数字转为IP地址格式 127.0.0.1
         * @param a
         * @return
         *
         */
        public static function uintToIp(v:uint):String
        {
            var str:String = v.toString(16);
            var ip1:String = uint(HEX_Head + str.slice(0, 2)).toString();
            var ip2:String = uint(HEX_Head + str.slice(2, 4)).toString();
            var ip3:String = uint(HEX_Head + str.slice(4, 6)).toString();
            var ip4:String = uint(HEX_Head + str.slice(6)).toString();
            return ip1 + DOT + ip2 + DOT + ip3 + DOT + ip4;
        }


        /**
         * 去掉左边空格
         * @param input
         * @return
         *
         */
        public static function leftTrim(char:String):String
        {
            if (char == null)
            {
                return "";
            }
            var pattern:RegExp = /^\s*/;
            return char.replace(pattern, "");
        }

        /**
         * 去掉右边空格
         * @param input
         * @return
         *
         */
        public static function rightTrim(char:String):String
        {
            if (char == null)
            {
                return "";
            }
            var pattern:RegExp = /\s*$/;
            return char.replace(pattern, "");
        }

        /**
         * 替换指定序列的字符串
         * @param $index 指定要替换的字符串的序号
         * @param $str 源字符串
         * @param $old 要被替换的字符串
         * @param $new 要替换的新字符串
         * */
        public static function replaceAt($index:int, $str:String, $old:String, $new:String):String
        {
            if ($str.indexOf($old) != -1)
            {
                var str:String = "";
                var arr:Array = $str.split($old);
                var n:int = arr.length; //($index(max) = n - 1)
                if ($index < n - 1)
                {
                    var i:int = 0;
                    var s:String;
                    for each (s in arr)
                    {
                        if (i != $index)
                        {
                            if (i != n - 1)
                            { //不是最后一项
                                str += s + $old;
                            }
                            else
                            {
                                if (s != "")
                                { //老字符串是否在最后
                                    str += s;
                                }
                            }
                        }
                        else
                        {
                            str += s + $new;
                        }
                        i++;
                    }
                    return str;
                }
                else
                {
                    return $str;
                }
            }
            else
            {
                return $str;
            }
        }



        public static function removeWhitespace(original:String):String
        {
            var characters:Array = original.split("");

            for (var i:int = 0; i < characters.length; i++)
            {
                if (isWhitespace(characters[i]))
                {
                    characters.splice(i, 1);
                    i--;
                }
            }
            for (i = characters.length - 1; i >= 0; i--)
            {
                if (isWhitespace(characters[i]))
                {
                    characters.splice(i, 1);
                }
            }

            return characters.join("");
        }

        /**
         * 格式数字秒表类型输出 00:00
         * @param value
         * @param length
         * @return
         *
         */
        public static function stopwatchFormat(value:int):String
        {
            var minute:int = value / 60;
            var second:int = value % 60;
            var strM:String = (minute < 10) ? ("0" + minute.toString()) : minute.toString();
            var strS:String = (second < 10) ? ("0" + second.toString()) : second.toString();
            return strM + ":" + strS;
        }

        /**
         * 日期格式
         * @param value 时间
         * @param sm    格式间隔符
         * @return
         *
         */
        public static function timeFormat(value:int, sm:String = "-"):String
        {
            var t:Date = new Date(value * 1000);
            return t.getFullYear().toString() + sm + (t.getMonth() + 1).toString() + sm + t.getDate().toString();
        }

        /**
         * 十六进制数字转为IP地址格式
         * @param a
         * @return
         *
         */
        public static function hexToIp(a:uint):String
        {
            var bytes:ByteArray = new ByteArray();
            bytes.writeUnsignedInt(a);
            bytes.position = 0;
            var str:String = "";
            for (var i:uint = 0; i < 4; i++)
            {
                str += bytes.readUnsignedByte().toString() + DOT;
            }
            return str.substr(0, str.length - 1);
        }

        /**
         * IP地址格式转为十进制数字
         * @return i
         *
         */
        public static function ipToUint(i:String):uint
        {
            var arr:Array = i.split(DOT);
            var str:String = HEX_Head;

            for each (var item:String in arr)
            {
                str += uint(item).toString(16);
            }
            return uint(str);
        }

        /**
         * ip地址转字节数组
         * @param i
         * @return
         *
         */
        public static function ipToBytes(i:String, endian:String = null):ByteArray
        {
            var arr:Array = i.split(".");
            var bytes:ByteArray = new ByteArray();
            if (endian != null && endian != "")
            {
                bytes.endian = endian;
            }
            for each (var item:String in arr)
            {
                bytes.writeByte(uint(item));
            }
            return bytes;
        }

        /**
         * 对比两个字符串
         * @param s1
         * @param s2
         * @param caseSensitive 是否区分大小写
         * @return
         *
         */
        public static function stringsAreEqual(s1:String, s2:String, caseSensitive:Boolean):Boolean
        {
            if (caseSensitive)
            {
                return (s1 == s2);
            }
            else
            {
                return (s1.toUpperCase() == s2.toUpperCase());
            }
        }

        /**
         * 去掉两边空格
         * @param input
         * @return
         *
         */
        public static function trim(char:String):String
        {
            if (char == null)
            {
                return "";
            }
            return rightTrim(leftTrim(char));
        }


        /**
         * 一个字符串从开头起是否有指定的字符串
         * @param input
         * @param prefix
         * @return
         *
         */
        public static function beginsWith(input:String, prefix:String):Boolean
        {
            return (prefix == input.substring(0, prefix.length));
        }

        /**
         * 一个字符串从结尾起是否有指定的字符串
         * @param input
         * @param suffix
         * @return
         *
         */
        public static function endsWith(input:String, suffix:String):Boolean
        {
            return (suffix == input.substring(input.length - suffix.length));
        }

        /**
         * 移除字符串中指定的字符串
         * @param input
         * @param remove
         * @return
         *
         */
        public static function remove(input:String, remove:String):String
        {
            return StringUtil.replace(input, remove, "");
        }


        public static function replace(input:String, replace:String, replaceWith:String):String
        {
            return input.split(replace).join(replaceWith);
        }

        public static function stringHasValue(s:String):Boolean
        {
            return (s != null && s.length > 0);
        }

        /**
         * 将字符串转化为字节数组
         * @param s
         * @param length
         * @return
         *
         */
        public static function toByteArray(s:String, length:uint):ByteArray
        {
            var bytes:ByteArray = new ByteArray();
            bytes.writeUTFBytes(s);
            bytes.length = length;
            bytes.position = 0;
            return bytes;
        }

        //注册字符;   
        public static function hasAccountChar(char:String, len:uint = 15):Boolean
        {
            if (char == null)
            {
                return false;
            }
            if (len < 10)
            {
                len = 15;
            }
            char = trim(char);
            var pattern:RegExp = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0," + len + "}$", "");
            var result:Object = pattern.exec(char);
            if (result == null)
            {
                return false;
            }
            return true;
        }

        /**
         * utf16转utf8编码;
         * @param char
         * @return
         *
         */
        public static function utf16to8(char:String):String
        {
            var out:Array = new Array();
            var len:uint = char.length;
            for (var i:uint = 0; i < len; i++)
            {
                var c:int = char.charCodeAt(i);
                if (c >= 0x0001 && c <= 0x007F)
                {
                    out[i] = char.charAt(i);
                }
                else if (c > 0x07FF)
                {
                    out[i] = String.fromCharCode(0xE0 | ((c >> 12) & 0x0F), 0x80 | ((c >> 6) & 0x3F), 0x80 | ((c >> 0) & 0x3F));
                }
                else
                {
                    out[i] = String.fromCharCode(0xC0 | ((c >> 6) & 0x1F), 0x80 | ((c >> 0) & 0x3F));
                }
            }
            return out.join('');
        }

        /**
         * utf8转utf16编码;
         * @param char
         * @return
         *
         */
        public static function utf8to16(char:String):String
        {
            var out:Array = new Array();
            var len:uint = char.length;

            var i:uint = 0;
            while (i < len)
            {
                var c:int = char.charCodeAt(i++);
                switch (c >> 4)
                {
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                        // 0xxxxxxx   
                        out[out.length] = char.charAt(i - 1);
                        break;
                    case 12:
                    case 13:
                        // 110x xxxx   10xx xxxx   
                        var char1:int = char.charCodeAt(i++);
                        out[out.length] = String.fromCharCode(((c & 0x1F) << 6) | (char1 & 0x3F));
                        break;
                    case 14:
                        // 1110 xxxx  10xx xxxx  10xx xxxx   
                        var char2:int = char.charCodeAt(i++);
                        var char3:int = char.charCodeAt(i++);
                        out[out.length] = String.fromCharCode(((c & 0x0F) << 12) | ((char2 & 0x3F) << 6) | ((char3 & 0x3F) <<
                            0));
                        break;
                }
            }
            return out.join('');
        }
    }
}
