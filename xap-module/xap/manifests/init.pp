# Class: xap
# ===========================
#
# class for installing xap 12.3.0
#
# Parameters
# ----------
#
# Variables
# ----------
#
# Examples
# --------
#
# Authors
# -------
#
# Author Sudip Bhattacharya <sudip.bhattacharya@gigaspaces.com>
#
# Copyright
# ---------
#
# Copyright 2018 GigaSpaces Inc.
#

class xap {

  class { 'xap::params': }  ->
  class { 'xap::base': }    ->
  class { 'xap::users': }   ->
  class { 'xap::install': } ->
  class { 'xap::scripts': } ->
  notify { 'xap installation completed': }

}
