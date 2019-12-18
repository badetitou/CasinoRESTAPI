Class {
	#name : #CSNRESTAPI,
	#superclass : #Object,
	#category : #CasinoRESTAPI
}

{ #category : #'class initialization' }
CSNRESTAPI class >> exportUi: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'exportUi'>
	| gwtModel |
	gwtModel := MooseModel root detect: [:model | model name = 'Showroom' ] ifNone: [^ TeaOutput json value: (TeaResponse notFound)].
	CSNModelExporterAngularBLSpecific export: gwtModel.
	^ TeaOutput json value: TeaResponse ok
]

{ #category : #'class initialization' }
CSNRESTAPI class >> extractUi: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'extractUi'>
	| gwtModel gwtMooseModel |
	gwtMooseModel := MooseModel root detect: [:model | model name = 'KitchenGWT' ] ifNone: [^ TeaOutput json value: (TeaResponse notFound)].
	gwtMooseModel rootFolder: 'D:\Developpement\mse\VerveineJNicolas'. 
	gwtModel := CSNUICWModel new name: 'Showroom'; yourself.
	CSNMooseModelCreatorAngular runOn: gwtModel fromSourceModel: gwtMooseModel and: 'D:\Developpement\mse\KitchenGWT\BLCoreIncubatorGwt\src\fr\bl\application.module.xml'.
	gwtMooseModel install.
	^ TeaOutput json value: (TeaResponse ok body: (MooseModel root collectWithIndex: [ :model :idx | idx -> model name ]) asDictionary)
]

{ #category : #'class initialization' }
CSNRESTAPI class >> hello: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'hello'>
	^ 'hello'
]

{ #category : #'class initialization' }
CSNRESTAPI class >> initialize [
  TLRESTApiURLPathBuilder useAPIPrefix: 'casino'.
  TLRESTAPIBuilder buildAPI
]

{ #category : #'class initialization' }
CSNRESTAPI class >> inspect [
	<script>
	TLWebserver teapot inspect.
]

{ #category : #'class initialization' }
CSNRESTAPI class >> loadMse: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'loadMse'>
	| gwtMooseModel |
	gwtMooseModel := FAMIXModel new importFromMSEStream: 'D:\Developpement\mse\VerveineJNicolas\KitchenGWT.mse' asFileReference readStream.
	gwtMooseModel install.
	^ TeaOutput json value: (TeaResponse ok body: (MooseModel root collectWithIndex: [ :model :idx | idx -> model name ]) asDictionary)
]
