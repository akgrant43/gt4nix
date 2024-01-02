Class {
	#name : #BaselineOfGt4Nix,
	#superclass : #BaselineOf,
	#category : #BaselineOfGt4Nix
}

{ #category : #accessing }
BaselineOfGt4Nix >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: 'GToolkit-NixOs'.
		spec 
			group: 'Core' with: #('GToolkit-NixOs');
			group: 'default' with: #('Core').
		].
]
