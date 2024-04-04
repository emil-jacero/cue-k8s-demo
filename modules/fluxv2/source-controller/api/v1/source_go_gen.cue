// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/source-controller/api/v1

package v1

// SourceIndexKey is the key used for indexing objects based on their
// referenced Source.
#SourceIndexKey: ".metadata.source"

// Source interface must be supported by all API types.
// Source is the interface that provides generic access to the Artifact and
// interval. It must be supported by all kinds of the source.toolkit.fluxcd.io
// API group.
//
// +k8s:deepcopy-gen=false
#Source: _