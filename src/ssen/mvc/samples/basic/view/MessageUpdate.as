package ssen.mvc.samples.basic.view {
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Panel;

	public class MessageUpdate extends MessageInput {
		private var _str:String;

		public var targetMessageId:int;
		private var _window:Panel;

		public function openWindow(window:Panel, parent:DisplayObject):void {
			_window=window;

			window.addElement(this);
			window.addEventListener(CloseEvent.CLOSE, closeHandler, false, 0, true);

			PopUpManager.addPopUp(window, parent, true);
			PopUpManager.centerPopUp(window);
		}

		private function closeHandler(event:Event):void {
			close();
		}

		public function close():void {
			PopUpManager.removePopUp(_window);

			_window.removeEventListener(CloseEvent.CLOSE, closeHandler);
			_window=null;
		}

		public function setText(str:String):void {
			_str=str;

			if (textInput !== null) {
				bindText();
			}
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);

			if (instance === textInput) {
				if (_str !== null) {
					bindText();
				}
			}
		}

		private function bindText():void {
			// textinput 에 text 를 적용해 줍니다
			textInput.text=_str;
			// button 의 enabled 상태를 갱신해 줍니다
			refreshSubmitButtonEnabled();
			// text input 에 focus 를 맞춰줍니다 
			focusManager.setFocus(textInput);
			// selection range 를 글자의 마지막으로 맞춰줍니다
			textInput.selectRange(textInput.text.length, textInput.text.length);
		}
	}
}
