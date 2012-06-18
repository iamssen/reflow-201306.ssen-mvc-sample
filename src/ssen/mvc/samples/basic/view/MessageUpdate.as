package ssen.mvc.samples.basic.view {

	public class MessageUpdate extends MessageInput {
		private var _str:String;

		public function setText(str:String):void {
			_str=str;

			if (textInput !== null) {
				textInput.text=_str;
			}
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);

			if (instance === textInput) {
				if (_str !== null) {
					textInput.text=_str;
				}
			}
		}
	}
}
