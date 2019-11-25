Class {
	#name : #BaselineOfCasinoRESTAPI,
	#superclass : #BaselineOf,
	#category : #BaselineOfCasinoRESTAPI
}

{ #category : #baselines }
BaselineOfCasinoRESTAPI >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfCasinoRESTAPI >> defineDependencies: spec [
	spec baseline: 'Tealight' with: [ spec repository: 'github://astares/Tealight/repository' ].
	spec
		baseline: 'Casino'
		with: [ spec
				loads: 'behavior-bl';
				repository: 'github://badetitou/Casino:master/src' ]
]

{ #category : #baselines }
BaselineOfCasinoRESTAPI >> defineGroups: spec [
	
]

{ #category : #baselines }
BaselineOfCasinoRESTAPI >> definePackages: spec [
	spec
		package: 'CasinoRESTAPI' with: [spec requires: #('Tealight' 'Casino')];
		package: 'CasinoRESTAPI-Tests' with: [ spec requires: #('CasinoRESTAPI')]
]
