package  
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Reiss
	 */
	public class BlurLevel extends World
	{
		/* time between particle creation */
		public static const MIN_LAPSED_CREATE_TIME:Number = 0.05;
		public static const MAX_ADDITIONAL_CREATE_TIME:Number = 0.025;
		
		/* amount of motion blur desired */
		private static const BLUR:Number = 0.8;
		
		/* particle timing */
		private var _elapsed:Number = 0.0;
		private var _timeToNextParticle:Number = calcNextParticleTime();
		
		/* motion blur */
		private var _blur:MotionBlur = new MotionBlur(BLUR);
		
		override public function begin():void
		{
			FP.console.enable();
			
			//set the blur to be under the particles, and add it to the world
			_blur.layer = 1;
			add(_blur);
			
			//create and add an initial particle
			_blur.register(create(Particle).graphic as BlurWrapper);
			
			//add some text -- don't bother registering it, since it doesn't move
			var txt:Entity = new Entity();
			var img:Text;
			Text.size = 48;
			txt.graphic = img = new Text("BlurPunk");
			txt.x = FP.width / 2 - img.width / 2;
			txt.y = FP.height / 2 - img.height / 2;
			add(txt);
		}
		
		override public function update():void
		{
			super.update();
			
			/* spawn new particles if enough time has passed */
			if (_elapsed >= _timeToNextParticle)
			{
				_elapsed -= _timeToNextParticle;
				_timeToNextParticle = calcNextParticleTime();
				_blur.register(create(Particle).graphic as BlurWrapper);
			}
			else
				_elapsed += FP.elapsed;
		}
		
		/* returns a random amount of time to wait before spawning a new particle */
		private function calcNextParticleTime():Number
		{
			return MIN_LAPSED_CREATE_TIME + (FP.random * MAX_ADDITIONAL_CREATE_TIME);
		}
		
	}

}