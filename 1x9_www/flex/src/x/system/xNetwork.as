package x.system
{
    import flash.events.ErrorEvent;

    import org.amqp.patterns.CorrelatedMessageEvent;

    import x.lib.Network;

    public class xNetwork
    {
        private var comm:Network;
        private var session_id:String;

        public function xNetwork(session_id:String)
        {
            comm = Network.getInstance();
            comm.addEventListener(Network.NETWORK_ERROR, handleError);

            this.session_id = session_id;
        }

        public function init():void
        {
            comm.connect("guest", "guest", "/", "localhost");
            comm.authenticate(session_id, onAuthenticate);
            comm.user_subscribe(session_id, onPersonalConsume);
        }

        private function onAuthenticate(event:*):void
        {
            var result:* = event.result.result;

            if (result) {
                authObj = result;
                comm.serv.setToken(authObj.token);
            }else {
                var error:xError = xError.getInstance();
                error.display("RPC Connection Failed");
            }
        }

        private function onPersonalConsume(event:CorrelatedMessageEvent):void
        {

        }

        private function handleError(error:ErrorEvent):void
        {

            screen.showError(error.text);
        }
    }
}