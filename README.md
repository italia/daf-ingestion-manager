# Ingestion Manager

The ingestion manager given a dataset definition from the catalog-manager
creates the needed NIFI processor to instrument the ingestion of the dataset.

## Requirements
Inside the [build.sbt](./build.sbt) you'll find the configuration to deploy the docker image to nexus.

```
dockerBaseImage := "anapsix/alpine-java:8_jdk_unlimited"
dockerCommands := dockerCommands.value.flatMap {
  case cmd@Cmd("FROM", _) => List(cmd,
    Cmd("RUN", "apk update && apk add bash krb5-libs krb5"),
    Cmd("RUN", "ln -sf /etc/krb5.conf /opt/jdk/jre/lib/security/krb5.conf")
  )
  case other => List(other)
}
dockerEntrypoint := Seq(s"bin/${name.value}", "-Dconfig.file=conf/production.conf")
dockerExposedPorts := Seq(9000)
dockerRepository := Option("10.98.74.120:5000")
```

## Setup

In order to start developing do the following steps


```bash
# publish locally the daf-common project
$ cd ../common && sbt publishLocal

# publish locally the catalog manager
$ cd ../catalog-manager && sbt publishLocal

$ sbt docker:publish

```

## deploy

1. `cd kubernetes`
2. setup `application.conf` on glusterfs
3. `sh deploy.sh`
4. check the kubernetes dashboard for errors.
