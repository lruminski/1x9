package x.system
{
    import org.amqp.patterns.CorrelatedMessageEvent;

    import x.lib.Network;

    public class xRecord
    {
        public var conn:Network;
        public var type:String;

        public var obj:Object;

        public function xRecord(id:int = -1, type:String = "entry")
        {
            conn = Network.getInstance();
            this.type = type;
            obj = new Object();
            obj.id = id;
        }

        public function set id(id:int):void
        {
            obj.id = id;
            conn.serv.send(type, "set", obj, result)
        }

        public function get id():int {
            if (obj.id) {
                return obj.id;
            } else {
                conn.serv.send(type, "get", obj, result)
                return -1;
            }
        }

        public function save(callback:Function):void
        {
            conn.serv.send(type, "save", obj, callback)
        }

        public function find(obj:Object, callback:Function):void
        {
            trace("find:" + obj);
            conn.serv.send(type, "find", obj, callback)
        }

        public function doNothing(event:CorrelatedMessageEvent):void
        {
            // nothing
        }

        public function saveResult(event:CorrelatedMessageEvent):void
        {
            var result:Object = event.result;
            if (result != null) {

                obj = result.result;
            }

        }


    }
}