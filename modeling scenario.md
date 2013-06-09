# Modeling Work

1. context 를 작성한다
1. models 와 services 를 만든다
2. Audition 을 사용해서 models 와 services 의 기능을 구현하고, 테스트 한다

# Controller Work

1. events 와 commands 를 만든다
1. Audition 을 사용해서 events 와 commands 의 기능을 구현하고, 테스트 한다

기본적으로 event 로 실행시킨 commands 에서 터져나오는 후속 반응을 점검한다

	[before]
	public function initial():void {
		
	}
	
	[test]
	public function test():void {
		
	}

# aaa

models 와 services 의 작동 정도는 큰 문제없이 behavior case 작성이 가능한데... 과연 events 와 commands 와 같은 flow 적인 부분들까지 behavior case 작성이 가능할 것인가?

# Audition 작성 규칙

- beforeEach 에서 context 를 새로 만들어준다