package x.lib
{
    import org.amqp.Connection;
    import org.amqp.patterns.CorrelatedMessageEvent;
    import org.amqp.patterns.impl.SubscribeClientImpl;

    public class PresenceClient {
        // Escape characters to replace when parsing the queue name
        // from a presence notification
        public static const QUEUE_ESCAPE:Array = [
            ["#", "%23"],
            ["%", "%25"],
            ["*", "%2a"],
            [".", "%2e"]
        ];

        private var presence:SubscribeClientImpl;
        private var appCallback:Function;

        // Open connection to the reserved presence exchange
        public function PresenceClient(conn:Connection) {
            presence = new SubscribeClientImpl(conn);
            presence.serializer = new JSONSerializer();
            presence.exchange = "amq.rabbitmq.presence";
            presence.exchangeType = "topic";
            presence.reservedExchange = true;
        }

        // Subscribe and setup a callback function for presence messages
        public function listen(callback:Function):void {
            appCallback = callback;
            presence.subscribe("presence.queue.*.shutdown", queueShutdown);
        }

        // Callback the presence consumer function and pass queue that shutdown
        public function queueShutdown(event:CorrelatedMessageEvent):void {
            appCallback.call(null, parseQueue(event.method.routingkey));
        }

        // Parse the queue name using QUEUE_ESCAPE
        private function parseQueue(q:String):String {
            var queue:String = null;

            try {
                queue = q.split(".")[2];
                for each (var esc:Array in QUEUE_ESCAPE) {
                    queue = queue.replace(esc[1], esc[0]);
                }
            } catch (e:Error) { }

            return queue;
        }
    }
}