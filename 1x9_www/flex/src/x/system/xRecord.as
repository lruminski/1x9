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
            conn.serv.send(type, "set", obj, saveResult)
        }

        public function get id():int {
            if (obj.id) {
                return obj.id;
            } else {
                conn.serv.send(type, "get", obj, saveResult)
                return -1;
            }
        }

        public function show(callback:Function):void
        {
        	callback = setDefaultCallback(callback, doNothing);
            conn.serv.send(type, "show", obj, callback)
        }

        public function save(callback:Function):void
        {
            callback = setDefaultCallback(callback, doNothing);
            conn.serv.send(type, "save", obj, callback)
        }

        public function update(callback:Function):void
        {
            callback = setDefaultCallback(callback, doNothing);
            conn.serv.send(type, "update", obj, callback);
        }


        public function find(obj:Object, callback:Function):void
        {
            callback = setDefaultCallback(callback, doNothing);
            conn.serv.send(type, "find", obj, callback)
        }

        public function doNothing(event:CorrelatedMessageEvent):void
        {
            // even nothing is something
        }

        public function saveResult(event:CorrelatedMessageEvent):void
        {
            var result:Object = event.result;
        	trace ("saveResult[:" + type + "]");


        	 
        	if (result != null) {
        		//var tmp:Array = result.result;
        	
                obj = result.result;
	        	for (var key:String in obj) {
	        		 trace ("  " + key + " => " + obj[key]);
	        	}
            }

        }
        
        private function setDefaultCallback(callback:Function, method:Function):Function
        {
        	if (callback == null)
        	{
        		callback = method;
        	}
        	return callback;
        }
        


    }
}