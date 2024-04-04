// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/source-controller/api/v1beta2

package v1beta2

import (
	"github.com/fluxcd/pkg/apis/meta"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"github.com/fluxcd/pkg/apis/acl"
	apiv1 "github.com/fluxcd/source-controller/api/v1"
)

// GitRepositoryKind is the string representation of a GitRepository.
#GitRepositoryKind: "GitRepository"

// GoGitImplementation for performing Git operations using go-git.
#GoGitImplementation: "go-git"

// LibGit2Implementation for performing Git operations using libgit2.
#LibGit2Implementation: "libgit2"

// IncludeUnavailableCondition indicates one of the includes is not
// available. For example, because it does not exist, or does not have an
// Artifact.
// This is a "negative polarity" or "abnormal-true" type, and is only
// present on the resource if it is True.
#IncludeUnavailableCondition: "IncludeUnavailable"

// GitRepositorySpec specifies the required configuration to produce an
// Artifact for a Git repository.
#GitRepositorySpec: {
	// URL specifies the Git repository URL, it can be an HTTP/S or SSH address.
	// +kubebuilder:validation:Pattern="^(http|https|ssh)://.*$"
	// +required
	url: string @go(URL)

	// SecretRef specifies the Secret containing authentication credentials for
	// the GitRepository.
	// For HTTPS repositories the Secret must contain 'username' and 'password'
	// fields for basic auth or 'bearerToken' field for token auth.
	// For SSH repositories the Secret must contain 'identity'
	// and 'known_hosts' fields.
	// +optional
	secretRef?: null | meta.#LocalObjectReference @go(SecretRef,*meta.LocalObjectReference)

	// Interval at which to check the GitRepository for updates.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +required
	interval: metav1.#Duration @go(Interval)

	// Timeout for Git operations like cloning, defaults to 60s.
	// +kubebuilder:default="60s"
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// Reference specifies the Git reference to resolve and monitor for
	// changes, defaults to the 'master' branch.
	// +optional
	ref?: null | #GitRepositoryRef @go(Reference,*GitRepositoryRef)

	// Verification specifies the configuration to verify the Git commit
	// signature(s).
	// +optional
	verify?: null | #GitRepositoryVerification @go(Verification,*GitRepositoryVerification)

	// Ignore overrides the set of excluded patterns in the .sourceignore format
	// (which is the same as .gitignore). If not provided, a default will be used,
	// consult the documentation for your version to find out what those are.
	// +optional
	ignore?: null | string @go(Ignore,*string)

	// Suspend tells the controller to suspend the reconciliation of this
	// GitRepository.
	// +optional
	suspend?: bool @go(Suspend)

	// GitImplementation specifies which Git client library implementation to
	// use. Defaults to 'go-git', valid values are ('go-git', 'libgit2').
	// Deprecated: gitImplementation is deprecated now that 'go-git' is the
	// only supported implementation.
	// +kubebuilder:validation:Enum=go-git;libgit2
	// +kubebuilder:default:=go-git
	// +optional
	gitImplementation?: string @go(GitImplementation)

	// RecurseSubmodules enables the initialization of all submodules within
	// the GitRepository as cloned from the URL, using their default settings.
	// +optional
	recurseSubmodules?: bool @go(RecurseSubmodules)

	// Include specifies a list of GitRepository resources which Artifacts
	// should be included in the Artifact produced for this GitRepository.
	include?: [...#GitRepositoryInclude] @go(Include,[]GitRepositoryInclude)

	// AccessFrom specifies an Access Control List for allowing cross-namespace
	// references to this object.
	// NOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092
	// +optional
	accessFrom?: null | acl.#AccessFrom @go(AccessFrom,*acl.AccessFrom)
}

// GitRepositoryInclude specifies a local reference to a GitRepository which
// Artifact (sub-)contents must be included, and where they should be placed.
#GitRepositoryInclude: {
	// GitRepositoryRef specifies the GitRepository which Artifact contents
	// must be included.
	repository: meta.#LocalObjectReference @go(GitRepositoryRef)

	// FromPath specifies the path to copy contents from, defaults to the root
	// of the Artifact.
	// +optional
	fromPath?: string @go(FromPath)

	// ToPath specifies the path to copy contents to, defaults to the name of
	// the GitRepositoryRef.
	// +optional
	toPath?: string @go(ToPath)
}

