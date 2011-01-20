package  
{
	import flash.display.Bitmap;
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
		private var _preprocess:BitmapData = new BitmapData(FP.width, FP.height, true, 0);
		//alpha transforms for motion blur trails
		private var _alphaTransform:ColorTransform;
		
		public function MotionBlur(blurFactor:Number)
		{
			//set the fade for motion blur trails
			_alphaTransform = new ColorTransform(1, 1, 1, blurFactor);
		}
		
		//accessors for blur factor
		public function get blurFactor():Number
		{
			return _alphaTransform.alphaMultiplier;
		}
		public function set blurFactor(blur:Number):void
		{
			_alphaTransform.alphaMultiplier = blur;
		}
		
		//returns the bloom canvas, in case you want to draw to it without using a bloom wrapper
		public function get buffer():BitmapData
		{
			return _preprocess;
		}
		
		override public function render():void
		{
			_preprocess.colorTransform(_screenRect, _alphaTransform);
			super.render();
			(renderTarget ? renderTarget : FP.buffer).draw(_preprocess);
		}
	}

}