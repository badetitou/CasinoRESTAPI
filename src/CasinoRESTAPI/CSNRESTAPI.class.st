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
	| gwtModel gwtMooseModel xml |
	gwtMooseModel := MooseModel root detect: [:model | model name = 'KitchenGWT' ] ifNone: [^ TeaOutput json value: (TeaResponse notFound)].
	gwtMooseModel rootFolder: 'D:\Developpement\mse\VerveineJNicolas'.
	xml := (XMLDOMParser  parse: 'D:\Developpement\mse\BLOmajeGWT\BLOmajeGwt\src\fr\bl\Omaje.module.xml' asFileReference).
	
	gwtModel := CSNUICWModel new name: 'Showroom'; yourself.
	
	CSNWebModelJava new
	sourceModel: gwtMooseModel;
	xml: xml;
	createModelIn: gwtModel.

	gwtModel installWithCache: false.
	^ TeaOutput json value: (TeaResponse ok body: (MooseModel root collectWithIndex: [ :model :idx | idx -> model name ]) asDictionary)
]

{ #category : #'class initialization' }
CSNRESTAPI class >> generateAngularCodeFromJson: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'generate-angular-code-from-json'>
	| cSNModel metamodel angularExporter |
	cSNModel := CSNUICWModel new. 
	metamodel := FMMetaModelBuilder metamodelFromPackages: CSNBModel packagesToProcessToCreateMetamodel , CRFModel packagesToProcessToCreateMetamodel, CSNBuModel packagesToProcessToCreateMetamodel.
	cSNModel metamodel: metamodel.
	cSNModel metamodel.
	cSNModel importFromJSONStream: 'D:\omajeCasino.json' asFileReference readStream.
	cSNModel installWithCache: false.
	angularExporter := CSNModelExporterAngularBLSpecific new.
	angularExporter model: cSNModel.
	angularExporter exporterAngularConfiguration: CSNExporterAngularCoreWeb2Configuration new.
	angularExporter export.
	^ 'Angular code is generated in the root folder of your Pharo image'
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
