
package x.lib
{
    import org.amqp.Connection;
    import org.amqp.patterns.impl.PublishClientImpl;
    import org.amqp.patterns.impl.SubscribeClientImpl;

    public class EnvClient {
        private var pub:PublishClientImpl;
        private var sub:SubscribeClientImpl;

        public function EnvClient(conn:Connection) {
            // Initiate the subscribe client to the game exchange
            sub = new SubscribeClientImpl(conn);
            sub.serializer = new JSONSerializer();
            sub.exchange = "env";
            sub.exchangeType = "topic";

            // Initiate the publish client to the game exchange
            pub = new PublishClientImpl(conn);
            pub.serializer = new JSONSerializer();
            pub.exchange = "env";
            pub.exchangeType = "topic";
        }

        public function getReplyQueue():String {
            return sub.replyQueue;
        }

        // Subscribes to a room
        public function subscribe(key:String, callback:Function):void {
        	trace ("subscribing to " + key);
            sub.subscribe(key, callback);
        }

        // Unsubscribes from a room
        public function unsubscribe(key:String):void {
            sub.unsubscribe(key);
        }

        // Publishes an object to a room
        public function publish(key:String, o:Object):void {
            pub.send(key, o);
        }

    }
}