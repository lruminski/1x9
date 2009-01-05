package x.system
{
	import mx.controls.Text;
	
	public class xRenderLetter extends Text
	{
		
		public var garbage_time:Number = 1000;
		public var garbage_delay:Number = 0;
		
		public function xRenderLetter()
		{
		}
		
		public function garbage():void
		{
			
			Tweener.addTween(this, {z:-5000, alpha:0, time:garbage_time, delay:garbage_delay, onComplete:deleteMe, transition:"easeInOutQuad"});
			
		}
		
		
		public function deleteMe():void
		{
			
		}
		

	}
}