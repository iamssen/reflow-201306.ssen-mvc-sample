package ssen.mvc.samples.basic.view {

	import spark.components.TextArea;
	import spark.components.supportClasses.SkinnableComponent;

	/** 단순한 console 기능. 오고 가는 event 들을 확인하기 위한 기능 */
	public class Dummy extends SkinnableComponent {

		[SkinPart]
		public var txt:TextArea;

		public function log(str:String):void {
			if (txt !== null) {
				txt.appendText(str + "\n");
			}
		}
	}
}
