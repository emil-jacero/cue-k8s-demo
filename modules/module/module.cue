package module

import (
	kubernetes "k8s.io/apimachinery/pkg/runtime"
)

#ModuleConfig: {
	name:      string & =~"^[a-z0-9]([a-z0-9\\-]){0,61}[a-z0-9]$"
	namespace: string & =~"^[a-z0-9]([a-z0-9\\-]){0,61}[a-z0-9]$"
	labels: {[string]: string}
	...
}

#Module: #ModuleConfig & {
	name:      *"example-1" | string
	namespace: "bundle-\(name)"
	labels: {"bundle.example/name": name}
	apps: {...}
	resources: [ID=_]: kubernetes.#Object
	let _ns = namespace
	let _labels = labels
	for ak, av in apps {
		for rk, rv in av.resources {
			if rv.kind =~ "HelmRelease" {resources: "\(ak)-\(rk)": spec: targetNamespace: rv.metadata.namespace}
			if rv.apiVersion =~ "^.*toolkit.fluxcd.io.*" {resources: "\(ak)-\(rk)": metadata: namespace: _ns}
			resources: "\(ak)-\(rk)": metadata: labels: _labels
			resources: "\(ak)-\(rk)": rv
		}
	}
}
