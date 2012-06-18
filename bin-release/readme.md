# SSen Mvc Framework Basic Sample

## 만들고자 하는 샘플

간단하게 혼자 쓰는 트위터와 같은 프로그램을 만들어봅니다.

## Model

Model 은 **이 프로그램이 어떤 작동을 하는 것인가?** 라는 주제를 가집니다.

[ssen.mvc.samples.basic.model.Message](ssen/mvc/samples/basic/model/Message.as)

```
package ssen.mvc.samples.basic.model {

	public class Message {
		public var id:int;
		public var time:Date;
		public var text:String;
	}
}
```

우선 `Message` 라는 Value Object 를 만들어 줍니다.

- `id` 는 서버 상에 기록된 데이터의 primary id 즉, 고유값 입니다.
- `time` 은 데이터의 생성 시간 입니다.
- `text` 은 기록된 message 입니다.

Value Object 는 일종의 그룹화 된 데이터 입니다. `Message` 하나에 대한 정의 입니다.

[ssen.mvc.samples.basic.model.MessageModel](ssen/mvc/samples/basic/model/MessageModel.as)

```
package ssen.mvc.samples.basic.model {

	public interface MessageModel {
		function addMessage(text:String, result:Function=null, fault:Function=null):void;
		function updateMessage(id:int, text:String, result:Function=null, fault:Function=null):void;
		function getMessage(id:int, result:Function=null, fault:Function=null):void;
		function getMessages(startId:int=0, endId:int=2147483647, result:Function=null,
							 fault:Function=null):void;
		function removeMessage(id:int, result:Function=null, fault:Function=null):void;
		function removeMessages(ids:Vector.<int>, result:Function=null, fault:Function=null):void;
		function removeAllMessages(result:Function=null, fault:Function=null):void;
	}
}
```

글을 저장, 갱신, 삭제 할 수 있는 `MessageModel` 이라는 인터페이스를 만들어 줍니다.

result 와 fault 는 서버 데이터는 즉각적으로 데이터가 오지 않기 때문에,

```
model.addMessage("text", function(message:Message):void {
	trace(message);
}, function(error:Error):void {
	trace(error);
});
```

위와 같은 형태로, 데이터가 도착했을때 행동할 block code 를 function 형태로 보내주게 됩니다.

일단, 현재로서는 서버가 없기 때문에 Test 로 사용할 가상 Service Model 을 만들어 줍니다.

[ssen.mvc.samples.basic.model.LocalMessageModel](ssen/mvc/samples/basic/model/LocalMessageModel.as)

```
package ssen.mvc.samples.basic.model {
	import flash.utils.setTimeout;

	import ssen.mvc.base.Actor;

	public class LocalMessageModel extends Actor implements MessageModel {
		private var table:MessageTable;

		public function LocalMessageModel() {
			table=new MessageTable;
		}

		override protected function deconstruct():void {
			table=null;
		}

		public function addMessage(text:String, result:Function=null, fault:Function=null):void {
			setTimeout(function():void {
				var msg:Message=table.addMessage(text);

				if (result !== null) {
					result(msg);
				}
			}, 100);
		}
		
// 길어서 그러니 파일로 보세요.
```

제 경우에는 `DataTable` 이라는 유틸리티를 사용했지만, 여러분은 단순히 

- `setTimeout` 이라는 일정한 서버 호출에 들어가는 딜레이 타임을 흉내낼 수 있는 function 을 사용해서
- `result` 에 해당 호출의 결과값을 넣어줍니다
- `fault` 에 확률적으로 error 결과를 넣어주면 더 효과적 이겠죠

여기까지 진행을 하면 **이 프로그램으로 뭘 할 수 있는가?** 에 대한 코드가 완료됩니다.


## Controller

일단은 `Model` 에 나온 모든 행동들을 다 구현하긴 쉽지 않으니, Add (글 추가) 와 Remove (글 삭제) 만 구현해 봅시다.

