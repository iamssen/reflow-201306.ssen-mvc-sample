package ssen.mvc.samples.basic.view {
	import flash.events.Event;
	
	import spark.components.supportClasses.ItemRenderer;

	public class MessageRenderer extends ItemRenderer {
		public const REMOVE:String="remove";

		protected function dispatchRemove():void {
			dispatchEvent(new Event(REMOVE));
		}

		public function getId():int {
			return data.id;
		}
	}
}
