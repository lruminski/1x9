package x.system
{
    import flash.events.ErrorEvent;

    public class xError
    {

        private static var error:xError;

        private var console:xConsole;


        // Return a singleton instance of our network adapter
        public static function getInstance():xError {
            if (error == null) {
                error = new xError();
            }
            return error;
        }

        public function setErrorConsole(console:xConsole):void
        {
            this.console = console
        }

        public function xError()
        {
            if (error != null) {
                throw new Error("Only one network instance should be instantiated");
            }
        }

        public function display(error_str:String):void
        {
            console.screen.showError(error_str);
        }

        public function handleError(error:ErrorEvent):void
        {
            display(error.text);
        }

    }
}