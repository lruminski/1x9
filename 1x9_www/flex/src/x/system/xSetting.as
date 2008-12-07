package x.system
{
	public class xSetting
	{
		
   		private static var setting:xSetting;

        // Return a singleton instance of our setting
        public static function getInstance():xSetting {
            if (setting == null) {
                setting = new xSetting();
            }

            return setting;
        }

        public function xSetting() {
            if (setting != null) {
                throw new Error("Only one setting instance should be instantiated");
            }
        }

	}
}