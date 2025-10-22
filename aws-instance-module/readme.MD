# Aws ec2 instance creation

Creting ec2 instance

# Inputs
* ami_id (optional) use the required ami id for creating the c2 instance
* instance_type (mandatory) use type from the list defined as t2.micro, t2.small, t2.medium
* sg_id (mandatory) use the list of security groups to be attached to ec2 instance
* tags (optional) using tags will over ride the empty tags defined

# Outputs
* public_ip -> gets the public ip of the instance created
* private_ip -> gets the private ip of the instance created