[ssen.mvc.samples.basic.controller.AddMessage](ssen/mvc/samples/basic/controller/AddMessage.as) Class 와 [ssen.mvc.samples.basic.controller.RemoveMessage](ssen/mvc/samples/basic/controller/RemoveMessage.as) Class 를 `ICommand` interface 를 구현해서 만듭니다.

걍 Class 만 만들어 둡니다.

이 두 개의 `AddMessage` 와 `RemoveMessage` 는 User 가 **메세지를 추가하려 할 때** 와 **삭제 하려 할 때** 실행될 하나의 `Command` 입니다.

이 두 개의 `Command` 가 만들어졌다면, 이제 남는 것은 **이 Command 가 어떤 명령을 통해 실행될 것인가?** 가 됩니다. 

[ssen.mvc.samples.basic.events.MessageEvent](ssen/mvc/samples/basic/events/MessageEvent.as)

```
package ssen.mvc.samples.basic.events {
	import flash.events.Event;

	public class MessageEvent extends Event {
		public static const ADDED_MESSAGE:String="addedMessage";
		public static const ADD_MESSAGE:String="addMessage";
		public static const REMOVE_MESSAGE:String="removeMessage";
		public static const REMOVED_MESSAGE:String="removedMessage";
		public static const TEXT_IS_BLANK:String="textIsBlank";

		public var text:String;
		public var messageId:int;

		public function MessageEvent(type:String) {
			super(type);
		}

		override public function clone():Event {
			var clone:MessageEvent=new MessageEvent(type);
			clone.messageId=messageId;
			clone.text=text;

			return clone;
		}

		override public function toString():String {
			return formatToString("MessageEvent", "type", "text", "messageId");
		}
	}
}
````

명령은 크게

- `ADD_MESSAGE` (유저가 요청 했으니깐) 새 글을 만들어줘
- `ADDED_MESSAGE` (서버에서) 새 글을 만들었어 
- `REMOVE_MESSAGE` (유저가 요청 했으니깐) 글을 지워줘
- `REMOVED_MESSAGE` (서버에서) 글을 지웠어

라는 **유저의 요청에 대한 알림** 과 **서버에서 처리된 결과의 알림** 이 쌍으로 이루어져 있습니다

일단은 실행될 `Command` 들과 행동들의 알림이 될 `Event` 들을 만드는 선에서 종료 합니다.


## View

우리는 `Controller` 에서 유저와 서버가 서로 주고 받을 알림이 되는 `Event` 를 만들었습니다. `View` 는 이 알림들을 기준으로 작성됩니다.

쉽게 얘기해서 **뭔가 일이 생길때 알리고, 뭔가 일이 생겼을때 행동하는** 것을 `View` 라고 할 수 있습니다.

우선은 테스트를 진행하면서 개발을 해야 하니, 오고 가는 `Event` 들을 캡쳐 할 수 있는 `View` 를 만들어 보겠습니다.

[ssen.mvc.samples.basic.view.Dummy](ssen/mvc/samples/basic/view/Dummy.as)

```
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
```

Spark 에서 생긴 `SkinnableComponent` 를 사용하면 좀 더 깔끔한 구성이 가능합니다.

우리는 `View` 와 View 를 구현해줄 `Skin`, 그리고, View 와 다른 로직들을 중개해줄 `Mediator` 를 조합해서 하나의 View 를 구성해 볼 것 입니다.

`Dummy` 는 **Dummy 라는 화면에 필요한 구성 요소들과 유저의 행동을 알림으로 중계** 합니다.

복잡한 설명 보다는 차라리 코드를 보는게 더 쉽겠네요.

- `[SkinPart] public var txt:TextArea;` 는 이 화면에 TextArea 가 구성된다는 선언 입니다.
- `function log(str:String):void` 는 외부에서 이 화면으로 메세지를 추가해줄 수 있게 해주는 기능 입니다.

[ssen.mvc.samples.basic.view.DummyMediator](ssen/mvc/samples/basic/view/DummyMediator.as)

```
package ssen.mvc.samples.basic.view {
	import flash.events.Event;
	
	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;

	public class DummyMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

		private var view:Dummy;

		public function setView(view:Object):void {
			this.view=view as Dummy;
		}

		public function onRemove():void {
			dispatcher.removeEventListener(MessageEvent.ADD_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageEvent.REMOVE_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageEvent.REMOVED_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageEvent.ADDED_MESSAGE, viewEvent);
			dispatcher.removeEventListener(MessageEvent.TEXT_IS_BLANK, viewEvent);
			dispatcher.removeEventListener(MessageErrorEvent.ADDED_FAILED, viewEvent);
			dispatcher.removeEventListener(MessageErrorEvent.REMOVED_FAILED, viewEvent);
		}

		public function onRegister():void {
			dispatcher.addEventListener(MessageEvent.ADD_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageEvent.REMOVE_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageEvent.REMOVED_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageEvent.ADDED_MESSAGE, viewEvent);
			dispatcher.addEventListener(MessageEvent.TEXT_IS_BLANK, viewEvent);
			dispatcher.addEventListener(MessageErrorEvent.ADDED_FAILED, viewEvent);
			dispatcher.addEventListener(MessageErrorEvent.REMOVED_FAILED, viewEvent);
		}

		private function viewEvent(event:Event):void {
			trace("DummyMediator.viewEvent", event);
			view.log(event.toString());
		}
	}
}
```

`Mediator` 는 외부의 로직과 `View` 를 중계해 줍니다.

- `[Inject] public var dispatcher:IContextDispatcher;` 를 통해 **의존하는 IContextDispatcher** 를 불러옵니다.
- `setView()` 에서는 View 가 되는 Dummy 를 던져 줍니다
- `onRegister()` 는 View 의 작동이 시작되는 시점에 취해야 할 행동들 입니다.
- `onRemove()` 는 View 의 작동이 중단되는 시점에 취해야 할 행동들 입니다.

대충 코드를 보면 알겠지만, 현재 선언된 모든 `Event` 들을 캡쳐해서, `Dummy.log()` 로 보내줍니다.

[ssen.mvc.samples.basic.view.DummySkin](ssen/mvc/samples/basic/view/DummySkin.mxml)

```
<?xml version="1.0" encoding="utf-8"?>
<s:Skin xmlns:fx="http://ns.adobe.com/mxml/2009" xmlns:s="library://ns.adobe.com/flex/spark">
	<!-- host component -->
	<fx:Metadata>
		[HostComponent("ssen.mvc.samples.basic.view.Dummy")]
	</fx:Metadata>

	<s:TextArea id="txt" width="100%" height="100%"/>
