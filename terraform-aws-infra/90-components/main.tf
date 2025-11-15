module "components" {
    for_each = var.components
    source = "../terraform-roboshop-components"
    component = each.key
    instance_type = var.instance_type
    priority = each.value.priority
}