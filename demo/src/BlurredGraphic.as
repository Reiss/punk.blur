package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Graphic;
	
	/**
	 * ...
	 * @author Reiss
	 */
	public class BlurredGraphic extends Graphic
	{
		private var _blurCanvas:BitmapData;
		private var _graphic:Graphic;
		public var parent:BlurCanvas;
		
		public function BlurredGraphic(g:Graphic, m:BlurCanvas, autoStart:Boolean = true) 
		{
			super();
			_graphic = g;
			active = g.active;
			visible = g.visible;
			relative = g.relative;
			parent = m;
			
			x = g.x;
			y = g.y;
			
			if(autoStart)
				_blurCanvas = m.buffer;
		}
		
		public function get wrappedGraphic():Graphic
		{
			return _graphic;
		}
		
		public function get isBlurring():Boolean
		{
			return _blurCanvas != null;
		}
		public function set isBlurring(b:Boolean):void
		{
			if(b)
				_blurCanvas = parent.buffer;
			else
				_blurCanvas = null;
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void
		{
			if (_blurCanvas)
				_graphic.render(_blurCanvas, point, camera);
			_graphic.render(target, point, camera);
		}
		
		override public function update():void
		{
			_graphic.update();
		}
		
	}

}