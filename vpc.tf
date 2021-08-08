# data "aws_vpc" "default" {
#   id = "vpc-af3030d7"
# }

# data "aws_route_table" "default" {
#   route_table_id = "rtb-4de50837"
# }

# data "aws_subnet" "us-west-2a" {
#   id = "subnet-54970a2c"
# }

# data "aws_subnet" "us-west-2b" {
#   id = "subnet-c717a88d"
# }

# data "aws_subnet" "us-west-2c" {
#   id = "subnet-8e98f4d3"
# }

# data "aws_subnet" "us-west-2d" {
#   id = "subnet-d316f2f9"
# }

# resource "aws_subnet" "us-west-2a" {
#   cidr_block = "172.31.16.0/20"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "us-west-2a"
#     "kubernetes/cluster/default" = "shared"
#     "kubernetes.io/role/elb" = "1"
#   }
#   vpc_id = data.aws_vpc.default.id
# }

# resource "aws_subnet" "us-west-2b" {
#   cidr_block = "172.31.32.0/20"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "us-west-2b"
#     "kubernetes/cluster/default" = "shared"
#     "kubernetes.io/role/elb" = "1"
#   }
#   vpc_id = data.aws_vpc.default.id
# }

# resource "aws_subnet" "us-west-2c" {
#   cidr_block = "172.31.0.0/20"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "us-west-2c"
#     "kubernetes/cluster/default" = "shared"
#     "kubernetes.io/role/elb" = "1"
#   }
#   vpc_id = data.aws_vpc.default.id
# }

# resource "aws_subnet" "us-west-2d" {
#   cidr_block = "172.31.48.0/20"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "us-west-2d"
#     "kubernetes/cluster/default" = "shared"
#     "kubernetes.io/role/elb" = "1"
#   }
#   vpc_id = data.aws_vpc.default.id
# }

# resource "aws_route_table_association" "us-west-2a" {
#   subnet_id      = data.aws_subnet.us-west-2a.id
#   route_table_id = data.aws_route_table.default.id
# }

# resource "aws_route_table_association" "us-west-2b" {
#   subnet_id      = data.aws_subnet.us-west-2b.id
#   route_table_id = data.aws_route_table.default.id
# }

# resource "aws_route_table_association" "us-west-2c" {
#   subnet_id      = data.aws_subnet.us-west-2c.id
#   route_table_id = data.aws_route_table.default.id
# }

# resource "aws_route_table_association" "us-west-2d" {
#   subnet_id      = data.aws_subnet.us-west-2d.id
#   route_table_id = data.aws_route_table.default.id
# }

# resource "aws_vpc_dhcp_options" "dns_resolver" {
#   domain_name = "us-west-2.compute.internal"
#   domain_name_servers = ["AmazonProvidedDNS"]
# }

# resource "aws_vpc_dhcp_options_association" "dns_resolver" {
#   vpc_id          = data.aws_vpc.default.id
#   dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
# }
