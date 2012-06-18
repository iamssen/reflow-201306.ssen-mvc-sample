package ssen.mvc.samples.basic.view {
	import flash.events.Event;
	
	import spark.components.supportClasses.ItemRenderer;

	//=========================================================
	// 기능적으로는 겹치나 모양은 다를 수 있는 Skin 처리 기능이 없는 ItemRenderer 를 위해
	// 기능적 구현을 한 parent class 를 만들어줍니다
	//
	// 실제 모양은 MessageLogListRenderer 와 같이 구현해줍니다
	//=========================================================
	public class MessageRenderer extends ItemRenderer {
		public const REMOVE:String="remove";
		public const UPDATE:String="update";

		protected function dispatchRemove():void {
			dispatchEvent(new Event(REMOVE));
		}
		
		protected function dispatchUpdate():void {
			dispatchEvent(new Event(UPDATE));
		}

		public function getId():int {
			return data.id;
		}
	}
}
