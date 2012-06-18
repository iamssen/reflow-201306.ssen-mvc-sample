package ssen.mvc.samples.basic.controller {
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	import ssen.mvc.core.ICommand;
	import ssen.mvc.core.IContextView;
	import ssen.mvc.core.IViewCreator;
	import ssen.mvc.samples.basic.events.MessageEvent;
	import ssen.mvc.samples.basic.view.MessageUpdate;

	public class OpenUpdateMessagePanel implements ICommand {
		[Inject]
		public var viewCreator:IViewCreator;

		[Inject]
		public var contextView:IContextView;
		
		// [Inject]
		// public var containerManager:IContainerManager;

		public function execute(event:Event=null):void {
			var inputEvt:MessageEvent=event as MessageEvent;

			var window:TitleWindow=new TitleWindow;
			window.addElement(viewCreator.create(MessageUpdate) as IVisualElement);
			
			// containerManager.openPanel(viewCreator.create(MessageUpdate));

			PopUpManager.addPopUp(window, contextView as DisplayObject, true);
		}
	}
}
