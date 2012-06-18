package ssen.mvc.samples.basic.view {
	import flash.events.Event;

	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;

	public class MessageInputMediator implements IMediator {

		//=========================================================
		// 의존성 주입 요청
		//=========================================================
		[Inject]
		public var dispatcher:IContextDispatcher;

		//=========================================================
		// Framework 에 의해 자동으로 주입받는 view
		//=========================================================
		private var view:MessageInput;

		public function setView(view:Object):void {
			this.view=view as MessageInput;
		}

		//=========================================================
		// view 의 작동 시작 시점, 종료 시점이 되는 onRegister, onRemove
		// 시점별로 기능을 걸거나, 풀거나 해줄 수 있다
		//=========================================================
		public function onRegister():void {
			// 입력의 성공 혹은 실패 시에 취할 작동을 위해 listen
			dispatcher.addEventListener(MessageEvent.ADDED_MESSAGE, createdNewMessage);
			dispatcher.addEventListener(MessageErrorEvent.ADD_FAILED, addMessageFailed);

			// user 에 의해 text 입력 요청이 오는 시점을 listen
			view.addEventListener(view.SUBMIT, submitHandler);
		}

		public function onRemove():void {
			dispatcher.removeEventListener(MessageEvent.ADDED_MESSAGE, createdNewMessage);
			dispatcher.removeEventListener(MessageErrorEvent.ADD_FAILED, addMessageFailed);

			view.removeEventListener(view.SUBMIT, submitHandler);
			view.deconstruct();
			view=null;
		}

		//=========================================================
		// 
		//=========================================================
		private function addMessageFailed(event:MessageErrorEvent):void {
			// 메세지 입력이 실패한 경우. 메세지를 유지하고, 유저가 입력 가능하도록 활성화 시켜줌
			view.enabled=true;
		}

		private function createdNewMessage(event:MessageEvent):void {
			// 메세지 입력이 성공한 경우. 기존 입력을 지워주고, 유저가 입력 가능하도록 활성화 시켜줌
			view.enabled=true;
			view.clearText();
		}

		private function submitHandler(event:Event):void {
			var str:String=view.getText();

			// 텍스트가 공백이면 입력할 필요가 없기 때문에 error event 를 내보내주고 종료
			if (str === "") {
				dispatcher.dispatch(new MessageErrorEvent(MessageErrorEvent.TEXT_IS_BLANK));
				return;
			}

			// 새로운 메세지의 추가를 요청
			view.enabled=false;

			var evt:MessageEvent=new MessageEvent(MessageEvent.ADD_MESSAGE);
			evt.text=str;

			dispatcher.dispatch(evt);
		}
	}
}
