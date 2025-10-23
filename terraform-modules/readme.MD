# Aws ec2 instance creation

This module is to create aws ec2 instance 

# Inputs
* ami_id (mandatory) -> use which is need for your instance
* instance_type (mandatory) -> choose type of instance from t2.micro, t2.small, t2.medium
* sg_id (mandatory) -> select the list of security groups to be assigned for your instance
* tags (optional) -> tags can be optional, if you apply it over rides the defaults

# Outputs
* public_ip -> gives public ip of the instance created.
* private_ip -> gives private ip of the instance created.
