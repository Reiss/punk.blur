package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.CircularMotion;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.Tween;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author Reiss
	 */
	public class Particle extends Entity
	{
		/* motion and timing constants */
		private static const WIDTH:Number = 16;
		private static const HEIGHT:Number =  16;
		private static const DIAGONAL:Number = FP.distance(0, WIDTH, WIDTH, 0); //length of the diagonal of the square
		private static const MIN_MOTION_TIME:Number = 4.0;
		private static const MAX_ADDITIONAL_MOTION_TIME:Number = 2.0;
		private static const MIN_ROTATION_TIME:Number = 2.0;
		private static const MAX_ADDITIONAL_ROTATION_TIME:Number = 2.0;
		
		/* motion and image data */
		private var _motion:LinearMotion;
		private var _rotation:CircularMotion;
		private var _image:Image;
		
		public function Particle() 
		{
			//initialize to a random location at the bottom of the screen
			super(FP.random * (FP.width - WIDTH), FP.height + DIAGONAL);
			
			_image = Image.createRect(WIDTH, HEIGHT);
			graphic = new BlurWrapper(_image);
			
			//move via linear motion tween. when it gets off the screen boundaries, call recycle()
			_motion = new LinearMotion(recycle, Tween.LOOPING);
			_motion.setMotion(x, y, x, -DIAGONAL, MIN_MOTION_TIME + FP.random*MAX_ADDITIONAL_MOTION_TIME, Ease.cubeIn);
			addTween(_motion);
			
			//rotate via circular motion tween
			_rotation = new CircularMotion(null, Tween.LOOPING);
			_rotation.setMotion(0, 0, WIDTH/2,0, true, MIN_ROTATION_TIME + FP.random*MAX_ADDITIONAL_ROTATION_TIME);
			addTween(_rotation);
			
			//center the image origin, so the image rotates around the center of the entity
			_image.centerOO();
		}
		
		override public function update():void
		{
			super.update();
			//set the angle and the location
			_image.angle = FP.angle(0, 0, _rotation.x, _rotation.y);
			y = _motion.y;
		}
		
		//recyclyes the entity, and moves it back to a random location on the bottom of the screen
		public function recycle():void
		{
			FP.world.recycle(this);
			y = 0;
			x = FP.random * (FP.width - WIDTH);
		}
	}

}