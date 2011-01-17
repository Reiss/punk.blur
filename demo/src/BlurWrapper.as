package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Graphic;
	
	/**
	 * ...
	 * @author Reiss
	 */
	public class BlurWrapper extends Graphic
	{
		public var blurCanvas:BitmapData = null;
		private var _graphic:Graphic;
		
		public function BlurWrapper(g:Graphic) 
		{
			super();
			_graphic = g;
			active = g.active;
			visible = g.visible;
			relative = g.relative;
		}
		
		public function get wrappedGraphic():Graphic
		{
			return _graphic;
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void
		{
			if (blurCanvas)
				_graphic.render(blurCanvas, point, camera);
			_graphic.render(target, point, camera);
		}
		
		override public function update():void
		{
			_graphic.update();
		}
		
	}

}