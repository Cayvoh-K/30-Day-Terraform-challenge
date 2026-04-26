variable "user_names" {
    type = set(string)
    default = ["alice", "bob", "charlie"]
}

resource "aws_iam_user" "example" {
    for_each = var.user_names
    name = each.value
}

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}