output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_id1" {
  value = aws_subnet.public-1.id
}
output "public_subnet_id2" {
  value = aws_subnet.public-2.id
}
output "private_subnet_id" {
  value = aws_subnet.private_1.id
}
output "private_subnet_id2" {
  value = aws_subnet.private_2.id
}
output "internet_gateway_id" {
  value = aws_internet_gateway.internet-gateway.id
}
