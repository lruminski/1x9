package x.lib
{
    import flash.events.ErrorEvent;
    import flash.events.EventDispatcher;
    
    import org.amqp.Connection;
    import org.amqp.ConnectionParameters;
    import org.amqp.error.ConnectionError;

    public class Network extends EventDispatcher {
        public static const USERS_TOPIC:String = "users";
        public static const NETWORK_ERROR:String = "error";

        private static var network:Network;

        public var world:String;

        private var connState:ConnectionParameters;
        private var conn:Connection;

        public var env:EnvClient;
        public var serv:ServClient;
        public var pres:PresenceClient;



        // Return a singleton instance of our network adapter
        public static function getInstance():Network {
            if (network == null) {
                network = new Network();
            }

            return network;
        }

        public function Network() {
            if (network != null) {
                throw new Error("Only one network instance should be instantiated");
            }
        }

        // Connect to an AMQP broker
        public function connect(username:String, password:String, vhostpath:String, serverhost:String):void {
            connState = new ConnectionParameters();
            connState.username = username;
            connState.password = password;
            connState.vhostpath = vhostpath;
            connState.serverhost = serverhost;

            conn = new Connection(connState);
            conn.addSocketEventListener(ConnectionError.CONNECTION_ERROR, errorHandler);

            serv = new ServClient(conn);
            env = new EnvClient(conn);
            pres = new PresenceClient(conn);

            serv.addTimeoutHandler(errorHandler);
        }

        // Disconnect from the broker
        public function disconnect():void {
            conn.close();
        }

        // Catch any socket errors and persent them to the user
        public function errorHandler(e:ErrorEvent):void {
            this.dispatchEvent(e);
            //ApplicationError.show(e.text);
        }

        // Authenticate the session key provided by the browser using ServClient
        public function authenticate(sessionKey:String, callback:Function):void {
            serv.setSessionKey(sessionKey);
            serv.send("users", "authenticate", null, callback);
        }

        // Is communication successfully connected?
        public function get isConnected():Boolean {
            return conn.isConnected();
        }

        // Get the ServClient queue identifier
        public function getQueue():String {
            return serv.getReplyQueue();
        }

        // Subscribe to a topic
        public function subscribe(topic:String, key:*, callback:Function):void {
            env.subscribe(topic+"."+key.toString(), callback);
        }

        // Unsubscribe from a topic
        public function unsubscribe(topic:String, key:*):void {
            env.unsubscribe(topic+"."+key.toString());
        }

        // Publish data to a specific topic
        public function publish(topic:String, key:*, o:*):void {
            env.publish(topic+"."+key.toString(), o);
        }

        // Setup a listener for any presence notification
        public function presence_listen(callback:Function):void {
            pres.listen(callback);
        }
    }
}