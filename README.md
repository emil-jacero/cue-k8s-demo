# Demo of CUE and k8s

## Summary

This demo aims to showcase some of the features of CUE and how they can improve the life of a kubernetes administrator.

## Cue

First set the working dir. This should be the root of the git repo!

```shell
export WDIR=$(pwd)
```

Enable the experimental cue modules support.

```shell
export CUE_EXPERIMENT=modules
```

Set the OCI registry URL.

```shell
export CUE_REGISTRY=localhost:5000/cue
```

### Registry

Pull and run a docker registry.

```shell
docker run -d -p 5000:5000 --restart always --name registry registry:2
```

Destroy registry to cleanup.

```shell
docker rm -f registry
```

### Cue Modules

Upload supporting modules to the OCI registry. These modules are utilized by apps, bundles, flavors and cluster configurations.
They are mostly schemas and therefor are very generalized.

```shell
# Modules
cd $WDIR/modules/k8s
cue mod tidy
cue mod publish v1.0.0

cd $WDIR/modules/fluxv2
cue mod tidy
cue mod publish v1.0.0

cd $WDIR/modules/module
cue mod tidy
cue mod publish v0.0.1
```
