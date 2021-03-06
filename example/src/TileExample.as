package
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	
	import ghostcat.debug.EnabledSWFScreen;
	import ghostcat.display.Tile;
	import ghostcat.events.RepeatEvent;
	import ghostcat.manager.DragManager;
	import ghostcat.manager.RootManager;
	import ghostcat.parse.display.RectParse;
	import ghostcat.parse.graphics.GraphicsLineStyle;
	import ghostcat.parse.graphics.GraphicsRect;
	import ghostcat.ui.CursorSprite;

	/**
	 * 这个类生成了一个100000 x 100000的重复区域，但Repeater类的实际体积其实只有屏幕大小，因此并不消耗资源
	 * 问题在于数据- -就算一格只占一比特都已经9G了。。
	 * 
	 * @author flashyiyi
	 * 
	 */	
	public class TileExample extends Sprite
	{
		public var repeater:Tile;
		public function TileExample()
		{
			new EnabledSWFScreen(stage);
			
			RootManager.register(this);
			repeater = new Tile(TestRepeater);
			repeater.width = 100000;
			repeater.height = 100000;
			repeater.viewRect = new Rectangle(100,100,300,300);//将显示范围限定了，这样可以看到方块的动态增删
			repeater.addEventListener(RepeatEvent.ADD_REPEAT_ITEM,addRepeatItemHandler);
			repeater.cursor = CursorSprite.CURSOR_DRAG;
			repeater.filters = [new DropShadowFilter(2,45,0,0.5,16,16)];
			
			addChild(repeater);
			
			addChild(new RectParse(new GraphicsRect(100,100,300,300),new GraphicsLineStyle(0,0xFF0000)).createShape());
			addChild(new CursorSprite());//加入鼠标
			
			DragManager.register(repeater);
		}
		private function addRepeatItemHandler(event:RepeatEvent):void
		{
			(event.repeatObj as TestRepeater).point.text = event.repeatPos.toString();
		}
	}
}