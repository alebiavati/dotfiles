#!/bin/bash

# install traefik repository
setup_traefik () {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/zerooneagency/traefik/master/bin/traefik)"
}
