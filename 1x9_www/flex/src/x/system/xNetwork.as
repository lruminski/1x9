package x.system
{
    import flash.events.ErrorEvent;
    
    import org.amqp.patterns.CorrelatedMessageEvent;
    
    import x.lib.Network;

    public class xNetwork
    {
        private var comm:Network;
        private var session_id:String;
        private var screen:xScreen;

        public function xNetwork(session_id:String, screen:xScreen)
        {
            comm = Network.getInstance();
            comm.addEventListener(Network.NETWORK_ERROR, handleError);

            this.session_id = session_id;
            this.screen = screen;
        }

        public function init():void
        {
            //comm.connect("guest", "guest", "/", "127.0.0.1");
            //comm.connect("guest", "guest", "/", "192.168.3.32");
            comm.connect("guest", "guest", "/", "dev.1x9.ca");
            comm.authenticate(session_id, onAuthenticate);
        }

        private function onAuthenticate(event:*):void
        {
            var result:* = event.result.result;

            if (result) {
            	trace("authenticated");
                comm.serv.setToken(result.token);
	            comm.subscribe("user", session_id, onPersonalConsume);
            }else {
            	trace("connection failed");
                var error:xError = xError.getInstance();
                error.display("RPC Connection Failed");
            }
        }

        private function onPersonalConsume(event:org.amqp.patterns.CorrelatedMessageEvent):void
        {
            var result:Object;
            result = event.result

            if (result != null) {
                screen.handleAction(result);
            }
        }

        private function handleError(error:ErrorEvent):void
        {

            screen.showError(error.text);
        }
    }
}