// GitRepositoryRef specifies the Git reference to resolve and checkout.
#GitRepositoryRef: {
	// Branch to check out, defaults to 'master' if no other field is defined.
	// +optional
	branch?: string @go(Branch)

	// Tag to check out, takes precedence over Branch.
	// +optional
	tag?: string @go(Tag)

	// SemVer tag expression to check out, takes precedence over Tag.
	// +optional
	semver?: string @go(SemVer)

	// Name of the reference to check out; takes precedence over Branch, Tag and SemVer.
	//
	// It must be a valid Git reference: https://git-scm.com/docs/git-check-ref-format#_description
	// Examples: "refs/heads/main", "refs/tags/v0.1.0", "refs/pull/420/head", "refs/merge-requests/1/head"
	// +optional
	name?: string @go(Name)

	// Commit SHA to check out, takes precedence over all reference fields.
	//
	// This can be combined with Branch to shallow clone the branch, in which
	// the commit is expected to exist.
	// +optional
	commit?: string @go(Commit)
}

// GitRepositoryVerification specifies the Git commit signature verification
// strategy.
#GitRepositoryVerification: {
	// Mode specifies what Git object should be verified, currently ('head').
	// +kubebuilder:validation:Enum=head
	mode: string @go(Mode)

	// SecretRef specifies the Secret containing the public keys of trusted Git
	// authors.
	secretRef: meta.#LocalObjectReference @go(SecretRef)
}

// GitRepositoryStatus records the observed state of a Git repository.
#GitRepositoryStatus: {
	// ObservedGeneration is the last observed generation of the GitRepository
	// object.
	// +optional
	observedGeneration?: int64 @go(ObservedGeneration)

	// Conditions holds the conditions for the GitRepository.
	// +optional
	conditions?: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)

	// URL is the dynamic fetch link for the latest Artifact.
	// It is provided on a "best effort" basis, and using the precise
	// GitRepositoryStatus.Artifact data is recommended.
	// +optional
	url?: string @go(URL)

	// Artifact represents the last successful GitRepository reconciliation.
	// +optional
	artifact?: null | apiv1.#Artifact @go(Artifact,*apiv1.Artifact)

	// IncludedArtifacts contains a list of the last successfully included
	// Artifacts as instructed by GitRepositorySpec.Include.
	// +optional
	includedArtifacts?: [...null | apiv1.#Artifact] @go(IncludedArtifacts,[]*apiv1.Artifact)

	// ContentConfigChecksum is a checksum of all the configurations related to
	// the content of the source artifact:
	//  - .spec.ignore
	//  - .spec.recurseSubmodules
	//  - .spec.included and the checksum of the included artifacts
	// observed in .status.observedGeneration version of the object. This can
	// be used to determine if the content of the included repository has
	// changed.
	// It has the format of `<algo>:<checksum>`, for example: `sha256:<checksum>`.
	//
	// Deprecated: Replaced with explicit fields for observed artifact content
	// config in the status.
	// +optional
	contentConfigChecksum?: string @go(ContentConfigChecksum)

	// ObservedIgnore is the observed exclusion patterns used for constructing
	// the source artifact.
	// +optional
	observedIgnore?: null | string @go(ObservedIgnore,*string)

	// ObservedRecurseSubmodules is the observed resource submodules
	// configuration used to produce the current Artifact.
	// +optional
	observedRecurseSubmodules?: bool @go(ObservedRecurseSubmodules)

	// ObservedInclude is the observed list of GitRepository resources used to
	// to produce the current Artifact.
	// +optional
	observedInclude?: [...#GitRepositoryInclude] @go(ObservedInclude,[]GitRepositoryInclude)

	meta.#ReconcileRequestStatus
}

// GitOperationSucceedReason signals that a Git operation (e.g. clone,
// checkout, etc.) succeeded.
#GitOperationSucceedReason: "GitOperationSucceeded"

// GitOperationFailedReason signals that a Git operation (e.g. clone,
// checkout, etc.) failed.
#GitOperationFailedReason: "GitOperationFailed"

// GitRepository is the Schema for the gitrepositories API.
#GitRepository: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #GitRepositorySpec @go(Spec)

	// +kubebuilder:default={"observedGeneration":-1}
	status?: #GitRepositoryStatus @go(Status)
}

// GitRepositoryList contains a list of GitRepository objects.
// +kubebuilder:object:root=true
#GitRepositoryList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#GitRepository] @go(Items,[]GitRepository)
}