</s:Skin>

```

`Dummy` 의 `Skin` 입니다. `SkinnableComponent` 에 관련된 것은 검색을 통해 알아보시는게 더 좋겠네요.

이렇게 하나의 `View` 에 세 개의 구성요소를 만들어 둡니다.

- `Dummy` 는 우리의 눈에 보일 하나의 Component 지만, 내부적으로는 View 의 기능적 인터페이스 만을 선언합니다.
- `DummySkin` 은 `Dummy` 의 실제적인 화면을 구현합니다. 
- `DummyMediator` 는 `Dummy` 가 실제 프로그램 상의 로직에 포함되어 돌아갈 수 있도록 해줍니다.

여기서 `Dummy` 와 `DummyMediator` 의 관계가 중요합니다.

우리가 흔히 프로그래밍을 하다보면 **단순히 이 Component 의 기능적 부분만을 작업하고 싶은데, 코드가 섞여 있어서 전체를 다 건드려야 하는** 우울한 일이 생기기 마련입니다.

`Mediator` 에 의한 분리는 우리가 어떤 Component 를 개발하는데, 전체 프로그램의 흐름은 신경쓰지 않아도 되는 장점을 줍니다. 

단순히 확인만 하는 것은 적절한 테스트가 되지 못할테니, 입력을 담당할 `View` 를 하나 더 만들어 줍니다.

[ssen.mvc.samples.basic.view.MessageInput](ssen/mvc/samples/basic/view/MessageInput.as)

```
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
```

`TextInput` 에 글을 쓰고, `Button` 을 누르거나, `enter key` 를 통해서 보내는 간단한 `View` 입니다.

[ssen.mvc.samples.basic.view.MessageInputSkin](ssen/mvc/samples/basic/view/MessageInputSkin.mxml)

```
<?xml version="1.0" encoding="utf-8"?>
<s:Skin xmlns:fx="http://ns.adobe.com/mxml/2009" xmlns:s="library://ns.adobe.com/flex/spark">
	<!-- host component -->
	<fx:Metadata>
		[HostComponent("ssen.mvc.samples.basic.view.MessageInput")]
	</fx:Metadata>

	<s:layout>
		<s:HorizontalLayout paddingTop="0" paddingBottom="0" paddingLeft="0" paddingRight="0" gap="5"
							horizontalAlign="left" verticalAlign="top"/>
	</s:layout>

	<s:TextInput id="textInput" width="100%" height="100%"/>
	<s:Button id="submit" label="submit" height="100%" buttonMode="true"/>
