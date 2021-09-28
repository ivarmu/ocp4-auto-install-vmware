ocp4-post-operatorhub
=========

This role is used to manage the Operator Hub configurations as new needs arises.

Requirements
------------

The following ansible collections are required:

 - community.kubernetes

Role Variables
--------------

This role is currently used to disable the Operator Hub Default Sources, usefull when you deploy an OCP4 cluster in a disconnected environment.

Dependencies
------------

The only required dependency is the collection community.kubernetes, listed above.

Example Playbook
----------------

    - hosts: servers
      tasks:
        - name: '[OCP4-AUTO-INSTALL][POST-INSTALL] Disable Operator Hub Default Sources'
          include_role:
            name: "ocp4-post-operatorhub"
          when:
            - disable_operator_hub is defined
            - disable_operator_hub | bool
          tags:
            disable_operator_hub_default_sources

License
-------

GPLv3

Author Information
------------------

Ivan Aragonés - iaragone@redhat.com
