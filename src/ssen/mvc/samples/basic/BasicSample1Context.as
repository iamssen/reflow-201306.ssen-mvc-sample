package ssen.mvc.samples.basic
{
	import ssen.mvc.core.IContext;
	import ssen.mvc.core.IContextView;
	import ssen.mvc.ondisplay.DisplayContext;
	
	public class BasicSample1Context extends DisplayContext
	{
		public function BasicSample1Context(contextView:IContextView, parentContext:IContext=null)
		{
			super(contextView, parentContext);
		}
	}
}