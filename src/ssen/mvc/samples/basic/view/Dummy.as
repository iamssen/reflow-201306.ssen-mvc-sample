package ssen.mvc.samples.basic.view {

	import spark.components.TextArea;
	import spark.components.supportClasses.SkinnableComponent;

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
