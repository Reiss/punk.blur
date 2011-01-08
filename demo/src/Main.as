package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Reiss
	 */
	[SWF(width = "640", height = "480")]
	
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(320,240);
			FP.screen.scale = 2.0;
			FP.world = new BlurLevel();
		}
	}
	
}