
.PHONY: tmp
tmp:
	helm show chart oci://ghcr.io/pbasov/oot/charts/kubevirt-standalone-cp --version 1.4.0
	@(echo "-----")
	helm show all oci://ghcr.io/pbasov/oot/charts/kubevirt-standalone-cp --version 1.4.0
	@(echo "-----")
	helm show values oci://ghcr.io/pbasov/oot/charts/kubevirt-standalone-cp --version 1.4.0

.PHONY: tags.list
tags.list: ## List all exists tags (git)
	@(git tag | sort -rt "." -k1,1n -k2,2n -k3,3n | tail -r)

.PHONY: help
help: ## List all make targets with description
	@grep -h -E '^[.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: list
list: ## List all make targets
	@${MAKE} -pRrn : -f $(MAKEFILE_LIST) 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | sort