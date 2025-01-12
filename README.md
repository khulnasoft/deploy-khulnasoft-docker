# Khulnasoft with Docker Compose

[![khulnasoft: search](https://img.shields.io/badge/khulnasoft-search-brightgreen.svg)](https://khulnasoft.com/github.com/khulnasoft/deploy-khulnasoft-docker) [![Build status](https://badge.buildkite.com/e60f9ffcafd68882d3db6fe5e33567e3a111d391a554d50d82.svg)](https://buildkite.com/khulnasoft/deploy-khulnasoft-docker)

This repository is the deployment reference for [deploying Khulnasoft with Docker Compose](https://docs.khulnasoft.com/admin/install/docker-compose).

> 🚨 IMPORTANT: When upgrading Khulnasoft, please check [upgrading docs](https://docs.khulnasoft.com/admin/updates/docker_compose) to check if any manual migrations are necessary.
>
> The `master` branch tracks development. Use the branch of this repository corresponding to the
> version of Khulnasoft you wish to deploy, e.g. `git checkout 3.19`.

For product and [pricing](https://about.khulnasoft.com/pricing/) information, visit
[about.khulnasoft.com](https://about.khulnasoft.com) or [contact
us](https://about.khulnasoft.com/contact/sales) for more information. If you're just starting out,
we recommend running Khulnasoft as a [single Docker
container](https://docs.khulnasoft.com/#quickstart-guide) or using [Docker
Compose](https://docs.khulnasoft.com/admin/install/docker-compose). Migrating to Khulnasoft on
Kubernetes is easy later.

## Is Docker Compose the right deployment type for me?

Please see [our docs](https://docs.khulnasoft.com/admin/install) for comparisons of deployment types and our resource estimator.

## Contributing

We've made our deployment configurations open source to better serve our customers' needs. If there is anything we can do to make deploying Khulnasoft easier just [open an issue (in khulnasoft/khulnasoft)](https://github.com/khulnasoft/khulnasoft/issues/new?assignees=&labels=deploy-khulnasoft-docker&title=%5Bdeploy-khulnasoft-docker%5D) or a pull request and we will respond promptly!

## Questions & Issues

[Open an issue (in khulnasoft/khulnasoft)](https://github.com/khulnasoft/khulnasoft/issues/new?assignees=&labels=deploy-khulnasoft&template=deploy-khulnasoft.md&title=%5Bdeploy-khulnasoft%5D) or contact us (support@khulnasoft.com), we are happy to help!

## Pure-Docker Khulnasoft cluster deployment reference

What if your organization wants a multi-machine deployment without using Kubernetes?
What if you use a different container management platform, for example?
Anyone using a container management platform other than Kubernetes (Netflix's [Titus](https://netflix.github.io/titus/), Apache's [Mesos](http://mesos.apache.org/documentation/latest/docker-containerizer/), etc.) can use our [Pure-Docker Khulnasoft cluster deployment reference](./pure-docker/README.md) to deploy Khulnasoft.

---

### Contributing 

#### Releasing 

Please see the [documentation](https://go/releases).
