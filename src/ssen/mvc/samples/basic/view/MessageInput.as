package ssen.mvc.samples.basic.view {

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.events.FlexEvent;

	import spark.components.Button;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.TextOperationEvent;

	//=========================================================
	// View 의 구성은
	// 
	// View + Mediator 로 구성됩니다.
	//
	// 현재 View + Skin + Mediator 로 구성을 하면 코드가 한차례 더 분리됩니다.
	//
	// View 는 (작동되는 인터페이스들의 모임)
	// Skin 은 (View 의 모양을 구현하는 물리적인 Skin)
	// Mediator 는 (전체 프로그램의 로직과 View 를 연결하는 중계부를 구현)
	//
	// Mediator 를 분리해두면 View 의 재사용성이나, 분리 독립된 기능의 검증이 가능합니다.
	// 
	// Mediator 와 내부 skin part 구성들은 직접적 호출이 가능하지만,
	// state 에 의해 null 상태일 가능성이 있습니다.
	// 그렇기에 내부 skin part 의 데이터에 접근을 하는 경우에는
	// 적당한 중계 method 를 둬서 구현하는 것이 좋습니다.
	//=========================================================

	//=========================================================
	// mediator 로 dispatch 되는 event 들
	//=========================================================
	/** 입력된 text 를 보냄 */
	[Event(name="submit", type="flash.events.Event")]

	/** 단순히 유저가 텍스트 입력이 가능하게 해주는 View Component 입니다 */
	public class MessageInput extends SkinnableComponent {

		//=========================================================
		// event 상수들
		//=========================================================
		public const SUBMIT:String="submit";

		//=========================================================
		// skin part 
		//=========================================================
		[SkinPart(required="true")]
		public var textInput:TextInput;

		[SkinPart(required="true")]
		public var submit:Button;

		//=========================================================
		// public utils
		//=========================================================
		public function getText():String {
			return textInput.text;
		}

		public function clearText():void {
			textInput.text="";
			refreshSubmitButtonEnabled();
			focusManager.setFocus(textInput);
		}

		// reference out 
		public function deconstruct():void {
			detachSkin();
		}

		//=========================================================
		// skin part added / removed
		// skin part 들에 event 를 입히는 시점이 되어줍니다
		//=========================================================
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);

			if (instance === textInput) {
				textInput.addEventListener(TextOperationEvent.CHANGE, textChange, false, 0, true);
				textInput.addEventListener(FlexEvent.ENTER, enter, false, 0, true);
			} else if (instance === submit) {
				submit.addEventListener(MouseEvent.CLICK, submitClick, false, 0, true);
				refreshSubmitButtonEnabled();
			}
		}

		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);

			if (instance === textInput) {
				textInput.removeEventListener(TextOperationEvent.CHANGE, textChange);
				textInput.removeEventListener(FlexEvent.ENTER, enter);
			} else if (instance === submit) {
				submit.removeEventListener(MouseEvent.CLICK, submitClick);
			}
		}

		//=========================================================
		// private utils
		//=========================================================
		private function enter(event:FlexEvent):void {
			dispatchEvent(new Event(SUBMIT));
		}

		private function submitClick(event:MouseEvent):void {
			dispatchEvent(new Event(SUBMIT));
		}

		private function textChange(event:TextOperationEvent):void {
			refreshSubmitButtonEnabled();
		}

		final protected function refreshSubmitButtonEnabled():void {
			if (submit) {
				var enabled:Boolean=textInput !== null && textInput.text.length > 0;
				submit.enabled=enabled;
			}
		}

	}
}
