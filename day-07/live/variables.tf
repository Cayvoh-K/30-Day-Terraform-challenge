variable "instance_type" {
    type = map(string)

    default = {
        dev = "t3.micro"
        staging = "t3.small"
        production = "t3.medium"
    }
}