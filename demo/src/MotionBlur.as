package
{
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.geom.Matrix;
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
		private var _screenRect:Rectangle; 
		private var _translationMatrix:Matrix = new Matrix();
		//screen-sized transparent pre-processing buffer
		private var _preprocess:BitmapData;
		//alpha transform for motion blur trails
		private var _alphaTransform:ColorTransform;
		//camera point to track -- defaults to FP.camera
		public var camera:Point = FP.camera;
		private var _oldCamera:Point = new Point(camera.x, camera.y);
		
		public function MotionBlur(blurFactor:Number, screenWidth:int = -1, screenHeight:int = -1)
		{
			_screenRect = new Rectangle(0, 0, screenWidth < 0 ? FP.width : screenWidth, screenHeight < 0 ? FP.height : screenHeight)
			_preprocess = new BitmapData(_screenRect.width, _screenRect.height, true, 0);
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
			//move the preprocessing buffer by the camera amount
			//_preprocess.scroll(_oldCamera.x - camera.x, _oldCamera.y - camera.y);
			super.render();
			(renderTarget ? renderTarget : FP.buffer).draw(_preprocess);
			
			//save camera coords
			syncCamera();
		}
		
		private function syncCamera():void
		{
			_oldCamera.x = camera.x;
			_oldCamera.y = camera.y;
		}
		
		public function reset():void
		{
			syncCamera();
			_preprocess.fillRect(_screenRect, 0);
		}
	}

}