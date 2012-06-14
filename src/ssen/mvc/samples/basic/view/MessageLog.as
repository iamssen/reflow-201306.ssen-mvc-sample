package ssen.mvc.samples.basic.view {

	import mx.collections.IList;
	
	import spark.components.DataGroup;
	import spark.components.supportClasses.SkinnableComponent;

	public class MessageLog extends SkinnableComponent {

		[SkinPart(required="true")]
		public var list:DataGroup;

		private var _dataProvider:IList;

		public function setDataProvider(dataProvider:IList):void {
			if (list !== null) {
				list.dataProvider=dataProvider;
			} else {
				_dataProvider=dataProvider;
			}
		}

		public function deconstruct():void {
			detachSkin();
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);

			if (instance === list) {
				if (_dataProvider) {
					list.dataProvider=_dataProvider;
					_dataProvider=null;
				}
			}
		}

		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);

			if (instance === list) {
				list.dataProvider=null;
			}
		}
	}
}