</s:Skin>
```


## Context

자 이제 **이 프로그램이 어떤 데이터를 가지고 있고, 어떤 작동을 하느냐?** 에 대한 `Model` 도 만들었고, **어떤 행동들을 취할 것이냐, 그 행동들을 어떤 알림에 의해 취할 것이냐** 에 대한 `Controller` 도 만들었고, **프로그램의 작동과 행동들을 사용자와 연결 시켜줄** `View` 도 만들었습니다.

이것들을 연결해줘야겠죠.

[ssen.mvc.samples.basic.BasicSampleContext](ssen/mvc/samples/basic/BasicSampleContext.as)

```
package ssen.mvc.samples.basic {
	import ssen.mvc.core.IContext;
	import ssen.mvc.core.IContextView;
	import ssen.mvc.ondisplay.DisplayContext;
	import ssen.mvc.samples.basic.controller.AddMessage;
	import ssen.mvc.samples.basic.controller.RemoveMessage;
	import ssen.mvc.samples.basic.events.MessageEvent;
	import ssen.mvc.samples.basic.model.LocalMessageModel;
	import ssen.mvc.samples.basic.model.MessageModel;
	import ssen.mvc.samples.basic.view.Dummy;
	import ssen.mvc.samples.basic.view.DummyMediator;
	import ssen.mvc.samples.basic.view.MessageInput;
	import ssen.mvc.samples.basic.view.MessageInputMediator;
	import ssen.mvc.samples.basic.view.MessageLog;
	import ssen.mvc.samples.basic.view.MessageLogListRenderer;
	import ssen.mvc.samples.basic.view.MessageLogMediator;
	import ssen.mvc.samples.basic.view.MessageRendererMediator;

	public class BasicSampleContext extends DisplayContext {
		public function BasicSampleContext(contextView:IContextView, parentContext:IContext=null) {
			super(contextView, parentContext);
		}

		override protected function mapDependency():void {
			viewInjector.mapView(Dummy, DummyMediator);
			viewInjector.mapView(MessageInput, MessageInputMediator);
			viewInjector.mapView(MessageLog, MessageLogMediator);
			viewInjector.mapView(MessageLogListRenderer, MessageRendererMediator);

			injector.mapSingletonOf(MessageModel, LocalMessageModel);

			commandMap.mapCommand(MessageEvent.ADD_MESSAGE, AddMessage);
			commandMap.mapCommand(MessageEvent.REMOVE_MESSAGE, RemoveMessage);
		}

		override protected function shutdown():void {
			// TODO Auto Generated method stub
			super.shutdown();
		}

		override protected function startup():void {
			// TODO Auto Generated method stub
			super.startup();
		}

	}
}

