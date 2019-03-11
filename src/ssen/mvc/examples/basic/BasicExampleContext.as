package ssen.mvc.examples.basic {
import ssen.mvc.Context;
import ssen.mvc.IContext;
import ssen.mvc.IContextView;
import ssen.mvc.examples.basic.commands.AddMessage;
import ssen.mvc.examples.basic.commands.RemoveMessage;
import ssen.mvc.examples.basic.commands.StartUpdateMessage;
import ssen.mvc.examples.basic.commands.UpdateMessage;
import ssen.mvc.examples.basic.events.MessageEvent;
import ssen.mvc.examples.basic.models.MessageModel;
import ssen.mvc.examples.basic.services.IMessageService;
import ssen.mvc.examples.basic.services.LocalMessageService;
import ssen.mvc.examples.basic.views.LogViewer;
import ssen.mvc.examples.basic.views.LogViewerMediator;
import ssen.mvc.examples.basic.views.MessageInput;
import ssen.mvc.examples.basic.views.MessageInputMediator;
import ssen.mvc.examples.basic.views.MessageLog;
import ssen.mvc.examples.basic.views.MessageLogListRenderer;
import ssen.mvc.examples.basic.views.MessageLogListRendererMediator;
import ssen.mvc.examples.basic.views.MessageLogMediator;
import ssen.mvc.examples.basic.views.MessageUpdate;
import ssen.mvc.examples.basic.views.MessageUpdateMediator;

public class BasicExampleContext extends Context {
	public function BasicExampleContext(contextView:IContextView, parentContext:IContext=null) {
		super(contextView, parentContext);
	}

	//=========================================================
	// setting dependent
	//=========================================================
	override protected function mapDependency():void {
		injector.mapSingleton(MessageModel);
		injector.mapSingleton(IMessageService, LocalMessageService);

		viewInjector.mapView(LogViewer, LogViewerMediator);
		viewInjector.mapView(MessageInput, MessageInputMediator);
		viewInjector.mapView(MessageUpdate, MessageUpdateMediator, true);
		viewInjector.mapView(MessageLog, MessageLogMediator);
		viewInjector.mapView(MessageLogListRenderer, MessageLogListRendererMediator);

		commandMap.mapCommand(MessageEvent.ADD_MESSAGE, new <Class>[AddMessage]);
		commandMap.mapCommand(MessageEvent.REMOVE_MESSAGE, new <Class>[RemoveMessage]);
		commandMap.mapCommand(MessageEvent.START_UPDATE, new <Class>[StartUpdateMessage]);
		commandMap.mapCommand(MessageEvent.UPDATE_MESSAGE, new <Class>[UpdateMessage]);
	}
}
}
