package x.lib
{
    import org.amqp.Connection;
    import org.amqp.patterns.impl.RpcClientImpl;

    public class ServClient {
        // Timeout a RPC call after X/1000 seconds
        private static const TIMEOUT:int = 6000;

        private var rpc:RpcClientImpl;
        private var sessionKey:String = null;
        private var token:String = null;

        public function ServClient(conn:Connection) {
            rpc = new RpcClientImpl(conn);
            rpc.serializer = new JSONSerializer();
            rpc.exchange = "directx";
            rpc.exchangeType = "direct";
            rpc.routingKey = "serv";
        }

        // Set the client session id
        public function setSessionKey(sessionKey:String):void {
            this.sessionKey = sessionKey;
        }

        // Get the client session id
        public function getSessionKey():String {
            return sessionKey;
        }

        // Set the server-generated authentication token
        public function setToken(token:String):void {
            this.token = token;
        }

        // Get the server-generated authentication token
        public function getToken():String {
            return token;
        }

        // Get the ServClient queue identifier
        public function getReplyQueue():String {
            return rpc.replyQueue;
        }

        public function send(controller:String, action:String, params:*, callback:Function):void {
        	
            rpc.send({
                session_id:sessionKey,
                controller:controller,
                action:action,
                params:params
            }, callback, TIMEOUT);
        }

        // TIMEOUT seconds
        public function addTimeoutHandler(callback:Function):void {
            rpc.addTimeoutHandler(callback);
        }
    }
}