
## Introduction

[RTFM](https://docs.ansible.com/ansible/latest/getting_started/index.html) be aware of various differences between.

## Terminology

From [getting started - index](https://docs.ansible.com/ansible/latest/getting_started/index.html)  - Ansible automates the management of remote systems and controls their desired state. A basic Ansible environment has three main components:
- Control node 
	- A system on which Ansible is installed. You run Ansible commands such as `ansible` or `ansible-inventory` on a control node.
- Managed node
	- A remote system, or host, that Ansible controls.
- Inventory
	- A list of managed nodes that are logically organized. You create an inventory on the control node to describe host deployments to Ansible.

From [getting started playbook](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html) - Playbooks are automation blueprints, in `YAML` format, that Ansible uses to deploy and configure managed nodes.
- Playbook
	- A list of plays that define the order in which Ansible performs operations, from top to bottom, to achieve an overall goal.
- Play
	- An ordered list of tasks that maps to managed nodes in an inventory.
- Task 
	- A list of one or more modules that defines the operations that Ansible performs.
- Module 
	- A unit of code or binary that Ansible runs on managed nodes. Ansible modules are grouped in collections with a [Fully Qualified Collection Name (FQCN)](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html#term-Fully-Qualified-Collection-Name-FQCN) for each module.

## References

[Youtube Conda - Building a Home Lab Part 3: Ansible and Apache](https://www.youtube.com/watch?v=uQReydeYMe4&list=PLDrNMcTNhhYoEjHYs0ZBfcSE7Hw46BeTA&index=3)
[getting started playbook](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html)
[getting started - index](https://docs.ansible.com/ansible/latest/getting_started/index.html) 