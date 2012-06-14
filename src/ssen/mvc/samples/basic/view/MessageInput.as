package ssen.mvc.samples.basic.view {

	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import mx.events.FlexEvent;

	import spark.components.Button;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.TextOperationEvent;

	[Event(name="submit", type="flash.events.Event")]

	public class MessageInput extends SkinnableComponent {

		public const SUBMIT:String="submit";

		[SkinPart(required="true")]
		public var textInput:TextInput;

		[SkinPart(required="true")]
		public var submit:Button;

		public function getText():String {
			return textInput.text;
		}

		public function clearText():void {
			textInput.text="";
			refreshSubmitButtonEnabled();
			focusManager.setFocus(textInput);
		}

		public function deconstruct():void {
			detachSkin();
		}

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

		private function enter(event:FlexEvent):void {
			if (textInput.text !== "") {
				dispatchEvent(new Event(SUBMIT));
			}
		}

		private function submitClick(event:MouseEvent):void {
			dispatchEvent(new Event(SUBMIT));
		}

		private function textChange(event:TextOperationEvent):void {
			refreshSubmitButtonEnabled();
		}

		private function refreshSubmitButtonEnabled():void {
			submit.enabled=textInput !== null && textInput.text.length > 0;
		}

	}
}
