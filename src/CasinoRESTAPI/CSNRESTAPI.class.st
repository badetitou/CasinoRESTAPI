Class {
	#name : #CSNRESTAPI,
	#superclass : #Object,
	#category : #CasinoRESTAPI
}

{ #category : #'class initialization' }
CSNRESTAPI class >> exportUi: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'exportUi'>
	| gwtModel |
	CSNModelExporterAngularBLSpecific export: gwtModel.
	^ TeaOutput json value: TeaResponse ok
]

{ #category : #'class initialization' }
CSNRESTAPI class >> extractUi: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'extractUi'>
	| gwtModel gwtMooseModel |
	gwtModel := CSNUICWModel new name: 'Showroom'; yourself.
	CSNMooseModelCreatorAngular runOn: gwtModel fromSourceModel: gwtMooseModel and: 'D:\Developpement\mse\KitchenGWT\BLCoreIncubatorGwt\src\fr\bl\application.module.xml'.
	gwtMooseModel install.
	^ TeaOutput json value: (TeaResponse ok body: (MooseModel root collectWithIndex: [ :model :idx | idx -> model name ]) asDictionary)
]

{ #category : #'class initialization' }
CSNRESTAPI class >> initialize [
	TLRESTApiURLPathBuilder useAPIPrefix: 'casino'.
]

{ #category : #'class initialization' }
CSNRESTAPI class >> loadMse: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'loadMse'>
	| gwtMooseModel |
	gwtMooseModel := FAMIXModel new importFromMSEStream:  'D:\Developpement\mse\VerveineJNicolas\KitchenGWT.mse' asFileReference readStream.
	gwtMooseModel rootFolder: 'D:\Developpement\mse\VerveineJNicolas'. 
	gwtMooseModel install.
	^ TeaOutput json value: (TeaResponse ok body: (MooseModel root collectWithIndex: [ :model :idx | idx -> model name ]) asDictionary)
]

{ #category : #'class initialization' }
CSNRESTAPI class >> start [
	<script>
	TLRESTAPIBuilder buildAPI.
	TLWebserver teapot inspect.
]
