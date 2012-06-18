package ssen.mvc.samples.basic.model {
	//=========================================================
	// Value Object 는 이 프로그램이 다룰 데이터가
	// 어떤 형태인지를 정의 합니다.
	// 그리고, 이 정의된 형태는 프로그램의 명령들을 만드는데 있어서,
	// 하나의 유통 단위가 되어줍니다.
	// 
	// 예를 들자면 func(id:int, time:Date, text:String, result:Function):void 보다는
	// func(msg:Message, result:Function):void 이 좀 더 편하겠죠.
	// 그리고, List 나 DataGrid 등에 전달할 dataProvider 에 사용하기도 적당합니다.
	//=========================================================

	/** Message Value Object */
	public class Message {
		
		/** Server 측 primary id */
		public var id:int;
		
		/** message 가 저장된 시간 */
		public var time:Date;
		
		/** message 내용 */
		public var text:String;
	}
}