```

- `viewInjector.mapView` 는 만들어 두었던 `View` 와 `Mediator` 를 이어줍니다.
- `injector.mapSingletonOf` 는 `[Inject]` metadata tag 를 통한 의존성 주입을 위한 선언이 됩니다
- `commandMap.mapCommand` 는 특정 `Event` 발생시에, 실행될 `Command` 를 지정합니다.

[ssen.mvc.samples.basic.BasicSample](ssen/mvc/samples/basic/BasicSample.mxml)

```
<?xml version="1.0" encoding="utf-8"?>
<s:Group xmlns:fx="http://ns.adobe.com/mxml/2009" xmlns:s="library://ns.adobe.com/flex/spark"
		 xmlns:view="ssen.mvc.samples.basic.view.*" preinitialize="initialContext()"
		 implements="ssen.mvc.core.IContextView">
	<s:layout>
		<s:VerticalLayout paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" gap="10"
						  horizontalAlign="left" verticalAlign="top"/>
	</s:layout>

	<fx:Script>
		<![CDATA[
			import ssen.mvc.core.IContext;

			private var context:BasicSampleContext;


			public function get contextInitialized():Boolean {
				return context !== null;
			}

			public function initialContext(parentContext:IContext=null):void {
				context=new BasicSampleContext(this, parentContext);
			}
		]]>
	</fx:Script>

	<s:Group width="100%" height="100%">
		<s:layout>
			<s:VerticalLayout paddingTop="0" paddingBottom="0" paddingLeft="0" paddingRight="0" gap="5"
							  horizontalAlign="left" verticalAlign="top"/>

		</s:layout>
		<view:MessageLog width="100%" height="100%" skinClass="ssen.mvc.samples.basic.view.MessageLogSkin"/>
		<view:MessageInput width="100%" height="25" skinClass="ssen.mvc.samples.basic.view.MessageInputSkin"/>
	</s:Group>

	<view:Dummy width="100%" height="100" skinClass="ssen.mvc.samples.basic.view.DummySkin"/>
</s:Group>
```

자… 이제 만들어진 `Context` 를 적용시켜줄 `ContextView` 를 만듭니다.

`preinitialize` 상황에서 `context` 를 만들어 줍니다.

아래쪽에 보시면 만들어두었던 `View` 들이 포함되어 있습니다.

[Main.mxml](Main.mxml)

```
<?xml version="1.0" encoding="utf-8"?>
<s:Application xmlns:fx="http://ns.adobe.com/mxml/2009" xmlns:s="library://ns.adobe.com/flex/spark"
			   xmlns:view="ssen.mvc.samples.basic.view.*" xmlns:basic="ssen.mvc.samples.basic.*">
	<basic:BasicSample width="100%" height="100%"/>
</s:Application>
```

마지막으로 이제 만들어진 `ContextView` 를 화면에 포함시켜주면 동작을 하게 됩니다. `ContextView` 간에는 상호 간섭이 없기 때문에,

```
<?xml version="1.0" encoding="utf-8"?>
<s:Application xmlns:fx="http://ns.adobe.com/mxml/2009" xmlns:s="library://ns.adobe.com/flex/spark"
			   xmlns:view="ssen.mvc.samples.basic.view.*" xmlns:basic="ssen.mvc.samples.basic.*">
	<s:layout>
		<s:HorizontalLayout paddingTop="5" paddingBottom="5" paddingLeft="5" paddingRight="5" gap="10"
						  horizontalAlign="left" verticalAlign="top"/>
	</s:layout>
	
	<basic:BasicSample width="100%" height="100%"/>
	<basic:BasicSample width="100%" height="100%"/>
</s:Application>
```

위와 같은 구성을 해줘도 정상적으로 작동되게 됩니다.

<u>뜨문뜨문 설명을 해뒀는데, 다시 한 번, 코드를 살펴보면서 코드를 작성해보세요.</u>




















