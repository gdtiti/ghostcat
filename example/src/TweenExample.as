package
{
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	
	import ghostcat.debug.EnabledSWFScreen;
	import ghostcat.display.GSprite;
	import ghostcat.display.filter.FilterProxy;
	import ghostcat.manager.RootManager;
	import ghostcat.operation.DelayOper;
	import ghostcat.operation.FunctionOper;
	import ghostcat.operation.RepeatOper;
	import ghostcat.operation.TweenOper;
	import ghostcat.parse.DisplayParse;
	import ghostcat.parse.graphics.GraphicsFill;
	import ghostcat.parse.graphics.GraphicsRect;
	import ghostcat.ui.containers.GAlert;
	import ghostcat.util.Util;
	import ghostcat.util.easing.Elastic;
	import ghostcat.util.easing.TweenUtil;

	[Frame(factoryClass="ghostcat.ui.RootLoader")]
	
	/**
	 * 几个Tween的演示
	 * @author flashyiyi
	 * 
	 */
	public class TweenExample extends GSprite
	{
		public var sp:Sprite;
		public var f:FilterProxy;
		protected override function init():void
		{
			new EnabledSWFScreen(stage);
			
			RootManager.register(this,1,1);
			
			sp = DisplayParse.createSprite([new GraphicsFill(0xFFFFFF),new GraphicsRect(0,0,100,100,10)])
			addChild(sp);
			
			start();
		}
		public function start():void
		{
			TweenUtil.from(sp,1000,{delay:500,x:100,tint:0xFF0000,ease:Elastic.easeIn,renderOnStart:true})
			TweenUtil.to(sp,1000,{delay:1500,x:100,tint:0x0000FF,ease:Elastic.easeOut});
			
			
			//利用滤镜代理来实现滤镜Tween
			f = new FilterProxy(new BlurFilter(0,0));
			f.applyFilter(sp);
			
			//利用Operation机制实现的顺序以及循环Tween
			new DelayOper(2000).commit();
			new RepeatOper([new TweenOper(f,1000,{blurX:20,blurY:20}),new TweenOper(f,1000,{blurX:0,blurY:0})]).commit();
			
			TweenUtil.update();//手动更新缓动，主要为了处理倒放时第一帧的空位问题
		}
	}
}