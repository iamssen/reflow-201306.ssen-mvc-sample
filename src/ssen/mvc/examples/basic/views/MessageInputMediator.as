package ssen.mvc.examples.basic.views {
import ssen.mvc.EvtGatherer;
import ssen.mvc.IEventBus;
import ssen.mvc.IMediator;
import ssen.mvc.examples.basic.events.MessageErrorEvent;
import ssen.mvc.examples.basic.events.MessageEvent;

public class MessageInputMediator implements IMediator {
	//=========================================================
	// inject dependent
	//=========================================================
	[Inject]
	public var eventBus:IEventBus;

	//=========================================================
	// inject view
	//=========================================================
	private var view:MessageInput;

	public function setView(value:Object):void {
		view=value as MessageInput;
		view.submit=submit;
	}

	//=========================================================
	// life cycle
	//=========================================================
	private var evtGatherer:EvtGatherer;

	public function onRegister():void {
		evtGatherer=new EvtGatherer;

		evtGatherer.add(eventBus.addEventListener(MessageEvent.ADDED_MESSAGE, addedMessage));
		evtGatherer.add(eventBus.addEventListener(MessageErrorEvent.ADD_FAILED, addMessageFailed));
	}

	public function onRemove():void {
		evtGatherer.dispose();
		view.submit=null;

		evtGatherer=null;
		eventBus=null;
		view=null;
	}

	//==========================================================================================
	// method wiring
	//==========================================================================================
	private function submit():void {
		var str:String=view.textInput.text;

		// 텍스트가 공백이면 입력할 필요가 없기 때문에 error event 를 내보내주고 종료
		if (str === "") {
			eventBus.dispatchEvent(new MessageErrorEvent(MessageErrorEvent.TEXT_IS_BLANK));
			return;
		}

		// 새로운 메세지의 추가를 요청
		view.enabled=false;

		var evt:MessageEvent=new MessageEvent(MessageEvent.ADD_MESSAGE);
		evt.text=str;

		eventBus.dispatchEvent(evt);
	}

	//=========================================================
	// evt listeners
	//=========================================================
	private function addMessageFailed(event:MessageErrorEvent):void {
		// 메세지 입력이 실패한 경우. 메세지를 유지하고, 유저가 입력 가능하도록 활성화 시켜줌
		view.enabled=true;
	}

	private function addedMessage(event:MessageEvent):void {
		// 메세지 입력이 성공한 경우. 기존 입력을 지워주고, 유저가 입력 가능하도록 활성화 시켜줌
		view.enabled=true;
		view.textInput.text="";
		view.focusManager.setFocus(view.textInput);
	}
}
}
