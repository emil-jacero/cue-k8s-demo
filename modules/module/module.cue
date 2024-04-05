package module

import (
	kubernetes "k8s.io/apimachinery/pkg/runtime"
)

#ModuleConfig: {
	name:      string & =~"^[a-z0-9]([a-z0-9\\-]){0,61}[a-z0-9]$"
	namespace: string & =~"^[a-z0-9]([a-z0-9\\-]){0,61}[a-z0-9]$"
	labels: {[string]: string}
}

#Module: #ModuleConfig & {
	resources: [ID=_]: kubernetes.#Object
}
