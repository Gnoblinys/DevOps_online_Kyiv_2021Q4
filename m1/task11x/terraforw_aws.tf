provider "aws" {
    access_key = "AKIAZE2CJUAJLITM6LP6"
    secret_key = "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"
    region = "us-east-1"

}

resource "aws_instance" "WEB1" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
}