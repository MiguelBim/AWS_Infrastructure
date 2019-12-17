
data "aws_ami" "ubuntu" {
    most_recent = true
    # This parameter is used to use the most recent resource from the multiple results that come back from the
    # AMI search

    # Search filter
    filter{
        name = "name" # Name of the filter
        values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"] 
        # Values used by the filter. Selecting to bring up the ubuntu Image
        # The * is used as a wildcar 
    } 

    filter{
        name = "virtualization-type"
        values = ["hvm"]
        # The values have to be in brackets because they are a list of attributes.
    }

    # Last parameter to stablish. Who the owners are
    owners = ["099720109477"]
}

# The result retrieve is used below to lunch the instance
resource "aws_instance" "server" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"

    tags = {
        Name = "Identifier"
    }
}
