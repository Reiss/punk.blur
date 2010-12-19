package punk.blur
{
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Reiss
	 */
	public class MotionBlur extends Entity
	{
		//screen size and location
		private var _screenRect:Rectangle = new Rectangle(0, 0, FP.width, FP.height); 
		private var _screenPoint:Point = new Point();
		//screen-sized pre-processing buffer -- same color as screen
		private var _preprocess:BitmapData = new BitmapData(FP.width, FP.height, false, FP.screen.color);
		//screen-sized bitmap overlay -- same color as screen
		private var _overlay:BitmapData = new BitmapData(FP.width, FP.height, true, FP.screen.color);
		
		
		public function MotionBlur(blurFactor:Number)
		{
			//set the transparency for the overlay
			var alpha:ColorTransform = new ColorTransform(1, 1, 1, 1.0 - blurFactor); //subtract blur from one, so that higher blur = more blurring
			_overlay.colorTransform(_screenRect, alpha);
		}
		
		//register an entity as casting bloom lighting
		public function register(g:BlurWrapper):void
		{
			g.blurCanvas = _preprocess;
		}
		
		//unregister and entity as casting bloom lighting
		public function unregister(g:BlurWrapper):void
		{
			g.blurCanvas = null;
		}
		
		//returns the bloom canvas, in case you want to draw to it without using a bloom wrapper
		public function get buffer():BitmapData
		{
			return _preprocess;
		}
		
		override public function render():void
		{
			_preprocess.draw(_overlay, null, null, BlendMode.NORMAL);
			super.render();
			FP.buffer.draw(_preprocess);
		}
	}

}