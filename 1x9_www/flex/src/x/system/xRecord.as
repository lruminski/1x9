package x.system
{
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import org.amqp.patterns.CorrelatedMessageEvent;
    
    import x.lib.Network;

    public class xRecord
    {
        public var conn:Network;
        public var type:String;

        public var obj:Object;
        
        private var interval:Timer;
        private var callback:Function;

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
        	if (this.obj.id > 0)
        	{        	
	        	callback = setDefaultCallback(callback, doNothing);
	            conn.serv.send(type, "show", obj, callback)
	       	} else {
	       		interval = new Timer(250, 5);
	       		interval.addEventListener(TimerEvent.TIMER, reShow);
	       		this.callback = callback;
	       		interval.start();
	       	}
        }
        
        private function reShow(event:TimerEvent):void
        {        	
        	if (this.obj.id > 0) {
        		interval.stop();
	        	show(callback);	        	        	
        	}
        }

        public function save(callback:Function):void
        {
            callback = setDefaultCallback(callback, doNothing);
            conn.serv.send(type, "save", obj, callback)
        }

        public function update(callback:Function):void
        {
            callback = setDefaultCallback(callback, saveResult);
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
            else
            {
            	trace("ohh ohh");
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