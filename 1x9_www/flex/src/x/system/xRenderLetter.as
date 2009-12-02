package x.system
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	
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
			TweenMax.to(this, garbage_time, {z:-5000, alpha:0, delay:garbage_delay, onComplete:deleteMe, ease:Quad.easeInOut});
		}
		
		
		public function deleteMe():void
		{
			
		}
		

	}
}